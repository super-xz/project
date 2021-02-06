// pages/me/favorite/favorite.js
const app=getApp()
Page({

  /**
   * 页面的初始数据
   */
  data: {
    favorite:[]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

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
    this.get_favorite()
  },
  //获取收藏的店铺
  get_favorite(){
    var that=this
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/restaurant/get_favorite',
      method:'POST',
      header: {"Content-Type": "application/x-www-form-urlencoded"},
      data:{
        openid:app.globalData.openid
      },
      success(res){
        that.setData({
          favorite:res.data
        })
        console.log(res.data);
      }
    })
  },

  //跳转到收藏的商铺
  to_store(e){
     var index= e.currentTarget.dataset.index;
     console.log(index);
     app.globalData.storeId=this.data.favorite[index].storeId;
     app.globalData.listdata_change=true
    wx.switchTab({
    url: '../../list/list',
  })
  }



 
})