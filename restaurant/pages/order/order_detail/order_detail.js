// pages/order/order_detail/order_detail.js
const app=getApp()
Page({

  /**
   * 页面的初始数据
   */
  data: {
    model:false,
    order_food:[],
    sumMoney:null,
    time:'',
    orderId:'',
    no:'',
    comment:'',
    hiddenmodalput:true,
    feedback:'',
    foodId:'',
    storeId:''
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    if(options.info!=null){
      var info=JSON.parse(options.info);
      this.setData({
        order_food:info.food,
        sumMoney:info.sumMoney,
        time:info.date,
        orderId:info.orderId,
        no:info.no,
        comment:info.comment
      })
    }
    if(options.orderId!=null){
      this.setData({
        model:true
      })
     this.data.orderId=options.orderId;
     this.check_order();
    }
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    app.globalData.cartList=[];
    app.globalData.sumMoney=0
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
  to_orderlist(){
    wx.switchTab({
      url: '../../order_list/order_list',
    })
  },
  check_order(){
    var that=this;
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/order/check_order',
      header: {'content-type': 'application/json'},
      method:'GET',
      data:{
        orderId:this.data.orderId
      },
      success(res){
        console.log(res.data)
        var data1=res.data;
        that.setData({
          order_food:data1.food,
          sumMoney:data1.info[0].total,
          time:data1.info[0].time,
          no:data1.info[0].No,
          comment:data1.info[0].comment,
          orderId:that.data.orderId,
          storeId:data1.info[0].sellerId
        })
      }
    })
  },
  //弹窗相关
  modal(e){
    //获取foodid和orderid
    if(e.currentTarget.dataset.comment[0]==0){
      var id=e.currentTarget.dataset.comment[1];
      this.setData({
        hiddenmodalput:!this.data.hiddenmodalput,
        foodId:id
      })
    }
  },
  input_comment(e){
    this.setData({
      feedback:e.detail.value
    })
    console.log(this.data.feedback);
  },
  confirm(e){
    if(this.data.feedback==''){
      wx.showToast({
        title: '请输入评论',
        image:'../../img/no.png',
        duration: 2000
       })
    }else{
      var that=this;
      wx.request({
        url: 'http://www.restaurant.com/index.php/index/order/feedback',
        method:'GET',
        header: {'content-type': 'application/json'},
        data:{
          orderId:that.data.orderId,
          foodId:that.data.foodId,
          feedback:that.data.feedback,
          openid:app.globalData.openid,
          storeId:that.data.storeId
        },
        success(res){
          console.log(res.data)
          that.check_order()
          that.setData({
            hiddenmodalput:true,
            feedback:''
          })
        }
      })
    
  }
  },
  cancel(){
    this.setData({
      hiddenmodalput:true,
      feedback:''
    })
  }
})