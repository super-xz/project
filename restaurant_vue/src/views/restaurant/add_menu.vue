<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main>
                <div class="box">
                    <div class="label">菜品名称:</div>
                    <el-input v-model="foodname" class="input"></el-input>
                </div>
                <div class="box">
                    <div class="label">菜品描述:</div>
                    <el-input v-model="describe" class="input"></el-input>
                </div>
                <div class="box">
                    <div class="label">价格:</div>
                    <el-input v-model="price" class="input" type="number"></el-input>
                </div>
                <div class="box">
                    <div class="label">库存状态:</div>
                    <el-input v-model="state" class="input" type="number"></el-input>
                </div>
                <div class="box">
                    <div class="label">折扣:</div>
                    <el-input v-model="discount" class="input" type="number"></el-input>
                </div>
                <div class="box">
                    <div class="label">分类:</div>
                    <el-select v-model="category" placeholder="请选择">
                        <el-option
                                v-for="item in options"
                                :key="item.cid"
                                :label="item.category"
                                :value="item.cid">
                        </el-option>
                    </el-select>
                </div>
                <div class="box">
                    <div class="label">上传菜品图片：</div>
                <el-upload
                        class="upload-demo upload"
                        action="/restaurant/uploadimg"
                        :on-success="success_up"
                        :on-remove="handleRemove"
                        :limit="1"
                        :before-upload="beforeAvatarUpload"
                        list-type="picture">
                    <el-button size="small" type="primary">点击上传</el-button>
                    <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过1MB</div>
                </el-upload>
                </div>
                <el-button @click="add_food">添加菜品</el-button>
            </el-main>
        </div>
    </el-container>

</template>

<style>
    .main{
        width: 88%;
        text-align: center;

    }
    .upload{
        width: 50%;

    }
    .box{
        display: flex;margin-left: 15%;margin-bottom: 30px
    }
    .label{
        width: 20%;text-align: right;margin-right: 20px;
    }
    .input{
        width: 50%;
    }
</style>

<script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    import axios from 'axios'
    import cookies from 'vue-cookies'
    export default {
        name:'add_menu',
        data() {
            return {
                fileList: [],
                imgurl:'',
                foodname:'',
                price:'',
                describe:'',
                state:null,
                category:'',
                discount:'',
                options: [],

            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted(){
            this.check_category();
        },
        methods: {
            handleRemove(file, fileList) {
                axios.post('/restaurant/del_url',{
                    imgurl:this.imgurl
                }).then((res)=>{
                    this.$message.success(res.data);
                    this.imgurl=''
                })
            },
            success_up(res){
                this.imgurl=res;
                this.$message.success('上传成功')
            },
            beforeAvatarUpload(file){
                const isLt2M = file.size / 1024 / 1024 < 1;
                if (!isLt2M) {
                    this.$message.error('上传图片大小不能超过 1MB!');
                }
                return  isLt2M;
            },
            check_category(){
                var cookie=cookies.get('user_info');
                var storeId=cookie.storeId;
                axios({
                    method: 'get',
                    url: '/restaurant/showCategory',
                    params:{
                        storeId:storeId
                    }
                }).then((res)=>{
                    this.options=res.data;
                })
            },
            add_food(){
                var cookie=cookies.get('user_info');
                var storeId=cookie.storeId;
                axios.post('/restaurant/add_food',{
                    foodname:this.foodname,
                    price:this.price,
                    describe:this.describe,
                    state:this.state,
                    category:this.category,
                    discount:this.discount,
                    imgurl:this.imgurl,
                    storeId:storeId
                }).then((res)=>{
                    console.log(res.data);
                    this.$message.success('添加成功');
                    Object.assign(this.$data, this.$options.data())
                })
            }
        }
    };
</script>

