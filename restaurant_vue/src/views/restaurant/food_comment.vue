<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main>
                <el-table
                        :data="comment_list.slice((currentPage - 1) * pageSize, currentPage*pageSize)"
                        border
                        style="width: 100%">
                    <el-table-column
                            prop="id"
                            align="center"
                            width="80"
                            label="ID">
                    </el-table-column>
                    <el-table-column
                            prop="imgurl"
                            label="图片"
                            align="center"
                            width="180">
                        <template slot-scope="scope">
                            <img :src="scope.row.imgurl" width="80" height="80" class="head_pic"/>
                        </template>
                    </el-table-column>
                    <el-table-column
                            prop="head"
                            label="用户头像"
                            align="center"
                            width="180">
                        <template slot-scope="scope">
                            <img :src="scope.row.head" width="80" height="80" class="head_pic"/>
                        </template>
                    </el-table-column>
                    <el-table-column
                            prop="wxname"
                            align="center"
                            label="微信昵称">
                    </el-table-column>
                    <el-table-column
                            prop="comment"
                            align="center"
                            label="评论内容">
                    </el-table-column>
                    <el-table-column
                            prop="comment_time"
                            align="center"
                            sortable
                            label="发送时间">
                    </el-table-column>
                    <el-table-column
                            align="center"
                            sortable
                            prop="status"
                            label="状态">
                        <template slot-scope="scope" >
                            <div :class="scope.row.status==1?'no':'ok'">
                                {{scope.row.status==1?'待处理':(scope.row.status==2?'通过':'失败')}}
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column
                            align="center"
                            label="操作">
                        <template slot-scope="scope">
                            <el-button  type="text" size="small" v-if="scope.row.status==1" @click="pass(scope.row.id,2,scope.$index)">通过</el-button>
                            <el-button  type="text" size="small" v-if="scope.row.status==1" class="ok" @click="pass(scope.row.id,0,scope.$index)">拦截</el-button>
                            <el-button  type="text" size="small" v-if="scope.row.status==0" class="ok" @click="del(scope.row.id,scope.$index)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination
                        v-if="comment_list.length>4"
                        class="fenye"
                        @current-change="handleCurrentChange"
                        layout="prev, pager, next"
                        :page-size="pageSize"
                        :current-page="currentPage"
                        :total="comment_list.length">
                </el-pagination>
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
    .fenye{
        position: absolute;
        bottom: 1px;
    }
</style>

<script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    import axios from 'axios'
    import cookies from 'vue-cookies'
    export default {
        name:'food_comment',
        data() {
            return {
                comment_list:[],
                currentPage: 1,
                pageSize: 4
            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted() {
            this.show_comment()
        },
        methods:{
            show_comment(){
                var cookie=cookies.get('user_info');
                var storeId=cookie.storeId;
                axios({
                    method: 'get',
                    url: '/restaurant/show_comment',
                    params:{
                        storeId:storeId
                    }
                }).then((res)=>{
                    this.comment_list=res.data;
                    console.log(this.comment_list)
                })
            },
            pass(row,status,index){
                var id=row;
                var status=status;
                axios({
                    method: 'GET',
                    url: '/restaurant/change_status',
                    params:{
                        id:id,
                        status:status
                    }
                }).then((res)=>{
                    var i=index+(this.currentPage-1)*this.pageSize
                    this.comment_list[i].status=status;
                    this.$message.success(res.data);
                })
            },
            del(id,index){
                var id=id; var index=index;
                this.$confirm('此操作将永久删除该评论, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning',
                    center: true
                }).then(() => {
                    axios({
                        method: 'GET',
                        url: '/restaurant/del_comment',
                        params:{
                            id:id,
                        }
                    }).then((res)=>{
                        var i=index+(this.currentPage-1)*this.pageSize
                        this.comment_list.splice(i,1)
                        this.$message.success(res.data);
                    })
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            handleCurrentChange(val) {
                console.log(`当前页: ${val}`);
                this.currentPage=val;
            }
            }
    };
</script>

