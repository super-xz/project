<?php
namespace app\index\controller;
header("Access-Control-Allow-Origin: *");
use think\Db;

class Index
{
    public function index()
    {
        return '<style type="text/css">*{ padding: 0; margin: 0; } .think_default_text{ padding: 4px 48px;} a{color:#2E5CD5;cursor: pointer;text-decoration: none} a:hover{text-decoration:underline; } body{ background: #fff; font-family: "Century Gothic","Microsoft yahei"; color: #333;font-size:18px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.6em; font-size: 42px }</style><div style="padding: 24px 48px;"> <h1>:)</h1><p> ThinkPHP V5<br/><span style="font-size:30px">十年磨一剑 - 为API开发设计的高性能框架</span></p><span style="font-size:22px;">[ V5.0 版本由 <a href="http://www.qiniu.com" target="qiniu">七牛云</a> 独家赞助发布 ]</span></div><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_bd568ce7058a1091"></thinkad>';
    }

    public function login(){
        $wxname=$_GET['nickname'];
        $head=$_GET['avatarUrl'];
        $openid=$_GET['openid'];
        if(Db::table('user')->where('openid',$openid)->find()==null)
        {
            $data= [
                'openid'=>$openid,
                'wxname'=>$wxname,
                'head'=>$head
            ];
            Db::table('user')->insert($data);
            $result=Db::table('user')->where('openid',$openid)->find();
            return json($result);
        }else{
            $data= [
                'wxname'=>$wxname,
                'head'=>$head
            ];
            Db::table('user')->where('openid',$openid)->update($data);
            return '登录成功';
        }
        //return json($arr['openid']);
    }

    public function openId(){//获取用户ID
        $code=$_GET["code"];
        $appid="wxa026933a56bc5568";
        $secret="9495f4bbb2bde67e09e5f81e71084c7f";
        //调用微信接口来获取open
        $info= file_get_contents("https://api.weixin.qq.com/sns/jscode2session?appid=".$appid."&secret=".$secret."&js_code=".$code."&grant_type=authorization_code");
        $json=json_decode($info);//对json数据解码
        $arr=get_object_vars($json);
        return json($arr['openid']);
        }
}
