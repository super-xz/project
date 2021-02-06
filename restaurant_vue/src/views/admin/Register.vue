<template>
    <div>
        <div style="display: flex;justify-content: center;">
            <el-card style="width: 400px">
                <div slot="header" class="clearfix">
                    <span>注册</span>
                </div>
            <table>
                <tr>
                    <td>用户名:</td>
                    <td>
                        <el-input v-model="username" placeholder="请输入用户名"></el-input>
                    </td>
                </tr>
                <tr>
                    <td>密码:</td>
                    <td>
                        <el-input type="password" v-model="password" placeholder="请输入密码"></el-input>
                    </td>
                </tr>
                <tr>
                    <td>确认密码:</td>
                    <td>
                        <el-input type="password" v-model="password2" placeholder="请输入密码"></el-input>
                    </td>
                </tr>
                <tr>
                    <td>联系电话</td>
                    <td>
                        <el-input v-model="phone" placeholder="手机号码"></el-input>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <el-button style="width: 300px" type="primary" @click="register">注册</el-button>
                    </td>
                </tr>
            </table>
        </el-card>
    </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import cookies from 'vue-cookies'
    export default {
        name: "Register",
        data(){
            return{
                    username:'',
                    password:'',
                    password2:'',
                    phone:'',
            }
        },
        methods: {
            register() {
                if(this.username==''||this.password==''||this.phone==''){
                    alert('请填写好表单')
                }else {
                    if(this.password!=this.password2){
                        alert("密码不一致");
                    }else {
                        axios.post('/admin/register',{
                            username:this.username,
                            pwd:this.password,
                            phone:this.phone
                        }).then(function (response) {
                            let res=response.data;
                            if(res.flag=='false'){
                                alert(res.msg);
                            }else {
                                alert(res.msg);
                                console.log(res);
                                cookies.set('user_name',res.username,"0");
                                location.href='/';
                            }
                        })
                    }
                }
            }
        }
    }
</script>

<style scoped>
el-input{
    width: 200px;
}
</style>