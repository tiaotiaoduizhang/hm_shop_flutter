import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart'; //轮播图数据对象类型

class HomeView extends StatefulWidget {
 HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 分类数据
  List<CategoryItem> _categoryList = [];
  // 轮播图数据
  List<BannerItem> _bannerList = [
    // BannerItem('1', 'https://gips3.baidu.com/it/u=3886271102,3123389489&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960'),
    // BannerItem('2', 'https://gips1.baidu.com/it/u=3874647369,3220417986&fm=3028&app=3028&f=JPEG&fmt=auto?w=720&h=1280'),
    // BannerItem('3', 'https://gips2.baidu.com/it/u=853190258,2588232240&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=720'),
  ];
  // 获取滚动容器内容
  List<Widget> _getScrollChildren() => [
    // 把一个普通的 Widget（Box Widget）包装成 Sliver ，让它可以放进 CustomScrollView.slivers 里。
    SliverToBoxAdapter(
      child: HmSlider(bannerList: _bannerList), //轮播图组件
    ),
    // 间隔
    SliverToBoxAdapter(child: Container(height: 10)),
    //分类组件
    SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
    // 间隔
    SliverToBoxAdapter(child: Container(height: 10)),
    // 推荐
    SliverToBoxAdapter(child: HmSuggestion(specialOffer: _specialOffer )),
    // 间隔
    SliverToBoxAdapter(child: Container(height: 10)),
    //热门商品组件
    SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
            SizedBox(width: 10),
            Expanded(child: HmHot(result: _oneStopResult, type: "step")),
          ],
        ),
      ),
    ),
    // 间隔
    SliverToBoxAdapter(child: Container(height: 10)),
    //更多商品组件（无线滚动）
    HmMoreList(goodsList: _recommendList),
    // SliverToBoxAdapter(child: HmMoreList()),
  ];
  // 特惠推荐数据
  SpecialOffer _specialOffer = SpecialOffer(id: "", title: "", subTypes: []);
    // 热榜推荐
  SpecialOffer _inVogueResult = SpecialOffer(id: "", title: "", subTypes: []);
  // 一站式推荐
  SpecialOffer _oneStopResult = SpecialOffer(id: "", title: "", subTypes: []);
    // 推荐列表
  List<GoodDetailItem> _recommendList = [];
  // 初始化
  @override
  void initState() {
    super.initState();
    _getBannerListApi();
    _getCategoryListApi();
    _getHotPreferenceListApi();
    _getInVogueListApi();
    _getOneStopListApi();
    _getRecommendListApi();
  }
  // 获取热门榜推荐数据
  void _getInVogueListApi() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }
  // 获取一站式推荐数据
  void _getOneStopListApi() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }
  // 获取特惠推荐数据
  void _getHotPreferenceListApi() async {
    _specialOffer = await getSpecialOfferAPI();
    setState(() {});
  }
  // 获取推荐列表数据
  void _getRecommendListApi() async {
    _recommendList = await getRecommendListAPI({
      "page": 1,
      "limit": 10,
    });
    setState(() {});
  }
  // 获取轮播图数据
  void _getBannerListApi() async {
    _bannerList = await getBannerListApi();
    setState(() {});
  }

  // 获取分类数据
  void _getCategoryListApi() async {
    _categoryList = await getCategoryListApi();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
