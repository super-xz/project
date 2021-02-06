import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/admin/Login.vue'
import Register from '../views/admin/Register'
import Apply from '../views/restaurant/apply'
import check_Apply from '../views/restaurant/check_apply'


Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/apply',
    name: 'Apply',
    component:Apply
  },
  {
    path: '/check_apply',
    name: 'check_Apply',
    component:check_Apply
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path:'/category',
    name:'Category',
    component: resolve => require(['../views/restaurant/category'],resolve),
  },
  {
    path:'/add_menu',
    name:'Add_menu',
    component: resolve => require(['../views/restaurant/add_menu'],resolve),
  },
  {
    path:'/menu_list',
    name:'Menu_list',
    component: resolve => require(['../views/restaurant/menu_list'],resolve),
  },
  {
    path:'/order',
    name:'Order',
    component: resolve => require(['../views/restaurant/order'],resolve),
  },
  {
    path:'/food_comment',
    name:'Food_comment',
    component: resolve => require(['../views/restaurant/food_comment'],resolve),
  },
    {
        path:'/change_info',
        name:'Change_info',
        component: resolve => require(['../views/user/change_info'],resolve),
    },
  {
    path:'/lunbo',
    name:'Lunbo',
    component: resolve => require(['../views/restaurant/lunbo'],resolve),
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
