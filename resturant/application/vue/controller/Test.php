<?php
namespace app\vue\controller;
header("Access-Control-Allow-Origin: *");
use think\Db;
use think\Request;

class Test
{
    public function test(){
        $data=file_get_contents('php://input');
        $data=json_decode($data,true);
        $data['hello']=$data['hello'];
        $data['b']=$data['b'];
        return json($data);
    }
    public function test2(Request $request){

        $data=$request->param();
        return json($data);
    }
    public function test3(Request $request){


        return "123";
    }
}