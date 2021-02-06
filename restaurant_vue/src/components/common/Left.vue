<template>
    <el-aside width="15%" style="background-color: rgb(238, 241, 246);height:100% ">
        <el-menu :default-openeds="['1', '2']" :default-active="$route.path">
            <el-submenu index="1">
                <template slot="title"><i class="el-icon-menu"></i>餐厅管理</template>
                    <el-menu-item index="/check_apply" v-if="limited==1" @click="check_apply">审核餐厅申请</el-menu-item>
                    <el-menu-item index="/lunbo" v-if="limited==1" @click="lunbo">首页轮播管理</el-menu-item>
                    <el-menu-item index="/apply" v-if="storeId==null" @click="toApply">申请开通餐厅</el-menu-item>
                    <el-menu-item index="/category" v-if="storeId!=null" @click="toCategory">菜品分类管理</el-menu-item>
                    <el-menu-item index="/add_menu" v-if="storeId!=null" @click="add_menu">添加菜品</el-menu-item>
                    <el-menu-item index="/menu_list" v-if="storeId!=null" @click="menu">菜品管理</el-menu-item>
                    <el-menu-item index="/order" v-if="storeId!=null" @click="order">餐厅订单</el-menu-item>
                    <el-menu-item index="/food_comment" v-if="storeId!=null" @click="food_comment">菜品评价审核</el-menu-item>
            </el-submenu>
            <el-submenu index="2">
                <template slot="title"><i class="el-icon-menu"></i>信息管理</template>
                <el-menu-item index="/change_info" v-if="storeId!=null" @click="change_info">修改餐厅信息</el-menu-item>
            </el-submenu>
        </el-menu>
    </el-aside>
</template>

<script>
    import cookies from 'vue-cookies'
    export default {
        name: "left",
        data:function () {
            return{
                limited:'',
                storeId:'',
                username:''
            }
        },
        mounted(){
            this.limit();
        },
        methods:{
            limit:function () {
                var user=cookies.get('user_info');
                this.username=user.username;
                this.storeId=user.storeId;
                this.limited=user.limited;
                console.log(user)
            },
            toApply:function () {
              location.href='/apply';
            },
            check_apply:function () {
                location.href='/check_apply'
            },
            toCategory:function () {
                location.href='/category';
            },
            add_menu:function () {
                location.href='/add_menu';
            },
            menu(){
                location.href='/menu_list';
            },
            order(){
                location.href='/order';
            },
            food_comment(){
                location.href='/food_comment';
            },
            change_info(){
                location.href='/change_info';
            },
            lunbo(){
                location.href='/lunbo';
            }
        }
    }
</script>

<style scoped>
    .el-aside {
        color: #333;
    }
</style>