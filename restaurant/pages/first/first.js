// pages/first/first.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    picture:null,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.show_picture();
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

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },
  show_picture: function () {
    var that = this;
    wx.request({
    url: 'http://www.restaurant.com/index.php/index/restaurant/lunbo',
    method: 'GET',
    header: {
    'content-type': 'application/json'
    },
    success(res) {
    var picture = res.data;
    that.setData({
    picture: picture,
    })
    console.log(that.data.picture[1].url);
    },
    fail(res) {
    console.log(res.data);
    }
    })
    },

    go_url:function(e){
      var url=e.currentTarget.dataset.url;
      console.log(url);
      wx.navigateTo({
        url: url,
      })
    },
  //去选择门店
   to_home(){
     wx.navigateTo({
       url: '../home/home',
     })
   },
   //跳转到订单列表
   to_orderlist(){
     wx.switchTab({
       url: '../order_list/order_list',
     })
   }

})