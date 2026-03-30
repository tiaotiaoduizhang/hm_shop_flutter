import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSuggestion extends StatefulWidget {
  final SpecialOfferRecommendation hotPreferenceList;
  HmSuggestion({Key? key, required this.hotPreferenceList}) : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  // 取前3条数据
  List<SpecialOfferGoodsItem> _getDisplayItems() {
    final subTypes = widget.hotPreferenceList.subTypes;
    if (subTypes == null || subTypes.isEmpty) return [];
    final items =
        subTypes.first.goodsItems?.items ?? const <SpecialOfferGoodsItem>[];
    return items.take(3).toList();
  }

  // 构建标题
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          '特惠推荐',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10),
        Text('精选省攻略', style: TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );
  }

  // 构建列表左侧
  Widget _buildListLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('lib/assets/home_list_left.webp'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  List<Widget> _getChildrenList() {
    final list = _getDisplayItems(); // 取到前3条数据
    return List.generate(list.length, (index) {
      final item = list[index];
      return Expanded(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 100 / 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.picture ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'lib/assets/home_list_left.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue,
              ),
              child: Text(
                '¥${item.price}',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }

  // 构建列表项
  Widget _buildListItem(SpecialOfferGoodsItem item) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(item.picture ?? ''),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // 完成渲染
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            image: AssetImage('lib/assets/home_bg_sug.webp'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildListLeft(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getChildrenList(),
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
