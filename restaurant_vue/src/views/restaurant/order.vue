<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main>
                <el-table
                        :data="tableData.slice((currentPage - 1) * pageSize, currentPage*pageSize)"
                        style="width: 100%;"
                        border>
                    <el-table-column
                            prop="No"
                            label="No"
                            width="100"
                            align="center">
                    </el-table-column>
                    <el-table-column
                            prop="orderId"
                            label="订单ID"
                            align="center">
                    </el-table-column>
                    <el-table-column
                            prop="time"
                            sortable
                            label="下单时间"
                            align="center">
                    </el-table-column>
                    <el-table-column
                            prop="total"
                            width="80"
                            label="总金额"
                            align="center">
                    </el-table-column>
                    <el-table-column
                            prop="status"
                            width="100"
                            label="状态"
                            sortable
                            align="center">
                        <template slot-scope="scope" >
                            <div :class="scope.row.status==1?'no':'ok'">
                            {{scope.row.status==1?'待处理':'已处理'}}
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column
                            prop="comment"
                            label="备注"
                            align="center">
                    </el-table-column>
                    <el-table-column
                            label="查看详情"
                            width="100"
                            align="center">
                        <template slot-scope="scope">
                            <el-button  type="text" size="small" @click="order_detail(scope.row.orderId,scope.$index)">查看</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination
                        class="fenye"
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        layout="prev, pager, next"
                        :page-size="pageSize"
                        :current-page="currentPage"
                        :total="tableData.length">
                </el-pagination>

                <el-drawer
                        title="详情菜品列表"
                        class="el-drawer__body"
                        :before-close="handleClose"
                        custom-class="demo-drawer"
                        :visible.sync="detail"
                        direction="ltr"
                        ref="drawer"
                        size="50%">
                    <el-table :data="detail_list" border>
                        <el-table-column property="picture" label="图片" width="150" align="center">
                            <template slot-scope="scope">
                                <img :src="scope.row.picture" width="80" height="80" class="head_pic"/>
                            </template>
                        </el-table-column>
                        <el-table-column property="foodName" label="菜名" width="150" align="center"></el-table-column>
                        <el-table-column property="foodNumber" label="数量" width="200" align="center"></el-table-column>
                        <el-table-column property="price" label="原价" align="center"></el-table-column>
                        <el-table-column property="discount" label="折扣" align="center"></el-table-column>
                        <el-table-column property="price" label="实收" align="center">
                            <template slot-scope="scope">
                                <div>
                                ￥{{scope.row.price*scope.row.discount}}
                                </div>
                            </template>
                        </el-table-column>
                    </el-table>
                    <div class="button">
                        <el-button @click="cancelForm">取 消</el-button>
                        <el-button v-if="" type="primary" @click="$refs.drawer.closeDrawer()" :loading="loading">{{ loading ? '提交中 ...' : '完成订单' }}</el-button>
                    </div>
                </el-drawer>
            </el-main>
        </div>
    </el-container>

</template>

<style>
    .main{
        width: 88%;
    }
    .no{
        color: #42b983;
    }
    .ok{
        color: red;
    }
    .button{
        position: relative;
        margin-top: 20px;
    }

    .el-drawer__body {
        overflow: auto;
        /* overflow-x: auto; */
    }
    .fenye{
        position: absolute;
        bottom: 1px;
    }

</style>

<script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    import cookies from 'vue-cookies'
    import axios from 'axios'
    export default {
        name:'order',
        data() {
            return {
                detail:false,
                loading: false,
                timer:null,
                user_name:'',
                tableData: [],
                detail_list:[],
                chance_orderId:[],
                currentPage: 1,
                pageSize: 9
            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted(){
            this.orderList()
            this.main()
        },
        methods: {
            main(){
                window.setInterval(() => {
                    setTimeout(() => {
                        this.orderList();
                        console.log(111);
                    }, 0)
                }, 30000)
            },
            orderList() {
                var cookie = cookies.get('user_info');
                var storeId = cookie.storeId;
                axios({
                    method: 'get',
                    url: '/restaurant/show_order',
                    params: {
                        storeId: storeId
                    }
                }).then((res) => {
                    this.tableData = res.data
                    console.log(res.data);
                })
            },
            order_detail(row, index) {
                var orderId = row;
                this.chance_orderId['id']=orderId;
                if (this.tableData[index].detail == null) {
                    axios({
                        method: 'GET',
                        url: '/restaurant/order_detail',
                        params: {
                            orderId: orderId
                        }
                    }).then((res) => {
                        this.tableData[index].detail=res.data;
                        this.detail_list=this.tableData[index].detail;
                        this.detail=true

                    })
                }else {
                    this.detail_list=this.tableData[index].detail;
                    this.detail=true

                }
            },
            handleClose(done) {
                if (this.loading) {
                    return;
                }
                this.$confirm('确定要更改订单状态吗？')
                    .then(_ => {
                        this.loading = true;
                        this.timer = setTimeout(() => {
                            done();
                            axios.post('/restaurant/order_status',{
                                orderId:this.chance_orderId['id'],
                            }).then((res)=>{
                                this.$message.success('已完成该订单');
                                this.orderList();
                            })
                            setTimeout(() => {
                                this.loading = false;
                            }, 400);
                        }, 1000);
                    })
                    .catch(_ => {

                    });
            },
            cancelForm() {
                this.loading = false;
                this.detail = false;
            },
            handleSizeChange(val) {
                console.log(`每页 ${val} 条`);
            },
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`);
                this.currentPage=val;
            }
        }
    };
</script>

