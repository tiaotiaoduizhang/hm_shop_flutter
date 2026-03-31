import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  //推荐
  final SpecialOffer specialOffer;
  const HmSuggestion({super.key, required this.specialOffer});

  @override
  State<HmSuggestion> createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  List<Item> _getItems() {
    //判断是否为空
    if (widget.specialOffer.subTypes.isEmpty) {
      return [];
    }
    //取出其中前三个
    return widget.specialOffer.subTypes.first.goodsItems.items.take(3).toList();
  }

  List<Widget> _getItemWidgets() {
    //取出三个商品
    final List<Item> items = _getItems();
    return List.generate(items.length, (int index) {
      return Column(
        children: [
          //可裁剪图片的组件
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              //若有图片无法加载，自动替换为本地图片
              errorBuilder: (context, error, stackTrace) {
                //返回新的图片替换它
                return Image.asset(
                  "lib/assets/home_bg_sug.webp",
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                );
              },
              items[index].picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 96, 12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "￥${items[index].price}",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 86, 24, 20),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 124, 63, 58),
          ),
        ),
      ],
    );
  }

  //左侧结构
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_list_left.webp"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage("lib/assets/home_list_left.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            //顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeft(),
                //平铺组件，占满剩余空间
                Expanded(
                  child: Row(
                    //均分
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getItemWidgets(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}