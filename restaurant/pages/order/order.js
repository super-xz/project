// pages/order/order.js
const app=getApp()
Page({

  /**
   * 页面的初始数据
   */
  data: {
    comment:'',
    order_food:[],
    sumMoney:null
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
    this.cartList();
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },
  //备注栏绑定数据
  comment: function(e) {
    this.data.comment = e.detail.value;
    console.log(this.data.comment);
  },
  //获取购物车的数据
  cartList(){
    this.setData({
      sumMoney:app.globalData.sumMoney,
      order_food:app.globalData.cartList
    })
  },
  //模拟支付产生订单
  pay(){
    wx.showLoading({
      title: '支付中...',
    })
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/order/submit_order',
      data:{
        storeId:app.globalData.storeId,
        openId:app.globalData.openid,
        order_food:this.data.order_food,
        comment:this.data.comment,
        sumMoney:this.data.sumMoney
      },
      header: {
        'content-type': 'application/json'
        },
      method: 'GET',
      success: (res) => {
        console.log(res.data);
        app.globalData.listdata_change=true
        wx.hideLoading();
        wx.navigateTo({
          url: 'order_detail/order_detail?info='+JSON.stringify(res.data),
        })
      },
    })
  }

})