import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart'; //轮播图数据对象类型
import 'package:carousel_slider/carousel_slider.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController(); //控制轮播图跳转的控制器
  int _currentIndex = 0; //当前选中的轮播图索引
  /// 搜索框
  Widget _getSearch() {
    //container div+style
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text('搜索', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  //返回指示灯导航组件
  Widget _getDots() {
    //container div+style
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, //主轴居中
          children: List.generate(
            widget.bannerList.length,
            (int index) => GestureDetector(
              onTap: () {
                buttonCarouselController.jumpToPage(index);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: index == _currentIndex ? 40 : 20,
                height: 6,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentIndex?Colors.white:Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSlider() {
    //在flutter中获取屏幕宽度的方法：MediaQuery.of(context).size.width
    double screenWidth = MediaQuery.of(context).size.width;
    // 返回轮播插件
    //根据数据渲染不同的轮播选项
    return CarouselSlider(
      carouselController: buttonCarouselController,
      items: List.generate(
        widget.bannerList.length,
        (int index) => (Image.network(
          widget.bannerList[index].imgUrl!,
          fit: BoxFit.cover,
          width: screenWidth,
        )),
      ),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        // autoPlayInterval: Duration(seconds: 5),
        height: 300,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //strack ->轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
