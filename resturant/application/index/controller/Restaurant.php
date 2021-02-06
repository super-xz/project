<?php

namespace app\index\controller;
header("Access-Control-Allow-Origin: *");
use think\Db;
use think\Request;

class Restaurant
{
    public function lunbo(){
        $data['state']=1;
        $select=Db::table('lunbo')->where($data)->select();
        return json($select);
    }

    public function test(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        $data['hello']=$data['hello'];
        $data['b']=$data['b'];
        return json($data);
    }
//    //根据城市查询店铺
//    public function show_store(){
//        $city=$_GET['city'];
//        $res=Db::table('store')->where('city',$city)->select();
//        return json($res);
//    }

    //根据商铺id查询菜品
    public function show_food(){
        $storeId=$_GET['storeId'];
        $c=Db::table('category')->where('storeId',$storeId)->select();
        $food=Db::table('food')->where('storeId',$storeId)->order('cid')->select();
        for($i=0;$i<count($c,0);$i++){
            $c[$i]['food']=array();
            for($j=0;$j<count($food,0);$j++){
                if($c[$i]['cid']==$food[$j]['cid']){
                    array_push($c[$i]['food'],$food[$j]);
                }
            }
        }
        return json($c);
    }
    //获取菜品的评论哦
    public function show_comment(){
        $storeId=$_GET['storeId'];
        $foodId=$_GET['foodId'];
        $res=Db::table('comment')->alias("c")->join('user u','c.openid=u.openid')->where(['c.storeId'=>$storeId,'c.foodId'=>$foodId,'c.status'=>1])->field
        (
            'c.foodId,c.comment,c.comment_time,c.openid,c.orderId,c.id,c.storeId,u.wxname,u.head'
        )->order('comment_time desc')->select();
        return json($res);
    }
    //根据经纬度查询店铺
    public function store_list(){
        $lat=$_GET['lat'];
        $lng=$_GET['lng'];
        $res=Db::table('store')->alias('s')->where('s.store_status',1)->field("s.storeId,s.storename,s.location,s.store_img,
        (6378.138 * 2 * asin(sqrt(pow(sin((city_w * pi() / 180 - ".$lat." * pi() / 180) / 2),2) + cos(city_w * pi() / 180) * cos(".$lat." * pi() / 180) * pow(sin((city_j * pi() / 180 - ".$lng." * pi() / 180) / 2),2))) *1000) as distance")
            ->order('distance asc')
            ->select();
        return json($res);
    }

    //根据店铺id查询店铺名和距离（补订单跳转无店名和距离）
    public function store_info(){
        $storeid=$_GET['storeId'];
        $openid=$_GET['openid'];
        $lat=$_GET['lat'];
        $lng=$_GET['lng'];
        $res=Db::table('store')->where('storeId',$storeid)->field("storename,(6378.138 * 2 * asin(sqrt(pow(sin((city_w * pi() / 180 - ".$lat." * pi() / 180) / 2),2) + cos(city_w * pi() / 180) * cos(".$lat." * pi() / 180) * pow(sin((city_j * pi() / 180 - ".$lng." * pi() / 180) / 2),2))) *1000) as juli")
            ->select();
        $favorite=Db::table('favorite')->where(['storeid'=>$storeid,'openid'=>$openid])->find();
        $f=$favorite==null?0:1;
        $res[0]['juli']=round($res[0]['juli'],2);
        $res[0]['favorite']=$f;
        return json($res);
    }
    //收藏店铺或取消收藏店铺
    public function favorite(Request $request){
        $data=$request->param();//获取post请求
        $par=[
            'storeid'=>$data['storeid'],
            'openid'=>$data['openid']
        ];
        $res=Db::table('favorite')->where($par)->find();
        if($res==null){
            Db::table('favorite')->insert($par);
            return '收藏成功！！！';
        }else{
            Db::table('favorite')->where($par)->delete();
            return '已取消收藏';
        }
    }
    //me页面的收藏店铺获取
    public function get_favorite(Request $request){
        $data=$request->param();//获取post请求
        $openid=$data['openid'];
        $res=Db::table('favorite')->alias('f')->join('store s','f.storeid=s.storeId')->where('f.openid',$openid)->field('s.storeId,s.storename,s.city,s.location,s.store_img,s.store_status')->select();
        return json($res);
    }
}