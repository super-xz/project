const app=getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    food_detail:[],
    currentTab:'miaoshu',
    flag:0,
    feekback:[]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      food_detail:app.globalData.food_detail
    })
    this.show_comment();
    console.log(this.data.food_detail)
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
  //点击滑动nav
  switchNav(e){
    var page=this;
    var id=e.target.id;
    if(this.data.currentTab==id){
      return false;
    }else{
      page.setData({currentTab:id})
    }
    page.setData({flag:id})
  },
  //滑动nav内容
  changeTab: function (e) {
    this.setData({
      flag: e.detail.current,
      cid:e.detail.currentItemId
    })
  },
  //获取评论
  show_comment(){
    var that=this;
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/restaurant/show_comment',
      method:'GET',
      header: {'content-type': 'application/json'},
      data:{
        storeId:this.data.food_detail.storeId,
        foodId:this.data.food_detail.foodId
      },
      success(res){
        that.setData({
          feekback:res.data
        })  
        console.log(that.data.feekback);
        console.log(that.data.feekback.length);
      }
    })
  }
})