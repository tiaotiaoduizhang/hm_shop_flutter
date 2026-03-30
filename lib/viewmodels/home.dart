/**
 * Dart 数据模型写法
 * 1. 定义一个类
 * 2. 类中定义属性
 * 3. 类中定义构造函数
 * 4. 类中定义方法
 * 
 */

class BannerItem {
  String? id;
  String? imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例
  //类工厂转化类型 从json中解析数据
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    // 必须返回一个BannerItem对象
    // 命名参数 + required 的写法
    // { ... } ：表示这是“命名参数”（named parameters），创建对象时必须写参数名，不按位置传参
    // required ：表示这个命名参数在调用时“必须传”，否则编译/运行前就会报错
    return BannerItem(id: json['id'] ?? '', imgUrl: json['imgUrl'] ?? '');
  }
}

//flutter必须强制转换 没有隐私转换，因为dart是强语言泛类型”数据（例如接口返回的 Map ）Map<String, dynamic>需要自己解析
// 根据上面写一个  分类数据对象类型包含id,name,picture,还有一个list.children属性扩展一个工厂函数
/// 分类数据项
class CategoryItem {
  /// 分类ID
  String? id;
  /// 分类名称
  String? name;
  /// 分类图片地址
  String? picture;
  /// 子分类列表
  List<CategoryItem>? children;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    required this.children,
  });
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例
  //类工厂转化类型 从json中解析数据
  /// 从 Map 转为 CategoryItem
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    // 必须返回一个CategoryItem对象
    // 命名参数 + required 的写法
    // { ... } ：表示这是“命名参数”（named parameters），创建对象时必须写参数名，不按位置传参
    // required ：表示这个命名参数在调用时“必须传”，否则编译/运行前就会报错
    final childrenJson = json['children'];
    final children = childrenJson is List
        ? childrenJson
              .map(
                (item) => CategoryItem.fromJson(item as Map<String, dynamic>),
              )
              .toList()
        : <CategoryItem>[];
    return CategoryItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
      children: children,
    );
  }
}

/// 特惠推荐根对象
class SpecialOfferRecommendation {
  /// 根对象ID
  String? id;
  /// 模块标题
  String? title;
  /// 子类型列表
  List<SpecialOfferSubType>? subTypes;

  SpecialOfferRecommendation({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  /// 从 Map 转为 SpecialOfferRecommendation
  factory SpecialOfferRecommendation.fromJson(Map<String, dynamic> json) {
    final subTypesJson = json['subTypes'];
    final subTypes = subTypesJson is List
        ? subTypesJson
              .map(
                (item) =>
                    SpecialOfferSubType.fromJson(item as Map<String, dynamic>),
              )
              .toList()
        : <SpecialOfferSubType>[];

    return SpecialOfferRecommendation(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subTypes: subTypes,
    );
  }
}

/// 特惠推荐子类型
class SpecialOfferSubType {
  /// 子类型ID
  String? id;
  /// 子类型标题
  String? title;
  /// 子类型商品容器（含分页与商品列表）
  SpecialOfferGoodsItems? goodsItems;

  SpecialOfferSubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  /// 从 Map 转为 SpecialOfferSubType
  factory SpecialOfferSubType.fromJson(Map<String, dynamic> json) {
    final goodsItemsJson = json['goodsItems'];
    final goodsItems = goodsItemsJson is Map<String, dynamic>
        ? SpecialOfferGoodsItems.fromJson(goodsItemsJson)
        : null;

    return SpecialOfferSubType(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      goodsItems: goodsItems,
    );
  }
}

/// 子类型下的商品分页数据
class SpecialOfferGoodsItems {
  /// 总条数
  int? counts;
  /// 每页数量
  int? pageSize;
  /// 总页数
  int? pages;
  /// 当前页码
  int? page;
  /// 商品条目列表
  List<SpecialOfferGoodsItem>? items;

  SpecialOfferGoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  /// 从 Map 转为 SpecialOfferGoodsItems
  factory SpecialOfferGoodsItems.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'];
    final items = itemsJson is List
        ? itemsJson
              .map(
                (item) =>
                    SpecialOfferGoodsItem.fromJson(item as Map<String, dynamic>),
              )
              .toList()
        : <SpecialOfferGoodsItem>[];

    return SpecialOfferGoodsItems(
      counts: (json['counts'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
      pages: (json['pages'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 0,
      items: items,
    );
  }
}

/// 商品条目
class SpecialOfferGoodsItem {
  /// 商品ID
  String? id;
  /// 商品名称
  String? name;
  /// 商品描述（可能为空）
  String? desc;
  /// 价格（字符串形式）
  String? price;
  /// 商品图片地址
  String? picture;
  /// 订单数量/热度
  int? orderNum;

  SpecialOfferGoodsItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  /// 从 Map 转为 SpecialOfferGoodsItem
  factory SpecialOfferGoodsItem.fromJson(Map<String, dynamic> json) {
    return SpecialOfferGoodsItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'],
      price: json['price'] ?? '',
      picture: json['picture'] ?? '',
      orderNum: (json['orderNum'] as num?)?.toInt() ?? 0,
    );
  }
}
