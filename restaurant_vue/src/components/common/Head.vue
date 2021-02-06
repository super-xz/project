<template>
    <el-header style="text-align: right; font-size: 12px;width: 100%">
        <el-dropdown>
            <i class="el-icon-setting" style="margin-right: 15px"></i>
            <el-dropdown-menu slot="dropdown">
                <el-dropdown-item><div @click="logout">注销</div></el-dropdown-item>
            </el-dropdown-menu>
        </el-dropdown>
        <span>{{user_name}}</span>
    </el-header>
</template>

<script>
    import cookies from 'vue-cookies'
    export default {
        name: "Head",
        data:function () {
            return{
                user_name:'',
            }
        },
        mounted() {
            this.isLogin();
        },
        methods:{
            isLogin:function(){
                var user=cookies.get('user_info');
                if(user!=null){
                    this.user_name=user.username
                }else {
                    location.href = '/login'
                }
            },
            logout:function () {
                cookies.remove('user_info');
                this.isLogin();
            }
        }
    }
</script>

<style scoped>
    .el-header {
        background-color: #B3C0D1;
        color: #333;
        line-height: 60px;
    }
</style>