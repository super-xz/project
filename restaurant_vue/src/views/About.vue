<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png">
    <input type="button" v-on:click="sumbit" value="post">
    <input type="button" v-on:click="sumbit2" value="get">
  </div>
</template>

<script>
  // @ is an alias to /src
  import HelloWorld from '@/components/HelloWorld.vue'
  import axios from 'axios'

  export default {
    name: 'Home',
    components: {
      HelloWorld
    },
    methods:{
      sumbit:function () {
        axios({
          method:'post',
          headers:{"Content-Type":'application/x-www-form-urlencoded;charset=UTF-8','X-Requested-With': 'XMLHttpRequest'},
          url:'/api/test',
          data:{
            hello:'hello',
            b:'傻子'
          }
        }).then(function (response) {
          console.log(response.data)
          alert(response.data.hello+response.data.b);
        })
      },
      sumbit2:function () {
        axios({
          method: 'get',
          url: '/api/test2',
          params:{
            hello:123
          }
        }).then(function (response) {
          console.log(response.data)
          alert(response.data);
        })
      }
    }
  }
</script>
