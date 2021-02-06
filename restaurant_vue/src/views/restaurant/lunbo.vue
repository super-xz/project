<template>
    <el-container>
        <admin-left></admin-left>
        <div class="main">
            <adminHead></adminHead><br>
            <el-main>
                <el-carousel :interval="4000" type="card" height="300px">
                    <el-carousel-item v-for="item in lunbo"  :key="item.pid" :name="item.title" v-if="item.state==1">
                        <img style="width:100%;height:100%;" :src="item.pic" />
                    </el-carousel-item>
                </el-carousel>
                <div class="add">
                    <el-button style="margin-left: 20px" @click="add_img">添加图片</el-button>
                    <div style="line-height: 40px;position: absolute;right: 40px">现在共有{{lunbo.length}}条数据</div>
                </div>
                <el-table
                        :data="lunbo"
                        border
                        style="width: 100%">
                    <el-table-column
                            prop="pid"
                            label="Pid"
                            align="center"
                            width="180">
                    </el-table-column>
                    <el-table-column
                            prop="pic"
                            label="图片"
                            align="center"
                            width="180">
                        <template slot-scope="scope">
                            <img :src="scope.row.pic" width="100%" height="100%" />
                        </template>
                    </el-table-column>
                    <el-table-column
                            align="center"
                            prop="title"
                            label="描述">
                    </el-table-column>
                    <el-table-column
                            prop="state"
                            align="center"
                            width="150"
                            label="是否是轮播图">
                        <template slot-scope="scope" >
                            <div :class="scope.row.state==1?'no':'ok'">
                                {{scope.row.state==1?'已上线':'已下线'}}
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column
                            fixed="right"
                            label="操作"
                            width="100"
                            align="center">
                        <template slot-scope="scope">
                            <el-button  type="text" size="small" @click="del_lunbo(scope.row,scope.$index)">删除</el-button>
                            <el-button type="text" size="small" @click="lunbo_state(scope.row,scope.$index)">{{scope.row.state==1?'下线':'上线'}}</el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <el-drawer
                        title="我是标题"
                        :with-header="false"
                        :visible.sync="drawer"
                        direction="ltr"
                        ref="drawer"
                        :before-close="handleClose">
                    <el-upload
                            style="margin-top: 30px"
                            class="upload-demo upload"
                            action="/img/lunbo"
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
                    <div style="display: flex;flex-direction: row;justify-content: center;align-content: center;width: 100%;height: 40px;margin-top: 40px">
                        <label style="width: 80px;height: 40px;line-height: 40px">描述</label><el-input v-model="imgdata.title" style="width: 50%"></el-input>
                    </div>
                    <div class="demo-drawer__footer" style="margin-top: 30px">
                        <el-button @click="cancelForm">取 消</el-button>
                        <el-button type="primary" @click="$refs.drawer.closeDrawer()" :loading="loading">{{ loading ? '提交中 ...' : '确 定' }}</el-button>
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
    .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
    }

    .el-carousel__item:nth-child(2n+1) {
        background-color: #d3dce6;
    }
    .add{
        width: 100%;
        height: 40px;
        border-radius: 30px;
        background-color: gainsboro;
        display: flex;
        flex-direction: row;
        align-content: center;
    }
    .no{
        color: #42b983;
    }
    .ok{
        color: red;
    }
</style>

<script>
    import adminHead from '@/components/common/Head.vue'
    import adminLeft from '@/components/common/Left.vue'
    import cookies from 'vue-cookies'
    import axios from 'axios'
    export default {
        name:'lunbo',
        data() {
            return {
            lunbo:[],
            drawer:false,
            loading:false,
            timer:null,
            fileList:[],
            imgdata:{}
            }
        },
        components: {
            adminHead,
            adminLeft
        },
        mounted() {
            this.get_lunbo()
        },
        methods:{
            get_lunbo(){
                axios({
                    method: 'get',
                    url: '/restaurant/lunbo',
                }).then((res) => {
                    this.lunbo=res.data;
                    console.log(res.data);
                })
            },
            add_img(){
                this.drawer=true;
            },
            success_up(res){
                this.imgdata.url=res;
                this.$message.success('上传成功')
            },
            handleRemove(file, fileList) {
                axios.post('/img/del_lunbo',{
                    url:this.imgdata.url
                }).then((res)=>{
                    this.$message.success(res.data);
                })
            },
            beforeAvatarUpload(file){
                const isLt2M = file.size / 1024 / 1024 < 1;
                if (!isLt2M) {
                    this.$message.error('上传图片大小不能超过 1MB!');
                }
                return  isLt2M;
            },
            handleClose(done) {
                if (this.loading) {
                    return;
                }
                this.$confirm('确定要上传新轮播图吗？')
                    .then(_ => {
                        this.loading = true;
                        this.timer = setTimeout(() => {
                            done();
                            console.log(this.imgdata)
                            if(this.imgdata.url!=null&&this.imgdata.title!=null){
                                 axios.post('/img/add_lunbo',{
                                     pic:this.imgdata.url,
                                     title:this.imgdata.title
                                 }).then((res)=>{
                                     this.$message.success(res.data);
                                     this.$refs.upload.clearFiles()
                                     this.imgdata={}
                                     this.get_lunbo();
                                 })
                            }else {
                                this.$message.error('图片和描述不可为空')
                            }
                            setTimeout(() => {
                                this.loading = false;
                            }, 400);
                        }, 1000);
                    })
                    .catch(_ => {});
            },
            cancelForm() {
                this.drawer = false;
                this.loading=false;
                clearTimeout(this.timer);
            },
            lunbo_state(row,index){
                console.log(row+index);
                var state=row.state
                axios.post('/img/lunbo_state',{
                    pid:row.pid,
                    state:state==1?0:1
                }).then((res)=>{
                    this.lunbo[index].state=state==1?0:1
                    this.$message.success('修改成功');

                })
            },
            del_lunbo(row,index){
                this.$confirm('此操作将永久删除该轮播图, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.post('/img/delLunbo',{
                        pic:row.pic,
                        pid:row.pid
                    }).then((res)=>{
                        this.lunbo.splice(index,1)
                        this.$message.success('已删除');

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

