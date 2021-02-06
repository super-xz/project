<?php
/**
 * Created by PhpStorm.
 * User: 17563
 * Date: 2020/11/23
 * Time: 11:56
 */

namespace app\vue\controller;
header("Access-Control-Allow-Origin: *");
use think\Db;
use think\Controller;
use think\Request;


class restaurant extends Controller
{
    public function test(){
        $param = [
            'foodId' => '1710111605599569' . strval(time()),
            'foodName' => '螺狮粉',
            'price' => 9,
            'number' => 100,
            'discount' => 1,
            'describe' => '螺蛳粉的味美还因为它有着独特的汤料。汤料由螺蛳、山奈、八角、肉桂、丁香、多种辣椒、等天然香料和味素配制而成。',
            'category' => 1,
            'imgurl' => 'uioqkj'
        ];
        $res = Db::table('food')->insert($param);
        if($res){
            return json($param);
        }
    }
    //添加分类
    public  function addCategory(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        if($data['storeId']==''||$data['category']==''){
            return '参数异常';
        }else{
        $inser=[
          'storeId'=>$data['storeId'],
          'category'=>$data['category']
        ];
        $res=Db::table('category')->insert($inser);
        if($res){
            return '添加成功';
        }else{
            return '添加失败';
        }
    }
    }
    //查询特定店家的分类
    public function showCategory(Request $request){
        $data=$request->param();
        $res=Db::table('category')->where('storeId',$data['storeId'])->select();
        return json($res);
    }
    //修改分类信息
    public function changeCategory(Request $request){
        $data=$request->param();
        $res=Db::table('category')->where('cid',$data['cid'])->update(['category'=>$data['category']]);
        if($res){
            return '修改成功！！';
        }else{
            return '修改失败';
        }
    }
    //删除分类
    public function delCategory(Request $request){
        $data=$request->param();
        $res=Db::table('category')->where('cid',$data['cid'])->delete();
        if($res){
            return '删除成功';
        }else{
            return '删除失败';
        }
    }

    //上传菜品图片
    public function uploadimg(){
        $file = request()->file('file');
        if ($file) {
            $info = $file->move(ROOT_PATH . 'public' . DS . 'upload'.DS.'food_img');
            if ($info) {
                $imgs = 'http://www.restaurant.com/upload/food_img/'.$info->getSavename();
            }
        }
        return json($imgs);
    }
    //删除图片
    public function del_url(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        $filename=mb_substr($data['imgurl'],26);
        unlink($filename);
        return '删除成功！！！';
    }

    //添加菜品
    public function add_food(){
            $data = file_get_contents('php://input');
            $data = json_decode($data, true);
            $param = [
                'foodId' => $data['storeId'] . strval(time()),
                'foodName' => $data['foodname'],
                'price' => $data['price'],
                'number' => 0,
                'discount' => $data['discount'],
                'describe' => $data['describe'],
                'cid' => $data['category'],
                'imgurl' => $data['imgurl'],
                'storeId'=>$data['storeId'],
                'state'=>$data['state'],
                'sales'=>0
            ];
            $res = Db::table('food')->insert($param);
        if($res){
            return json($param);
        }
    }
    //获取菜品
    public function get_food(Request $request){
        $data=$request->param();
        $res=Db::table('food')->where('storeId',$data['storeId'])->select();
        return json($res);
    }
    //修改菜品信息
    public function change_food(){
        $data = file_get_contents('php://input');
        $data = json_decode($data, true);
        $data=$data['food'];
        $res=Db::table('food')->where('foodId',$data['foodId'])->update($data);
        if($res){
            return '修改成功';
        }
    }
    //删除菜品
    public function del_food(Request $request){
        $data=$request->param();
        $del=Db::table('food')->where('foodId',$data['foodId'])->delete();
        $filename=mb_substr($data['imgurl'],26);
        unlink($filename);
        if($del){
            return '删除成功';
        }
    }
    //查看餐厅订单
    public function show_order(){
        $storeid=$_GET['storeId'];
        $res=Db::table('order_main')->where('sellerId',$storeid)->order('status asc')->select();
        return json($res);
    }
    //查看订单的详情页内容
    public function order_detail(){
        $orderId=$_GET['orderId'];
        $res=Db::table('order_vice')->where('order_main',$orderId)->select();
        return json($res);
    }
    //修改订单状态
    public function order_status(){
        $data = file_get_contents('php://input');
        $data = json_decode($data, true);
        $orderId=$data['orderId'];
        $check=Db::table('order_main')->where('orderId',$orderId)->setField('status', '2');
        if($check){
            return '该订单已完成！！！';
        }
    }
    //根据餐厅查找菜品评论
    public function show_comment(){
        $storeId=$_GET['storeId'];
        $res=Db::table('comment')->alias("c")->join('user u','c.openid=u.openid')->join('food f','c.foodId=f.foodId')->where(['c.storeId'=>$storeId])->where('c.status','neq',2)->field
        (
            'c.foodId,f.imgurl,c.comment,c.comment_time,c.id,u.wxname,u.head,c.status'
        )->order('c.status desc')->select();
        return json($res);
    }

    //修改菜品评论的状态：0拦截/1待审核/2通过
    public function change_status(){
        $id=$_GET['id'];
        $status=$_GET['status'];
        $res=Db::table('comment')->where('id',$id)->update(['status'=>$status]);
        if($res){
            return '操作成功';
        }
    }
    //删除评论
    public function del_comment(){
        $id=$_GET['id'];
        $res=Db::table('comment')->where('id',$id)->delete();
        if ($res){
            return '删除成功';
        }
    }

    //获取店铺的信息
    public function get_info(){
        $storeId=$_GET['storeId'];
        $res=Db::table('store')->where('storeId',$storeId)->find();
        return json($res);
    }
    //上传商店的头像
    public function store_img(){
        $file = request()->file('file');
        if ($file) {
            $info = $file->move(ROOT_PATH . 'public' . DS . 'upload'.DS.'store_head');
            if ($info) {
                $imgs = 'http://www.restaurant.com/upload/store_head/'.$info->getSavename();
            }
        }
        return json($imgs);
    }
    //删除图片
    public function store_imgdel(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        $filename=mb_substr($data['imgurl'],26);
        unlink($filename);
        return '删除成功！！！';
    }
    //提交修改后的商店头像url到数据库
    public function confirm_img(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        if($data['oldimg']!=''){
            $filename=mb_substr($data['oldimg'],26);
            unlink($filename);
        }
         $res=Db::table('store')->where('storeId',$data['storeId'])->update(['store_img'=>$data['imgurl']]);
        if($res){
            return '修改成功';
        }
    }
    //修改商店信息
    public function change_storeinfo(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        $res=Db::table('store')->where('storeId',$data['storeId'])->update($data['store_info']);
        $info=Db::table('store')->where('storeId',$data['storeId'])->select();
        if($res){
            return json($info);
        }
    }
    //获取轮播图
    public function lunbo(){
        $data['state']=1;
        $select=Db::table('lunbo')->select();
        return json($select);
    }
}