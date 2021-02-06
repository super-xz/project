<?php
/**
 * Created by PhpStorm.
 * User: 17563
 * Date: 2020/11/7
 * Time: 12:58
 */

namespace app\vue\controller;
header("Access-Control-Allow-Origin: *");
use think\Db;
use think\Controller;
use think\Request;
use think\Session;

class admin extends Controller
{
    public function test(){
        $data['username']='xuzhen1';
        $apply=Db::table('store_apply')->where('username',$data['username'])->find();
        $store=[
            'storeId'=>$apply['storeId'],
            'storename'=>$apply['storename'],
            'city'=>$apply['city'],
            'location'=>$apply['location'],
            'city_j'=>$apply['city_j'],
            'city_w'=>$apply['city_w']
        ];
        $insert2=Db::table('store')->insert($store);
        return json($insert2);
    }
    //账号登录
    public function login(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        $pwd=Db::table('storeadmin')->where('username',$data['username'])->value('pwd');
        if($pwd==false){
            return json($data=[
                'flag'=>false,
                'msg'=>'没有该账户',
            ]);
        }else{
            if($data['password']!=$pwd){
                return json($data=[
                    'flag'=>false,
                    'msg'=>'密码不正确',
                ]);
            }else{
                $cookies=Db::table('storeadmin')->where('username',$data['username'])->field('storeId,username,limited')->find();
                return json($data=[
                    'flag'=>true,
                    'msg'=>'登录成功',
                    'cookies'=>$cookies
                ]);
            }
        }
    }
    /*注册商家账号*/
    public function register(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        $data['username']=$data['username'];
        $data['pwd']=$data['pwd'];
        $data['phone']=$data['phone'];
        if(Db::table('storeadmin')->where('username',$data['username'])->find()==null){
            $insert=[
                'username'=>$data['username'],
                'pwd'=>$data['pwd'],
                'phone'=>$data['phone']
                ];
            Db::table('storeadmin')->insert($insert);
            $username=Db::table('storeadmin')->where('username',$data['username'])->value('username');
            return json($res=[
                'flag'=>true,
                'msg'=>'注册成功',
                'username'=>$username,
                'limited'=>2
            ]);
        }else{
            return json($res=[
               'flag'=>false,
                'msg'=>'账号已被占用'
            ]);
        }
    }
    //申请开通店铺
    public function store_apply(){
        $parm=file_get_contents('php://input');
        $data=json_decode($parm,true);
        $storeid=substr($data['id_card'], -6, 6).strval(time());
        $insert=[
            'username'=>$data['username'],
            'nickname'=>$data['nickname'],
            'storename'=>$data['storename'],
            'phone'=>$data['phone'],
            'id_card'=>$data['id_card'],
            'city'=>$data['city'],
            'location'=>$data['location'],
            'city_j'=>$data['city_j'],
            'city_w'=>$data['city_w'],
            'state'=>1,
            'storeId'=>$storeid
            ];
        Db::table('store_apply')->insert($insert);
        return json($insert);
    }
    //查询店铺开通情况
    public function checkstore(Request $request){
        $data=$request->param();
        $res=Db::table('store_apply')->where('username',$data['username'])->field('state,storeId')->find();
        return json($res);
    }
    //获取店铺申请信息
    public function get_apply(){
        $res=Db::table('store_apply')->where('state','1')->select();
        return json($res);
    }
    //修改申请审核的状态
    public function chance_state(Request $request){
        $data=$request->param();
        Db::table('store_apply')->where('username',$data['username'])->update(['state'=>3]);
        $insert=Db::table('storeadmin')->where('username',$data['username'])->update(['id_card'=>$data['id_card'],'storeId'=>$data['storeId']]);
        $apply=Db::table('store_apply')->where('username',$data['username'])->find();
        $store=[
            'storeId'=>$apply['storeId'],
            'storename'=>$apply['storename'],
            'city'=>$apply['city'],
            'location'=>$apply['location'],
            'city_j'=>$apply['city_j'],
            'city_w'=>$apply['city_w'],
            'store_status'=>0
        ];
        $insert2=Db::table('store')->insert($store);
        if($insert==true||$insert2==true){
            return json($res=[
               'flag'=>true,
               'msg'=>'已通过'
            ]);
        }else{
            return json($res=[
                'flag'=>flase,
                'msg'=>'数据插入有问题！！！'
            ]);
        }

    }
}