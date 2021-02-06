<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main class="el-main">
                <div>
                    <el-table
                            :data="tableData"
                            border
                            style="width: 100%;text-align: center">
                        <el-table-column
                                fixed
                                prop="applyId"
                                label="ID"
                                width="70">
                        </el-table-column>
                        <el-table-column
                                prop="storeId"
                                label="商店ID"
                                width="170">
                        </el-table-column>
                        <el-table-column
                                prop="storename"
                                label="商店名称"
                                width="110">
                        </el-table-column>
                        <el-table-column
                                prop="username"
                                label="申请人账号"
                                width="100">
                        </el-table-column>
                        <el-table-column
                                prop="nickname"
                                label="真实姓名"
                                width="80">
                        </el-table-column>
                        <el-table-column
                                prop="phone"
                                label="手机号码"
                                width="130">
                        </el-table-column>
                        <el-table-column
                                prop="city"
                                label="所在城市"
                                width="80">
                        </el-table-column>
                        <el-table-column
                                prop="id_card"
                                label="身份证号"
                                width="160">
                        </el-table-column>
                        <el-table-column
                                prop="location"
                                label="xx-xx店"
                                width="100">
                        </el-table-column>
                        <el-table-column
                                prop="city_j"
                                label="经度"
                                width="70">
                        </el-table-column>
                        <el-table-column
                                prop="city_w"
                                label="维度"
                                width="70">
                        </el-table-column>
                        <el-table-column
                                fixed="right"
                                label="操作"
                                width="60">
                                <el-button slot-scope="scope" type="text"  size="small" @click="pass(scope.row)">通过</el-button>
                        </el-table-column>
                    </el-table>
                </div>
            </el-main>
        </div>
    </el-container>

</template>

<style>
    .main{
        width: 85%;
    }
</style>

<script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    import cookies from 'vue-cookies'
    import axios from 'axios'
    export default {
        name:'check_apply',
        data() {
            return {
                tableData: [],
            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted(){
           this.get_apply();
        },
        methods: {
            get_apply:function () {
                axios({
                    method: 'get',
                    url: '/admin/get_apply',
                }).then((res)=>{
                    this.tableData=res.data;
                    console.log(res.data);
                })
            },
            pass:function (row) {
                console.log(row.state+row.username);
                axios({
                    method: 'get',
                    url: '/admin/chance_state',
                    params:{
                        username:row.username,
                        state:row.state,
                        id_card:row.id_card,
                        storeId:row.storeId,
                    }
                }).then((res)=>{
                    if(res.flag=true){
                        alert('审核通过');
                        this.get_apply();
                        console.log(res.data.msg);
                    }else {
                        alert('出现了一些问题');
                        console.log(res.data.msg);
                    }
                })
            }
        }

    };
</script>

