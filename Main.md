# 主页底部 Tab 栏实现

对应提交：`chore: 主页底部tab实现`

## 目标

在 `MainPage` 里实现底部 4 个 Tab：`首页 / 分类 / 购物车 / 我的`，点击切换内容区域，并支持选中/未选中两套图标。

## 目录与文件

- 页面容器
  - `lib/pages/Main/index.dart`
- 四个 Tab 页面（当前为占位实现）
  - `lib/pages/Home/index.dart`
  - `lib/pages/Category/index.dart`
  - `lib/pages/Cart/index.dart`
  - `lib/pages/My/index.dart`
- Tab 图标资源
  - `lib/assets/tabbar/*.png`

## 资源清单

当前 Tabbar 图标文件：

- `lib/assets/tabbar/home-active.png`
- `lib/assets/tabbar/home-inactive.png`
- `lib/assets/tabbar/notary-active.png`
- `lib/assets/tabbar/notary-inactive.png`
- `lib/assets/tabbar/review-active.png`
- `lib/assets/tabbar/review-inactive.png`
- `lib/assets/tabbar/my-active.png`
- `lib/assets/tabbar/my-inactive.png`

## pubspec.yaml 配置

需要在 `pubspec.yaml` 注册资源目录，否则 Web 端会出现 404 或 “Unable to load asset”：

```yaml
flutter:
  assets:
    - lib/assets/tabbar/
```

注意：资源路径写项目相对路径即可，`Image.asset` 里不要写 `assets/` 前缀。

## 实现要点

### 1) Tab 数据结构（ico / active_ico / text）

在 `MainPage` 里用 `_tabsList` 描述每个 Tab 的静态信息：

- `ico`：未选中图标（图片路径）
- `active_ico`：选中图标（图片路径）
- `text`：Tab 文案

### 2) BottomNavigationBarItem 渲染

通过 `_getTabItems()` 把 `_tabsList` 映射为 `BottomNavigationBarItem`：

- `icon: Image.asset(ico)`
- `activeIcon: Image.asset(active_ico)`
- `label: text`

### 3) 内容区切换（SafeArea + IndexedStack）

内容区用：

- `SafeArea`：避开系统安全区（刘海/状态栏等）
- `IndexedStack(index: _currentIndex, children: [...])`：按索引展示某个子页面，并保留其他页面状态（不销毁）

### 4) 状态管理

- `_currentIndex` 作为当前选中 Tab 的索引
- `BottomNavigationBar.onTap` 更新 `_currentIndex` 并触发 `setState`

要求：`_getChildren()` 的页面顺序必须与 `_tabsList` 顺序一致，否则会出现“点 Tab 显示错页面”的问题。

## 常见问题排查

### 1) Web 端资源 404 / Unable to load asset

现象：

- `Flutter Web engine failed to fetch "...". HTTP status 404`
- `Unable to load asset: "lib/assets/tabbar/xxx.png"`

排查点：

- `pubspec.yaml` 的 `flutter.assets` 是否包含 `lib/assets/tabbar/`
- 图片文件名是否拼写一致（含 `-active/-inactive`）
- 修改 `pubspec.yaml` 后是否重新执行过 `flutter pub get` 并重启运行进程

### 2) BottomNavigationBar currentIndex 断言失败

现象：

- `0 <= currentIndex && currentIndex < items.length is not true`

原因通常是：

- `items` 为空或长度与 `_currentIndex` 不匹配
- `_currentIndex` 被设置成了越界值

处理原则：

- 保证 `items.length > 0`
- 保证 `_currentIndex` 永远在 `[0, items.length - 1]` 范围内

# 首页基本布局

目标：在“首页”Tab 内实现一个可滚动的模块化首页，整体采用 `CustomScrollView` 组合多个区块，便于后续按模块增删与复用。

## 页面结构（推荐）

页面容器：`HomeView`（建议只负责拼装，不承载重业务逻辑）

整体滚动容器：

- `CustomScrollView`
  - `HmSlider`（轮播图）
  - `HmCategory`（分类入口）
  - `HmSuggestion`（推荐）
  - `HmHot`（爆款）
  - `HmMoreList`（无限滚动）
    插件市场:https://pub.dev/packages?q= #轮播图插件安装：
    flutter pub add carousel_slider
    实现轮播图数据对象类型-viewmodels/home.dart

获取轮播图数据: 1.安装dio 2.定义常量数据,基本地址,超时时间,业务状态,请求地址3.封装网络请求工具,基础地址,拦截器4.请求工具进一步解构,处理http状态和业务状态5.类工厂转化动态类型到对象类型6.封装请求api调用工厂函数7.初始化数据更新状态

flutter pub add dio

分类数据获取并渲染(Ai)
分类地址(get),/home/category/head
特惠推荐地址:/hot/preference

推荐列表 （集成）
说明1.集成素材获取第一页数据
2.limit：数量为查询商品数量
步骤1.请求地址常量
2.API请求3.初始化获取数量4.传递数据到子组件5.实现渲染视图

上拉加载：1.使用原有接口实现2.监听滚动到底事件3.同时只能加载一个请求4.如果没有下一页不能再发起请求

下拉刷新：1.使用RefreshIndicator组件包裹子组件，向下拉触发onRefresh函数2.数据重置，重新获取3.获取完毕提示消息（封装）4.初始化是调用下拉刷新动作

不同处：
print('page=$_page hasMore=$\_hasMore isLoading=$\_isLoading');打印只能打印一个
final GlobalKey<RefreshIndicatorState> \_key=GlobalKey<RefreshIndicatorState>();和 Vue3 的 ref 绑定很像


我的页面（集成+搭建）
要素及功能
1.准备图片资源，使用集成素材快速搭建
2.实现猜你喜欢滚动吸顶功能
3，实现猜你喜欢上拉加载功能
4.复用原来的HmMoreList组件


登录页面(集成+表单校验)
要素及功能
1.使用提供的登录页面结构
2.我的页面到登录页
3.实现账号/密码/勾选的校验并提示
4.实现按钮的校验控制
5.优化轻提示工具
知识点:
1.Form组件 =>TextFormField可实现表单校验
2.使用GlobalKey创建key绑定Form组件可调用valiate方法
3.TextFormField的validate返回校验文本
4.正则表达式使用RegExp()进行校验


登录实现：
1.登录接口地址
2.定义登录接口返回类型
3.请求工具实现post方法
4.封装登录api
5.登录并捕获登录异常提示