import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/mine.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Mine/HmGuess.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/viewmodels/home.dart';

class MyView extends StatefulWidget {
  MyView({Key? key}) : super(key: key);

  @override
  _MyViewState createState() => _MyViewState();
}

/**
 * Widget _buildHeader  抽成一个方法，返回一个 Widget,方便在build() 里复用/组合
 * Container 通用容器：用来设置背景，内边距以及包裹子组件
 * decoration: BoxDecoration 给 Container 加“装饰样式”（背景、圆角、阴影、渐变等）。
 * CircleAvatar 圆形头像组件
 *   const SizedBox(width: 12),在头像和右侧内容之间加 12 的水平间距。
 * Expanded  表示右侧这一块“占满 Row 剩余空间”，避免文字区域挤压/溢出。
 * CrossAxisAlignment：让 Column 内部子元素左对齐。
 * GestureDetector(onTap: () { ... }, child: Text(...))给 “立即登录” 文本加点击事件
 * Navigator.pushNamed(context, "/login")用命名路由跳转到 /login 页面（
 */
class _MyViewState extends State<MyView> {
  final UserController _userController = Get.put(UserController());
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFF2E8), const Color(0xFFFDF6F1)],
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 40, top: 80, bottom: 20),
      child: Row(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 26,
              backgroundImage: _userController.user.value.avatar.isNotEmpty
                  ? NetworkImage(_userController.user.value.avatar)
                  : const AssetImage('lib/assets/goods_avatar.png'),
              backgroundColor: Colors.white,
            ),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (_userController.user.value.id.isEmpty) {
                        Navigator.pushNamed(context, "/login");
                      }
                    },
                    child: Text(
                      _userController.user.value.nickname.isNotEmpty
                          ? _userController.user.value.nickname
                          : '立即登录',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 197, 153),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/ic_user_vip.png", width: 30, height: 30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '升级美荟商城会员，尊享无限免邮',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 44, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('立即开通', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  /**
 * Widget item(String pic, String label),在 _buildQuickActions 内部定义的“局部函数”，用来生成单个入口
 * MainAxisSize.min 让 Column 只占自己内容需要的高度，不强行撑满父容器高度。
 * SizedBox(height: 6) 图标和文字之间的间距。
 */
  Widget _buildQuickActions() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/ic_user_collect.png", '我的收藏'),
            item("lib/assets/ic_user_history.png", '我的足迹'),
            item("lib/assets/ic_user_unevaluated.png", '我的客服'),
          ],
        ),
      ),
    );
  }

  /**
 *  mainAxisSize: MainAxisSize.min, 是 控制 Column（或 Row）在主轴方向占用空间大小 的属性
 * Column 的高度只包裹内容需要的高度 （有多高用多高），不会强行撑到父容器允许的最大高度。
 */
  Widget _buildOrderModule() {
    // 局部函数，用来生成单个订单状态类型
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    /**
   * 订单模块的布局
   * Card Flutter 的 Material 卡片组件，自带阴影等效果。
   * shape 卡片外形圆角 12
   * elevation 阴影高度（越大阴影越明显）。
   */
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '我的订单',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  orderItem("lib/assets/ic_user_order.png", '全部订单'),
                  orderItem("lib/assets/ic_user_obligation.png", '待付款'),
                  orderItem("lib/assets/ic_user_unreceived.png", '待发货'),
                  orderItem("lib/assets/ic_user_unshipped.png", '待收货'),
                  orderItem("lib/assets/ic_user_unevaluated.png", '待评价'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<GoodDetailItem> _list = [];
  //分页的请求参数
  Map<String, dynamic> _params = {'page': 1, 'pageSize': 10};

  @override
  void initState() {
    super.initState();
    _getGuessList();
    _registerEvent();
  }

  void _registerEvent() {
    _scrollController.addListener(() {
      // 滚动逻辑
      if (_scrollController.position.pixels <=
          (_scrollController.position.maxScrollExtent - 50)) {
        // 滚动到底部
        _getGuessList();
      }
    });
  }

  // 阀门控制
  bool _isLoading = false; //是否有人正在加载
  bool _hasMore = true; //是否还有更多数据
  void _getGuessList() async {
    if (_isLoading || !_hasMore) {
      // 有人正在加载或者没有下一页就不请求
      return;
    }
    _isLoading = true;
    final res = await getGuessListApi(_params);
    _isLoading = false;
    _list.addAll(res.items); //把内容追加到尾部
    if (_params['page'] >= res.pages) {
      _hasMore = false; //已经没有下一页
    }
    _params['page']++; //针对页面进行加
    setState(() {});
  }

  final ScrollController _scrollController = ScrollController();
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildVipCard()),
        SliverToBoxAdapter(child: _buildQuickActions()),
        SliverToBoxAdapter(child: _buildOrderModule()),
        // pinned: true,表示吸住的意思
        SliverPersistentHeader(pinned: true, delegate: HmGuess()),
        // 猜你喜欢
        HmMoreList(goodsList: _list), //上拉加载
      ],
    );
  }
}
