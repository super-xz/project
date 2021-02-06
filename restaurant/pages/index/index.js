//index.js
//获取应用实例
const app = getApp()
Page({
  data: {
    userInfo: {},
    hasUserInfo: false,
    canIUse: wx.canIUse('button.open-type.getUserInfo'),
    url:'http://www.restaurant.com/index.php/index/index/'
  },
  onLoad: function () {
    if(app.globalData.openid!=null){
      wx.switchTab({
        url: '../first/first',
      })
    }
    if (app.globalData.userInfo) {
      this.setData({
        userInfo: app.globalData.userInfo,
        hasUserInfo: true
      })
    } else if (this.data.canIUse){
      // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
      // 所以此处加入 callback 以防止这种情况
      app.userInfoReadyCallback = res => {
        this.setData({
          userInfo: res.userInfo,
          hasUserInfo: true
        })
      }
    } else {
      // 在没有 open-type=getUserInfo 版本的兼容处理
      wx.getUserInfo({
        success: res => {
          app.globalData.userInfo = res.userInfo
          this.setData({
            userInfo: res.userInfo,
            hasUserInfo: true
          })
        }
      })
    }
  },
  getUserInfo: function(e) {
    console.log(e)
    app.globalData.userInfo = e.detail.userInfo
    this.setData({
      userInfo: e.detail.userInfo,
      hasUserInfo: true
    })
  },
  openid: function () {
    var that = this;
          wx.login({
            success(res) {
              if (res.code) {
                //发起网络请求
                 console.log(that.data.url);
                wx.request({
                  url: that.data.url+'openId', //php接口
                  method: 'GET',
                  data: {
                    avatarUrl: app.globalData.userInfo.avatarUrl,
                    code: res.code,
                    nickname: app.globalData.userInfo.nickName,
                    grant_type: 'authorization_code'
                  },
                  header: {
                    'content-type': 'application/json'
                  },
                  success: function (res) { //我这里用的后端是PHP
                    app.globalData.openid = res.data;
                    that.login();
                  }
                })
              } else {
                console.log('登录失败！' + res.errMsg)
              }
            }
          })

  },
  login:function(){
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/index/login',
      method:'GET',
      data:{
        avatarUrl: app.globalData.userInfo.avatarUrl,
        nickname: app.globalData.userInfo.nickName,
        openid:app.globalData.openid
      },
      header: {
        'content-type': 'application/json'
      },
      success: function (res) { //我这里用的后端是PHP
        console.log(res);
        wx.switchTab({
          url: '../first/first',
        })
      }
    })
  }
})
