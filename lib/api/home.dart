// 封装一个api目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  //  返回请求
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((
    item,
  ) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

// 分类数据
Future<List<CategoryItem>> getCategoryListApi() async {
  //  返回请求
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return CategoryItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

//特惠推荐列表
Future<SpecialOffer> getSpecialOfferAPI() async {
  //返回请求，先得到data中的列表，再转为map类型，使用formJSON解构提取id与imgUrl。最后再转为list列表
  return SpecialOffer.fromJson(
    (await dioRequest.get(HttpConstants.PRODUCT_LIST)) as Map<String, dynamic>,
  );
}
// 热榜推荐
Future<SpecialOffer> getInVogueListAPI() async {
  // 返回请求
  return SpecialOffer.fromJson(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<SpecialOffer> getOneStopListAPI() async {
  // 返回请求
  return SpecialOffer.fromJson(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}
// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, queryParameters: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}