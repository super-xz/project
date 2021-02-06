<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main style="display: flex;justify-content: center;align-content: center">
                <div class="body">
                    <div class="box">
                        <el-upload
                                class="upload-demo upload"
                                action="/restaurant/store_img"
                                :file-list="fileList"
                                :on-success="success_up"
                                :on-remove="handleRemove"
                                :limit="1"
                                 ref="upload"
                                :before-upload="beforeAvatarUpload"
                                list-type="picture">
                            <el-button size="small" type="primary">点击上传</el-button>
                            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过1MB</div>
                        </el-upload>
                        <div class="label">餐厅头像：<span v-if="imgurl==''||imgurl==null"> 为空</span> </div>
                        <img v-if="imgurl" :src="imgurl" style="width: 200px;height: 200px">
                        <el-button type="primary" v-if="change" @click="confirm_img">提交修改</el-button>
                    </div>
                    <el-form  class="form" >
                        <el-form-item label="餐厅名称"   class="lab">
                            <el-input v-model="store_info.storename" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item label="所在城市"   class="lab">
                            <el-input v-model="store_info.city" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item label="详细店名"   class="lab">
                            <el-input v-model="store_info.location" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item label="所在经度"   class="lab">
                            <el-input v-model="store_info.city_j" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item label="所在维度"   class="lab">
                            <el-input v-model="store_info.city_w" autocomplete="off"></el-input>
                        </el-form-item>
                        <el-form-item label="店铺状态"   class="lab">
                            <el-switch
                                    v-model="store_info.store_status"
                                    active-color="#13ce66"
                                    :active-value="1"
                                    :inactive-value="0"
                                    inactive-color="#ff4949"
                                    @change="static">
                            </el-switch>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="onSubmit">提交修改</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </el-main>
        </div>
    </el-container>

</template>

<style>
    .main{
        width: 88%;
    }
    .body{
        width: 70%;
        display: flex;
    }
    .form{
        width: 70%;

    }
    .lab{
        display: flex;
        flex-direction: row;
        align-content: center;
        justify-content: center;
    }
</style>

<script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    import cookies from 'vue-cookies'
    import axios from 'axios'
    export default {
        name:'change_info',
        data() {
            return {
                store_info:[],
                fileList:[],
                change:false,
                imgurl:''
            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted() {
            this.get_info()
        },
        methods:{
            get_info(){
                var cookie = cookies.get('user_info');
                var storeId = cookie.storeId;
                axios({
                    method: 'get',
                    url: '/restaurant/get_info',
                    params: {
                        storeId: storeId
                    }
                }).then((res) => {
                    this.store_info = res.data;
                    this.imgurl=this.store_info.store_img
                    console.log(this.store_info)
                })
            },
            handleRemove(file, fileList) {
                 axios.post('/restaurant/store_imgdel',{
                     imgurl:this.imgurl
                 }).then((res)=>{
                     this.$message.success(res.data);
                     this.change=false;
                     this.imgurl=this.store_info.store_img
                 })
            },
            success_up(res){
                this.imgurl=res;
                this.change=true;
                this.$message.success('上传成功')
            },
            beforeAvatarUpload(file){
                const isLt2M = file.size / 1024 / 1024 < 1;
                if (!isLt2M) {
                    this.$message.error('上传图片大小不能超过 1MB!');
                }
                return  isLt2M;
            },
            confirm_img(){
                var cookie = cookies.get('user_info');
                var storeId = cookie.storeId;
                axios.post('/restaurant/confirm_img',{
                    imgurl:this.imgurl,
                    storeId:storeId,
                    oldimg:this.store_info.store_img
                }).then((res)=>{
                    this.$message.success(res.data);
                    this.$refs.upload.clearFiles()
                    this.change=false;
                })
            },
            static(){
                this.store_info.store_status==0?'"+this.store_info.store_status=1+"':'"+this.store_info.store_status=0+"'
              console.log(this.store_info)
            },
            onSubmit(){
                var cookie = cookies.get('user_info');
                var storeId = cookie.storeId;
                console.log(this.store_info)
                axios.post('/restaurant/change_storeinfo',{
                    store_info:this.store_info,
                    storeId:storeId,
                }).then((res)=>{
                    this.$message.success('修改成功');
                })
            }
        }
    };
</script>

