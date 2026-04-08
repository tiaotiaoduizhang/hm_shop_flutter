import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
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
  List<BannerItem> _bannerList = [];
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
    SliverToBoxAdapter(child: HmSuggestion(specialOffer: _specialOffer)),
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
            Expanded(
              child: HmHot(result: _oneStopResult, type: "step"),
            ),
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
    _registerEvent();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _key.currentState?.show();
    });
  }
  //initState>build=>下拉刷新组件=>才可以操作它
  //Futter.micoTask 微任务逻辑

  // 监听滚动到底部的事件
  void _registerEvent() async {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 50)) {
        print("滚动到底部");
        // 滚动到底部
        _getRecommendListApi();
      }
    });
  }

  // 获取热门榜推荐数据
  Future<void> _getInVogueListApi() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐数据
  Future<void> _getOneStopListApi() async {
    _oneStopResult = await getOneStopListAPI();
  }

  // 获取特惠推荐数据
  Future<void> _getHotPreferenceListApi() async {
    _specialOffer = await getSpecialOfferAPI();
  }

  // 页码
  int _page = 1;
  bool _isLoading = false; //当前正在加载状态
  bool _hasMore = true; //是否还有下一页
  // 获取推荐列表数据
  Future<void> _getRecommendListApi() async {
    // 当已经有请求正在加载或者已经没有下一页，就放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true; //站住位置
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false; //释放位置
    if (_recommendList.length < requestLimit) {
      //判断是否还有下一页
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 获取轮播图数据
  Future<void> _getBannerListApi() async {
    _bannerList = await getBannerListApi();
  }

  // 获取分类数据
  Future<void> _getCategoryListApi() async {
    _categoryList = await getCategoryListApi();
  }

  // 下拉刷新
  Future<void> _refresh() async {
    _paddingTop = 100;
    setState(() {});
    _page = 1;
    _hasMore = true;
    _isLoading = false;
    await _getBannerListApi();
    await _getCategoryListApi();
    await _getHotPreferenceListApi();
    await _getInVogueListApi();
    await _getOneStopListApi();
    await _getRecommendListApi();
    //数据获取成功，刷新成功后
    ToastUtils.showToast(context, "刷新成功");
    _paddingTop = 0;
    setState(() {});
  }

  final ScrollController _scrollController = ScrollController();
  // globalkey是一个方法可以创建一个key绑定widget部件上，可以操作widget部件
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _refresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
