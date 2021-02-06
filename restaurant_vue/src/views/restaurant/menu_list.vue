<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main>
                <el-table :data="food_list"
                          border
                          style="width: 100%">
                    <el-table-column  label="图片" width="140" align="center">
                        <template slot-scope="scope">
                            <img :src="scope.row.imgurl" width="80" height="80" class="head_pic"/>
                        </template>
                    </el-table-column>
                    <el-table-column prop="foodName" label="菜名" width="140" align="center">
                    </el-table-column>
                    <el-table-column prop="cid" label="分类" width="80" align="center">
                    </el-table-column>
                    <el-table-column prop="describe" label="描述" align="center">
                    </el-table-column>
                    <el-table-column prop="price" label="价格" width="80" align="center">
                    </el-table-column>
                    <el-table-column prop="discount" label="折扣" width="80" align="center">
                    </el-table-column>
                    <el-table-column prop="sales" label="销量" width="80" align="center">
                    </el-table-column>
                    <el-table-column prop="number" label="库存" width="80" align="center">
                    </el-table-column>

                    <el-table-column
                            fixed="right"
                            label="操作"
                            width="100"
                            align="center">
                        <template slot-scope="scope">
                            <el-button  type="text" size="small" @click="del_food(scope.row)">删除</el-button>
                            <el-button type="text" size="small" @click="change(scope.row)">编辑</el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <el-drawer
                        title="编辑菜品"
                        :before-close="handleClose"
                        :visible.sync="dialog"
                        direction="ltr"
                        custom-class="demo-drawer"
                        ref="drawer"
                >
                    <div class="demo-drawer__content">
                        <el-form :model="food">
                            <el-form-item label="菜品名称"  :label-width="formLabelWidth">
                                <el-input v-model="food.foodName" autocomplete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="菜品分类"  :label-width="formLabelWidth">
                                <el-select v-model="food.cid" placeholder="请选择">
                                    <el-option
                                            v-for="item in category"
                                            :key="item.cid"
                                            :label="item.category"
                                            :value="item.cid">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="描述"  :label-width="formLabelWidth">
                                <el-input v-model="food.describe" type="textarea" :autosize="{ minRows: 2, maxRows: 4}" maxlength="100"
                                          show-word-limit autocomplete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="菜品价格"  :label-width="formLabelWidth">
                                <el-input v-model="food.price" type="number" autocomplete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="菜品折扣"  :label-width="formLabelWidth">
                                <el-input v-model="food.discount" type="number" autocomplete="off"></el-input>
                            </el-form-item>

                        </el-form>
                        <div class="demo-drawer__footer">
                            <el-button @click="cancelForm">取 消</el-button>
                            <el-button type="primary" @click="$refs.drawer.closeDrawer()" :loading="loading">{{ loading ? '提交中 ...' : '确 定' }}</el-button>
                        </div>
                    </div>
                </el-drawer>
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
        name:'menu_list',
        data() {
            return {
                user_name:'',
                dialog: false,
                loading: false,
                timer: null,
                formLabelWidth: '80px',
                food_list:[],
                food:{},
                category:[]
            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted() {
            this.get_food()
            this.check_category();
        },
        methods:{
            get_food(){
                var cookie=cookies.get('user_info');
                axios({
                    methods: 'get',
                    url: '/restaurant/get_food',
                    params:{
                        storeId:cookie.storeId
                    }
                }).then((res)=>{
                    console.log(res.data);
                    this.food_list=res.data;
                })
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
                    this.category=res.data;
                })
            },
            change(row){
                this.dialog=true;
                var a=row;
                this.food=a;
            },
            del_food(row){
                    this.$confirm('此操作将删除该菜品, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        axios({
                            url:'/restaurant/del_food',
                            method: 'GET',
                            params:{
                                foodId:row.foodId,
                                imgurl:row.imgurl
                            }
                        }).then((res)=>{
                            this.$message.success(res.data);
                            this.get_food();
                        })
                    }).catch(() => {
                        this.$message({
                            type: 'info',
                            message: '已取消删除'
                        });
                    });

            },
            handleClose(done) {
                if (this.loading) {
                    return;
                }
                this.$confirm('确定要修改菜品信息吗？')
                    .then(_ => {
                        this.loading = true;
                        this.timer = setTimeout(() => {
                            done();
                            axios.post('/restaurant/change_food',{
                                food:this.food,
                            }).then((res)=>{
                                this.$message.success(res.data);
                                this.get_food();
                            })
                            setTimeout(() => {
                                this.loading = false;
                            }, 400);
                        }, 1000);
                    })
                    .catch(_ => {});
            },
            cancelForm() {
                this.loading = false;
                this.dialog = false;
                this.get_food();
                clearTimeout(this.timer);
            }
        }
    };
</script>

<style>
    .main{
        width: 88%;
    }
</style>

