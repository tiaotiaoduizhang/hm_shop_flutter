import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  // 分类数据
  List<CategoryItem> categoryList = [];
  // 构造函数
  HmCategory({Key? key, required this.categoryList}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    // return ListView() 不能这样用，需要给高度
    return SizedBox(
      height: 100,
      // ListView.builder是 ListView 的“按需构建（lazy build）”用法：列表滚动到哪个位置，就只创建那一屏附近需要显示的子项，比一次性把所有 children 都创建出来更省内存、也更适合长列表
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (context, index) {
          // 分类数据
          CategoryItem categoryItem = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 10),
            //decoration是Container 的“盒子装饰”，专门用来画背景、圆角、边框、阴影、渐变
            // Container 设置“背景色 + 圆角”的装饰样式，作用等价于前端里给一个 div 写 background-color 和 border-radius 。
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(categoryItem.picture ?? '',width: 40,height: 40,),
                Text(categoryItem.name ?? '',style: TextStyle(color: Colors.white)),
              ],
            ),
          );
        },
     
      ),
    );
  }
}