<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main>
                <h5>菜品分类</h5>
                <div class="category">
                <div class="left">
                    <el-table :data="form" style="width: 502px">
                        <el-table-column
                                fixed
                                prop="cid"
                                label="分类"
                                width="100px"
                                align="center">
                        </el-table-column>
                        <el-table-column
                                fixed
                                prop="category"
                                label="ID"
                                align="center"
                                width="300px">
                        </el-table-column>
                        <el-table-column label="操作" width="100px" align="center">
                            <template slot-scope="scope">
                                <i class="el-icon-edit" style="margin-right: 10px" @click="changeCategory(scope.row)"></i>
                                <i class="el-icon-delete" style="margin-left: 10px" @click="delCategory(scope.row)"></i>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
                <div class="right">
                    <el-form  ref="form"  label-width="100px" class="from">
                        <el-form-item label="分类名称">
                            <el-input maxlength="6" v-model="category" ></el-input>
                        </el-form-item>
                    </el-form>
                    <el-button @click="addCategory">提交</el-button>
                </div>
                </div>
            </el-main>
        </div>
    </el-container>

</template>

<script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    import cookies from 'vue-cookies'
    import axios from 'axios'
    export default {
        name: "category",
        data() {
            return {
                storeId:'',
                category:'',
                form:[]
            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted() {
            this.get_cookies();
            this.showCategory();
        },
        methods: {
            get_cookies:function () {
               var cookie=cookies.get('user_info');
               this.storeId=cookie.storeId;
            },
            addCategory:function () {
               if(this.category!=''){
                   axios.post('/restaurant/addCategory',{
                       storeId:this.storeId,
                       category:this.category
                   }).then((res)=>{
                       alert(res.data);
                       this.showCategory();
                   })
               } else {
                   alert('请填写分类名!!!');
               }
            },
            showCategory:function () {
                axios({
                    method: 'get',
                    url: '/restaurant/showCategory',
                    params:{
                        storeId:this.storeId
                    }
                }).then((res)=>{
                    this.form=res.data;
                    console.log(this.form);
                })
            },
            changeCategory(row){
                this.$prompt('请输入修改的分类名称', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                }).then(({ value }) => {
                    if(value!=null){
                    axios({
                        method: 'get',
                        url: '/restaurant/changeCategory',
                        params:{
                            cid:row.cid,
                            category:value
                        }
                    }).then((res)=>{
                        this.$message({
                            type: 'success',
                            message: res.data
                        });
                        this.showCategory();
                    })
                    }else {
                        this.$message.error('名称不可为空哦！！！')
                    }
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消输入'
                    });
                });
            },
            delCategory:function (row) {
                this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$message({
                        type: 'success',
                        message: '删除成功!'
                    });
                    axios({
                        method: 'get',
                        url: '/restaurant/delCategory',
                        params:{
                            cid:row.cid
                        }
                    }).then((res)=>{
                        alert(res.data);
                        this.showCategory();
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });

            }

        }
    };
</script>

<style>
    .main{
        width: 88%;
    }
    .category{
        display: flex;
    }
    .left{
        width: 65%;
        clear: none;
    }
    .right{
        width: 35%;
        clear: none;
    }
    .from{
        margin-top: 10%;
    }


</style>

