<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main class="el-main">
                <h5>店铺开通申请</h5>
                <div class="form" v-if="state==0">
                <el-form :model="form" ref="form"  label-width="100px" >
                    <el-form-item label="真实姓名">
                        <el-input maxlength="10" v-model="form.nickname"></el-input>
                    </el-form-item>
                    <el-form-item label="身份证号" >
                        <el-input maxlength="18"  v-model="form.id_card"></el-input>
                    </el-form-item>
                    <el-form-item label="手机号码">
                        <el-input type="tel" maxlength="11" v-model="form.phone"></el-input>
                    </el-form-item>
                    <el-form-item label="店铺名称">
                        <el-input maxlength="10" v-model="form.storename"></el-input>
                    </el-form-item>
                    <el-form-item label="所在城市">
                        <el-input maxlength="10" v-model="form.city" placeholder="如 广州"></el-input>
                    </el-form-item>
                    <el-form-item label="区县店位">
                        <el-input maxlength="10" v-model="form.location" placeholder="如（从化华软店）"></el-input>
                    </el-form-item>
                    <el-form-item label="经度">
                        <el-input maxlength="6" v-model="form.city_j" ></el-input>
                    </el-form-item>
                    <el-form-item label="维度">
                        <el-input maxlength="6" v-model="form.city_w" ></el-input>
                    </el-form-item>
                    <el-button type="primary" round @click="submit">提交申请</el-button>
                </el-form>
                </div>
                <div class="step" v-if="state!=0">
                    <el-steps :space="300" :active="Number(state)" finish-status="success" align-center>
                    <el-step title="提交申请"></el-step>
                    <el-step title="审核中"></el-step>
                    <el-step title="审核通过"></el-step>
                </el-steps>
                </div>
            </el-main>
        </div>
    </el-container>

</template>

<style>
    .main{
        width: 85%;
    }
    .form{
        width: 500px;
        margin: 0 auto;
    }
    .step{
        width: 500px;
        margin: 0 auto;
    }
</style>

<script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    import cookies from 'vue-cookies'
    import axios from 'axios'
    export default {
        name:'apply',
        data() {
            return {
                username:'',
                state: '',
                storeid:'',
                form:{
                    storename:'',
                    nickname:'',
                    phone:'',
                    id_card:'',
                    city:'',
                    location:'',
                    city_j:'',
                    city_w:'',

                },
            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted(){
            this.check_user();
        },
        methods: {
            check_user:function(){
              var user=cookies.get('user_info');
              this.username=user.username;
              axios({
                  method: 'get',
                  url: '/admin/checkstore',
                  params:{
                      username:this.username
                  }
              }).then((res) =>{
                  if(res.data==null){
                      this.state='0';
                      this.storeid='0'
                  }else {
                  this.state=res.data.state;
                  this.storeid=res.data.storeId
                  console.log(res.data);
                  }
              })
              console.log(this.username);
            },
            submit:function () {
                axios.post('/admin/store_apply',{
                    username:this.username,
                    storename:this.form.storename,
                    nickname:this.form.nickname,
                    phone:this.form.phone,
                    id_card:this.form.id_card,
                    city:this.form.city,
                    location:this.form.location,
                    city_j:this.form.city_j,
                    city_w:this.form.city_w,
                }).then(function (res) {
                    console.log(res.data);
                })
            }
        }

    };
</script>

