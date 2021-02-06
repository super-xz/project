var app=getApp();
Page({
  data: {
    storeId:'',
    store_info:{},
    activeIndex:0,
    toView:'a0',
    loading:false,
    top:[],
    categoryHeight:[],
    sumMoney:0,
    food:[],
    cartList:[],
    showCart:false,
    cupNumber:0 //购物车总数量
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
    if(app.globalData.storeId==null){
      wx.redirectTo({
        url: '../home/home',
      })
    }
    if(app.globalData.storeId!=this.data.storeId){
      this.data.storeId=app.globalData.storeId;
      this.show_food();
      if(this.data.storeId!=null){
      this.getLocation()
      }
    }
    if(app.globalData.listdata_change==true){
      this.setData({
        sumMoney:0,
        cartList:[]
      })
      this.show_food()
      app.globalData.listdata_change=false
    }
    console.log(this.data.store_info)
    if(this.data.store_info.juli==null&&this.data.storeId!=null){
      //获取微信地理位置弹窗
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
     
    }
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

  selectMenu:function(e){
    var index=e.currentTarget.dataset.index;
    this.setData({activeIndex:index,toView:'a'+index})
  },
  onFoodScroll:function(e){
    var scrollTop = e.detail.scrollTop
   var select_height=0;
   for(var i=0;i<this.data.food.length;i++){
     select_height+=this.data.food[i].food.length*77+16.3;
     if(select_height>=scrollTop){
       this.setData({
         activeIndex:i
       })
       break
     }
   }
    },
  onTop:function(){
    this.data.activeIndex=this.data.food.length-1;
    
  },
  back_home(){
    wx.navigateTo({
      url: '../home/home',
    })
  },
  //获取菜品信息
  show_food:function(){
    var that=this;
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/restaurant/show_food',
      method:'GET',
      header: {
        'content-type': 'application/json'
        },
        data:{
          storeId:app.globalData.storeId
        },
        success:function(res){
          that.setData({
            food:res.data
          })
          console.log(res.data)
        }
    })
  },
  todetail:function(e){
    var i=e.currentTarget.dataset.index;
    var i2=e.currentTarget.dataset.indexs;
    app.globalData.food_detail=this.data.food[i].food[i2];
     wx.navigateTo({
       url: 'detail/detail',
     })
  },
  add_food(e){
    var i=e.currentTarget.dataset.index;
    var i2=e.currentTarget.dataset.indexs;
    var success=false;
    this.data.food[i].food[i2].number+=1;
    for(var j in this.data.cartList){
      if(this.data.cartList[j].id== this.data.food[i].food[i2].foodId){
        this.data.cartList[j].number+=1;
        var sumMoney=this.data.sumMoney+this.data.food[i].food[i2].price*this.data.food[i].food[i2].discount;
        success=true;
        console.log(this.data.cartList);
        var that=this;
        that.setData({
          cartList:that.data.cartList,
          sumMoney:sumMoney,
          food:that.data.food
        })
        break;
      }
    }
    if(!success){
      var addItem={
        id:this.data.food[i].food[i2].foodId,
        name:this.data.food[i].food[i2].foodName,
        price:this.data.food[i].food[i2].price,
        url:this.data.food[i].food[i2].imgurl,
        number:1,
        discount:this.data.food[i].food[i2].discount,
        cid:i,
        index:i2
      }
      var sumMoney=this.data.sumMoney+this.data.food[i].food[i2].price*this.data.food[i].food[i2].discount;
      var cartList=this.data.cartList;
      cartList.push(addItem);
      var that=this;
    this.setData({
      food:this.data.food,
      cartList:cartList,
      sumMoney:sumMoney,
      cupNumber:that.data.cupNumber+1
    })
    console.log(that.data.cartList)
    }
  
  },
  jian_food(e){
    var i=e.currentTarget.dataset.index;
    var i2=e.currentTarget.dataset.indexs;
      this.data.food[i].food[i2].number-=1;
      for(var j in this.data.cartList){
        if(this.data.cartList[j].id== this.data.food[i].food[i2].foodId){
          --this.data.cartList[j].number;
          var sumMoney=this.data.sumMoney-this.data.food[i].food[i2].price*this.data.food[i].food[i2].discount;
          if(this.data.cartList[j].number==0){
            this.data.cartList.splice(j,1);
          }
          var that=this;
          this.setData({
            food:that.data.food,
            sumMoney:sumMoney,
            cartList:that.data.cartList
          })
        }
      }

  },
  //购物车内容展开或隐藏
  showCartList(){
    if(this.data.cartList.length!=0){
      this.setData({
        showCart:!this.data.showCart
      })
    }
  },
  //清除购物车
  cartClear(){
    for(var j in this.data.cartList){
      var i=this.data.cartList[j].cid;
      var i2=this.data.cartList[j].index;
      this.data.food[i].food[i2].number=0;
    }
    var that=this;
    this.setData({
      food:that.data.food,
      sumMoney:0,
      cartList:[],
      showCart:false
    })
  },
  //购物车-
  cartNumberDec(e){
    var j=e.currentTarget.dataset.id;
    var i=this.data.cartList[j].cid;
    var i2=this.data.cartList[j].index;
    --this.data.food[i].food[i2].number;
    --this.data.cartList[j].number;
    var sumMoney=this.data.sumMoney-this.data.food[i].food[i2].price*this.data.food[i].food[i2].discount;
    if(this.data.cartList[j].number==0){
      this.data.cartList.splice(j,1);
      if(this.data.cartList.length==0){
        this.data.showCartList=false;
      }
    }
    var that=this;
    that.setData({
      food:that.data.food,
      sumMoney:sumMoney,
      cartList:that.data.cartList,
      showCart:that.data.showCartList
    })
    
  },
  //购物车+
  cartNumberAdd(e){
    var j=e.currentTarget.dataset.id;
    var i=this.data.cartList[j].cid;
    var i2=this.data.cartList[j].index;
    ++this.data.food[i].food[i2].number;
    ++this.data.cartList[j].number;
    var sumMoney=this.data.sumMoney+this.data.food[i].food[i2].price*this.data.food[i].food[i2].discount;
    var that=this;
    that.setData({
      food:that.data.food,
      sumMoney:sumMoney,
      cartList:that.data.cartList
    })
  },
  //确认订单
  to_order(){
    if(this.data.sumMoney!=0){
      if(app.globalData.openid!=null){
      app.globalData.cartList=this.data.cartList;
      app.globalData.sumMoney=this.data.sumMoney;
      wx.navigateTo({url:"../order/order"})
      }else{
        wx.showToast({
          title: '请您先登录',
          icon: 'success',
          duration: 2000
        })
        wx.switchTab({url:"../index/index"})
      }
    }
  },

   // 微信获得经纬度
   getLocation: function () {
    let vm = this;
    wx.getLocation({
     type: 'wgs84',
     success: function (res) {
      app.globalData.lat = res.latitude
      app.globalData.lng = res.longitude
      vm.get_store();
     },
     fail: function (res) {
      console.log('fail' + JSON.stringify(res))
     }
    })
   },

   //获取店铺信息
   get_store(){
    var that=this;
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/restaurant/store_info',
      method:'GET',
      header: {'content-type': 'application/json'},
      data:{
        storeId:app.globalData.storeId,
        openid:app.globalData.openid,
        lat:app.globalData.lat,
        lng:app.globalData.lng,
      },
      success(res){
        res.data[0].juli;
        that.setData({
          store_info:res.data[0]
        })
        console.log(that.data.store_info);
      }
    })
   },
   //收餐店铺或取消收藏
   favorite(){
     var that=this;
    wx.request({
      url: 'http://www.restaurant.com/index.php/index/restaurant/favorite',
      method:'POST',
      header: {"Content-Type": "application/x-www-form-urlencoded"},
      data:{
        storeid:app.globalData.storeId,
        openid:app.globalData.openid
      },
      success(res){
        wx.showToast({
          title: res.data,
          icon: 'success',
          duration: 1000,
          mask:true
        })
        that.data.store_info.favorite=that.data.store_info.favorite==0?1:0;
        that.setData({
          store_info:that.data.store_info
        })
        console.log(res.data);
        console.log(that.data.store_info.favorite)
      }
    })
   }
})