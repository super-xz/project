// pages/order_list/order_list.js
const app=getApp()
Page({

  /**
   * 页面的初始数据
   */
  data: {
    order_list:[]
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
    this.order_list()
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
  order_list(){
    var that=this;
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/order/order_list',
      header: {'content-type': 'application/json'},
      method: 'GET',
      data:{
        openid:app.globalData.openid
      },
      success(res){
        that.setData({
          order_list:res.data
        })
        console.log(res.data)
      }
    })
  },
  order_detail(e){
    var i=e.currentTarget.dataset.index;
    var orderid=this.data.order_list[i].orderId;
    wx.navigateTo({
      url: '../order/order_detail/order_detail?orderId='+orderid,
    })
  },
  toStore(e){
    var i=e.currentTarget.dataset.index;
  app.globalData.storeId=this.data.order_list[i].sellerId;
  app.globalData.listdata_change=true;
  wx.switchTab({
    url: '../list/list',
  })
  }
})