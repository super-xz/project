<template>
  <el-container>
    <admin-left></admin-left>
    <div class="main">
      <adminHead></adminHead><br>
      <el-main class="content">
        <h4>欢迎来到餐厅管理后台系统哦</h4>
      </el-main>
    </div>
    </el-container>

</template>

  <style>
.main{
width: 88%;
}
.content{
  position: relative;
  top: 20%;
}
  </style>

  <script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    export default {
      data() {

        return {
          user_name:'',
        }
      },
      components: {
        adminHead,
        adminLeft
      },

    };
  </script>

