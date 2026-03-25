import 'package:flutter/material.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 获取滚动容器内容
  List<Widget> _getScrollChildren() => [
    // 把一个普通的 Widget（Box Widget）包装成 Sliver ，让它可以放进 CustomScrollView.slivers 里。
    SliverToBoxAdapter(
      child: HmSlider(), //轮播图组件
    ),
    // 间隔
    SliverToBoxAdapter(child: Container(height: 10)),
    //分类组件
    SliverToBoxAdapter(child: HmCategory()),
    // 间隔
    SliverToBoxAdapter(child: Container(height: 10)),
    // 推荐
    SliverToBoxAdapter(child: HmSuggestion()),
    // 间隔
    SliverToBoxAdapter(child: Container(height: 10)),
    //热门商品组件
    SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(child: HmHot()),
          SizedBox(width: 10),
          Expanded(child: HmHot()),
        ]),
      ),
    ),
      // 间隔
    SliverToBoxAdapter(child: Container(height: 10)),
    //更多商品组件（无线滚动）
    HmMoreList()
    // SliverToBoxAdapter(child: HmMoreList()),
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
