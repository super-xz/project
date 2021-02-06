<?php
/**
 * Created by PhpStorm.
 * User: 17563
 * Date: 2020/12/23
 * Time: 15:08
 */

namespace app\vue\controller;
header("Access-Control-Allow-Origin: *");
use think\Db;
use think\Controller;
use think\Request;

class Img
{
    //上传轮播图
    public function  lunbo(){
        $file = request()->file('file');
        if ($file) {
            $info = $file->move(ROOT_PATH . 'public' . DS . 'upload'.DS.'lunbo');
            if ($info) {
                $imgs = 'http://www.restaurant.com/upload/lunbo/'.$info->getSavename();
            }
        }
        return json($imgs);
}
     //删除上传的轮播图片
     public function del_lunbo(){
         $data=file_get_contents('php://input');
         $data=json_decode($data,true);
         $filename=mb_substr($data['url'],26);
         unlink($filename);
         return '删除成功！！！';
     }
     //把轮播图添加到数据库
     public function add_lunbo(){
         $data = file_get_contents('php://input');
         $data = json_decode($data, true);
         $insert=[
             'pic'=>$data['pic'],
             'title'=>$data['title'],
             'state'=>0
         ];
         $ins=Db::table('lunbo')->insert($insert);
         if($ins){
             return '添加成功';
         }
     }
     //修改轮播图状态
     public function lunbo_state(){
         $data = file_get_contents('php://input');
         $data = json_decode($data, true);
         $up=Db::table('lunbo')->where('pid',$data['pid'])->update(['state'=>$data['state']]);
         if($up){
             return '更新成功';
         }
     }
     //删除轮播图
    public function delLunbo(){
        $data = file_get_contents('php://input');
        $data = json_decode($data, true);
        $filename=mb_substr($data['pic'],26);
        $img=unlink($filename);
        $sql=Db::table('lunbo')->where('pid',$data['pid'])->delete();
        if($img&&$sql){
            return '删除成功';
        }
    }
}