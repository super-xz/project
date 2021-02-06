<?php
/**
 * Created by PhpStorm.
 * User: 17563
 * Date: 2020/12/8
 * Time: 15:26
 */

namespace app\index\controller;
header("Access-Control-Allow-Origin: *");
use think\Db;
use think\Request;


class Order
{
    public function submit_order(){
        $date=date("Y-m-d");
        $food=json_decode($_GET['order_food']);
        $storeId=$_GET['storeId'];
        $openid=$_GET['openId'];
        $sumMoney=$_GET['sumMoney'];
        $comment=$_GET['comment'];
        $orderId=rand(1,9).strval(time());
        $no=Db::table("meal_number")->where(['date'=>$date,'storeId'=>$storeId])->find();
        $time=date('y-m-d H:i:s',time());
        if($no!=null){
            Db::table("meal_number")->where(['date'=>$date,'storeId'=>$storeId])->setInc('no',1);
            $number=Db::table("meal_number")->where(['date'=>$date,'storeId'=>$storeId])->value('no');
        }else{
            $insert=[
                'storeId'=>$storeId,
                'date'=>$date,
                'no'=>1
            ];
            Db::table("meal_number")->insert($insert);
            $number=Db::table("meal_number")->where(['date'=>$date,'storeId'=>$storeId])->value('no');
        }
        $ins=[
            "orderId"=>$orderId,
            "sellerId"=>$storeId,
            'buyerId'=>$openid,
            'time'=>$time,
            'status'=>1,
            'No'=>$number,
            'total'=>$sumMoney,
            'comment'=>$comment
        ];
        Db::table('order_main')->insert($ins);
        for($i=0;$i<count($food,0);$i++){
            $info=[
                'order_main'=>$orderId,
                'foodId'=>$food[$i]->id,
                'foodName'=>$food[$i]->name,
                'foodNumber'=>$food[$i]->number,
                'price'=>$food[$i]->price,
                'discount'=>$food[$i]->discount,
                'picture'=>$food[$i]->url,
                'comment'=>0
            ];
            Db::table('food')->where('foodId',$food[$i]->id)->setInc('sales',$food[$i]->number);
            Db::table('order_vice')->insert($info);
        }
        return json([
            'no'=>$number,
            'orderId'=>$orderId,
            'date'=>$time,
            'food'=>$food,
            'sumMoney'=>$sumMoney,
            'comment'=>$comment
        ]);
    }
    //获取历史订单
    public function order_list(){
        $openid=$_GET['openid'];
       $a= Db::table('order_main')->where('buyerid',$openid)->field(
           'orderId,sellerId,time,total,No')->order('time desc')->select();
       for($i=0;$i<count($a,0);$i++){
           $b=Db::table('order_vice')->where('order_main',$a[$i]['orderId'])->limit(1)->value('foodName');
           $number=Db::table('order_vice')->where('order_main',$a[$i]['orderId'])->count();
           $store=Db::table('store')->where('storeId',$a[$i]['sellerId'])->field('storename,store_img,store_status')->find();
           $a[$i]['food']=$b;
           $a[$i]['number']=$number;
           $a[$i]['store']=$store['storename'];
           $a[$i]['store_status']=$store['store_status'];
           $a[$i]['store_img']=$store['store_img'];
       }
        return json($a);
    }
    //获取订单的详情信息
    public function check_order(){
        $orderid=$_GET['orderId'];
        $info=Db::table('order_main')->where('orderId',$orderid)->field(
            'time,total,No,comment,sellerId'
        )->select();
        $food=Db::table('order_vice')->where('order_main',$orderid)->field(
            'foodName,foodNumber,price,picture,discount,comment,foodId'
        )->select();
        return json([
            'info'=>$info,
            'food'=>$food
        ]);
    }
    //用户评论菜品
    public function feedback(){
        $orderid=$_GET['orderId'];
        $ins['orderId']=$orderid;
        $ins['foodId']=$_GET['foodId'];
        $ins['comment']=$_GET['feedback'];
        $ins['storeId']=$_GET['storeId'];
        $ins['openid']=$_GET['openid'];
        $ins['status']=1;
        $ins['comment_time']=date('y-m-d H:i:s',time());
        Db::table('order_vice')->where(['order_main'=>$orderid,'foodId'=>$ins['foodId']])->update(['comment'=>1]);
        Db::table('comment')->insert($ins);
        return json($ins);
    }
    public function test(){
        $a='17101116055995691606902406';
        $b=Db::table('order_vice')->where('foodId',$a)->field('comment_text')->select();
        return json($b);
    }

}