<template>
    <div>
        <div style="display: flex;justify-content: center;margin-top: 10%">
            <el-card style="width: 400px">
                <div slot="header" class="clearfix">
                    <span>登录</span>
                </div>
                <table>
                    <tr>
                        <td>用户名</td>
                        <td>
                            <el-input v-model="username" placeholder="请输入用户名"></el-input>
                        </td>
                    </tr>
                    <tr>
                        <td>密码</td>
                        <td>
                            <el-input type="password" v-model="password" placeholder="请输入密码"></el-input>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            <div class="code" @click="refreshCode">
                                <yzm :identifyCode="identifyCode"></yzm>
                            </div>
                        </td>
                        <td colspan="1">
                            <el-input v-model="code" placeholder="请输入验证码"></el-input>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <el-button style="width: 300px" type="primary" @click="login">登录</el-button>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <el-button style="width: 300px"  ><router-link to="/register">注册</router-link></el-button>
                        </td>
                    </tr>
                </table>
            </el-card>
        </div>
    </div>
</template>

<script>
    import yzm from '@/components/yzm.vue'
    import axios from 'axios'
    import cookies from 'vue-cookies'
    export default {
        name: "login",
        data:function(){
            return{
                username:'',
                password:'',
                identifyCodes: "1234567890",
                identifyCode: "",
                code:''
            }
        },
        components:{
            yzm
        },
        mounted(){
            this.identifyCode = "";
            this.makeCode(this.identifyCodes, 4);
        },
        methods: {
            login: function () {
                if (this.username == '' || this.password == '') {
                    alert("用户名和密码不能为空");
                } else {
                    if (this.code == '' || this.code != this.identifyCode) {
                        alert("验证码错误");
                        return;
                    } else {
                        axios.post('/admin/login', {
                            username: this.username,
                            password: this.password
                        }).then( (response)=> {
                            let res = response.data;
                            if (res.flag == false) {
                                alert(res.msg);
                                this.refreshCode();
                                return;
                            } else {
                                alert(res.msg);
                                console.log(res);console.log(res.cookies.limited);
                                cookies.set('user_info',res.cookies,"3h");
                                location.href = '/'
                            }
                        }).catch(function (error) {
                            console.log(error);
                        })
                     }
               }
            },
            randomNum(min, max) {
                return Math.floor(Math.random() * (max - min) + min);
            },
            refreshCode() {
                this.identifyCode = "";
                this.makeCode(this.identifyCodes, 4);
            },
            makeCode(o, l) {
                for (let i = 0; i < l; i++) {
                    this.identifyCode += this.identifyCodes[
                        this.randomNum(0, this.identifyCodes.length)
                        ];
                }
                //console.log(this.identifyCode);
            }
        }
    }
</script>

<style scoped>
    .code{
        width: 112px;
        height: 43.6px;
        margin: 0 auto;
    }

</style>
