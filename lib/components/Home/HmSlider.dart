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
  Widget _getSlider() {
    //在flutter中获取屏幕宽度的方法：MediaQuery.of(context).size.width
    double screenWidth = MediaQuery.of(context).size.width;
    // 返回轮播插件
    //根据数据渲染不同的轮播选项
    return CarouselSlider(
      items: List.generate(
        widget.bannerList.length,
        (int index) => (Image.network(
          widget.bannerList[index].imageUrl!,
          fit: BoxFit.cover,
          width: screenWidth,
        )),
      ),
      options: CarouselOptions(viewportFraction: 1, autoPlay: true, autoPlayInterval:  Duration(seconds: 5),height: 300,),
    );
  }

  @override
  Widget build(BuildContext context) {
    //strack ->轮播图 搜索框 指示灯导航
    return Stack(children: [_getSlider()]);
  }
}
