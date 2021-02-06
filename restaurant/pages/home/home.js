// pages/home/home.js
var QQMapWX = require('../../utils/qqmap-wx-jssdk1.0/qqmap-wx-jssdk.js');
var qqmapsdk;
var app=getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    province: '',
     city: '',
     latitude: '',
     longitude: '',
     store:[]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    qqmapsdk = new QQMapWX({
      key: 'XBTBZ-VRQCR-BDUWL-W7PI7-27J63-4GFWU' 
    });
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    wx.getSetting({
      success: (res) => {console.log(res)
        if (res.authSetting['scope.userLocation'] != undefined && res.authSetting['scope.userLocation'] != true) {
          wx.showModal({
            title: '请求授权当前位置',
            content: '需要获取您的地理位置，请确认授权',
            success: function (res) {
              if (res.cancel) {
                wx.showToast({
                  title: '拒绝授权',
                  icon: 'none',
                  duration: 1000
                })
              } else if (res.confirm) {
                wx.openSetting({
                  success: function (dataAu) {
                    if (dataAu.authSetting["scope.userLocation"] == true) {
                      wx.showToast({
                        title: '授权成功',
                        icon: 'success',
                        duration: 1000
                      })                  
                    } else {
                      wx.showToast({
                        title: '授权失败',
                        icon: 'none',
                        duration: 1000
                      })
                    }
                  }
                })
              }
            }
          })
        } else if (res.authSetting['scope.userLocation'] == undefined) {
          this.getLocation();
        }
        else {
          this.getLocation();
        }
      }
    });
    

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },
  // 微信获得经纬度
 getLocation: function () {
  let vm = this;
  wx.getLocation({
   type: 'wgs84',
   success: function (res) {
    var latitude = res.latitude
    var longitude = res.longitude
    vm.getLocal(latitude, longitude)
   },
   fail: function (res) {
    console.log('fail' + JSON.stringify(res))
   }
  })
 },
 // 获取当前地理位置
 getLocal: function (latitude, longitude) {
  let vm = this;
  qqmapsdk.reverseGeocoder({
   location: {
    latitude: latitude,
    longitude: longitude
   },
   success: function (res) {
    let province = res.result.ad_info.province
    let city = res.result.ad_info.city
    vm.setData({
     province: province,
     city: city,
     latitude: latitude,
     longitude: longitude
    })
    console.log(vm.data.city);
    //vm.get_store();
    vm.store_list();
   },
   fail: function (res) {
    console.log(res);
   },
   complete: function (res) {
     console.log(res);
   }
  });
 },
//  get_store:function(){
//    var that=this;
//    wx.request({
//      url: 'http://www.restaurant.com/index.php/index/restaurant/show_store',
//      method:'GET',
//      header: {
//       'content-type': 'application/json'
//       },
//       data:{
//         city:that.data.city
//       },
//       success(res){
//         that.setData({
//           store:res.data
//         })
//         for(var i=0;i<that.data.store.length;i++){
//           that.data.store[i].juli=that.distance(that.data.store[i].city_w,that.data.store[i].city_j,that.data.latitude,that.data.longitude);
//         }
//         that.setData({
//           store:that.data.store
//         })
//        console.log(that.data.store)
//       }
//    })
//  },
 
//  distance: function (la1, lo1, la2, lo2) {
//   var La1 = la1 * Math.PI / 180.0;
//   var La2 = la2 * Math.PI / 180.0;
//   var La3 = La1 - La2;
//   var Lb3 = lo1 * Math.PI / 180.0 - lo2 * Math.PI / 180.0;
//   var s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(La3 / 2), 2) + Math.cos(La1) * Math.cos(La2) * Math.pow(Math.sin(Lb3 / 2), 2)));
//   s = s * 6378.137;
//   s = Math.round(s * 10000) / 10000;
//   s = s.toFixed(2);
//   return s;
// },
//根据经纬度查询店铺
store_list(){
  var that=this;
  wx.request({
    url: 'http://www.restaurant.com/index.php/index/restaurant/store_list',
    method:'GET',
    header: {'content-type': 'application/json'},
    data:{
      lat: that.data.latitude,
      lng: that.data.longitude
    },
    success(res){
      that.setData({
        store:res.data
      })
      console.log(res.data);
    }
  })

},
to_list:function(e){
  var i=e.currentTarget.dataset.index;
  app.globalData.storeId=this.data.store[i].storeId;
  app.globalData.listdata_change=true;
  // app.globalData.store_info={
  //   storename:this.data.store[i].storename,
  //   juli:this.data.store[i].distance.toFixed(2)
  // }
  console.log(app.globalData.store_info)
  wx.switchTab({
    url: '../list/list',
  })
}
})
