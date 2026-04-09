import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/My/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //定义数据 根据数据进行渲染4个导航栏
  final List<Map<String, String>> _tabsList = [
    {
      'ico': 'lib/assets/tabbar/home-inactive.png',
      'active_ico': 'lib/assets/tabbar/home-active.png',
      'text': '首页',
    },
    {
      'ico': 'lib/assets/tabbar/notary-inactive.png',
      'active_ico': 'lib/assets/tabbar/notary-active.png',
      'text': '分类',
    },
    {
      'ico': 'lib/assets/tabbar/review-inactive.png',
      'active_ico': 'lib/assets/tabbar/review-active.png',
      'text': '购物车',
    },
    {
      'ico': 'lib/assets/tabbar/my-inactive.png',
      'active_ico': 'lib/assets/tabbar/my-active.png',
      'text': '我的',
    },
  ];
  int _currentIndex = 0; // 当前选中的索引
  //4个导航栏渲染函数
  List<BottomNavigationBarItem> _getTabItems() {
    return List.generate(_tabsList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(
          _tabsList[index]['ico']!,
          width: 30,
          height: 30,
        ), // 正常图片
        activeIcon: Image.asset(
          _tabsList[index]['active_ico']!,
          width: 30,
          height: 30,
        ), //点击图片
        label: _tabsList[index]['text'],
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MyView()];
  }

  void initState() {
    super.initState();
    // 初始化用户
    _initUser();
  }

  final UserController _userController = Get.put(UserController());
  _initUser() async {
    // 初始化用户信息
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      _userController.updateUserInfo(await getUserInfoApi());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text('主页')),
      //SafeArea 避开安全区组件
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          //放置几个组件
          children: _getChildren(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _getTabItems(),
        currentIndex: _currentIndex,
      ),
    );
  }
}
