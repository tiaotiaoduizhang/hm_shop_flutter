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

// 定义特惠推荐相关的类型和工厂转换函数
class SpecialOffer {
  String id;
  String title;
  List<SubType> subTypes;

  SpecialOffer({required this.id, required this.title, required this.subTypes});

  factory SpecialOffer.fromJson(Map<String, dynamic> json) {
    final subTypesJson = json['subTypes'];
    final subTypes = subTypesJson is List
        ? subTypesJson
              .map((item) => SubType.fromJson(item as Map<String, dynamic>))
              .toList()
        : <SubType>[];
    return SpecialOffer(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      subTypes: subTypes,
    );
  }
}

// 创建子类型和工厂转换函数
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    final goodsItemsJson = json['goodsItems'];
    final goodsItems = goodsItemsJson is Map<String, dynamic>
        ? GoodsItems.fromJson(goodsItemsJson)
        : GoodsItems(
            counts: 0,
            pageSize: 0,
            pages: 0,
            page: 0,
            items: <Item>[],
          );
    return SubType(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      goodsItems: goodsItems,
    );
  }
}

// 创建商品项和工厂转换函数
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<Item> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'];
    final items = itemsJson is List
        ? itemsJson
              .map((item) => Item.fromJson(item as Map<String, dynamic>))
              .toList()
        : <Item>[];
    return GoodsItems(
      counts: (json['counts'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
      pages: (json['pages'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 0,
      items: items,
    );
  }
}

// 创建商品项和工厂转换函数
class Item {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  Item({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      desc: json['desc'],
      price: json['price'] ?? "",
      picture: json['picture'] ?? "",
      orderNum: json['orderNum'] ?? 0,
    );
  }
}

class GoodDetailItem extends Item {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}
//猜你喜欢商品列表项  把“猜你喜欢”接口（getGuessListApi）返回的分页数据解析成强类型对象 ，其中列表里的每一项就是 GoodDetailItem 。
/**
 * class GoodsDetailsItems 表示一个分页结果容器,通常接口返回会包含
 * counts 总商品数
 * pageSize 每页商品数
 * pages 总页数
 * page 当前页码
 * items 当前页的数据列表（这里是 List<GoodDetailItem> ）
 * 构造函数 GoodsDetailsItems({ required ... })用来创建实例时必须把这些字段都传进来
 */


class GoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;

  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
 //工厂构造：专门用来把接口返回的 JSON（Map）转成 GoodsDetailsItems 对象
  factory GoodsDetailsItems.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items']; //判断是不是list
    final items = itemsJson is List
        ? itemsJson
              .map(
                (item) => GoodDetailItem.formJSON(item as Map<String, dynamic>),
              )
              .toList()
        : <GoodDetailItem>[];
    return GoodsDetailsItems(
      counts: (json['counts'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
      pages: (json['pages'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 0,
      items: items,
    );
  }
}
