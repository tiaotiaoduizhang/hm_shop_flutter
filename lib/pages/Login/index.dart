import 'package:flutter/material.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController是flutter中的文本控制器
  final TextEditingController _phoneController =
      TextEditingController(); // 账号控制器
  final TextEditingController _codeController =
      TextEditingController(); // 密码控制器
  // 头部标题
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  /**
   * 用户账号Widget 
   * TextFormField 表单输入控件（比 TextField 多了表单校验/配合 Form 使用的能力）。
   * decoration: InputDecoration(...)控制输入框的视觉样式（占位文字、背景色、边框、内边距等）。
   * controller把这个输入框(TextField/TextFormField)和你在 State 里创建的 _phoneController 绑定起来 。
   * RegExp 是 Dart 语言自带的正则表达式用法
   */
  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "请输入账号";
        }
        // 检验手机号格式
        RegExp reg = RegExp(r'^1[3456789]\d{9}$');
        if (!reg.hasMatch(value)) {
          return "请输入正确的手机号";
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号", //占位提示文案
        fillColor: const Color.fromRGBO(
          243,
          243,
          243,
          1,
        ), //背景设置为浅灰色（243,243,243
        filled: true, //开启填充背景
        border: OutlineInputBorder(
          borderSide: BorderSide.none, //不画边框线（仅保留形状）
          borderRadius: BorderRadius.circular(25), //圆角 25
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "密码不能为空";
        }
        return null;
      },
      controller: _codeController,
      obscureText: true, //密码输入框（密码不显示）
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码", //占位提示文案
        fillColor: const Color.fromRGBO(
          243,
          243,
          243,
          1,
        ), //背景设置为浅灰色（243,243,243
        filled: true, //开启填充背景
        border: OutlineInputBorder(
          borderSide: BorderSide.none, //不画边框线（仅保留形状）
          borderRadius: BorderRadius.circular(25), //圆角 25
        ),
      ),
    );
  }

  /**
 * 勾选Widget 勾选同意协议 + 富文本协议链接
 * return Row(children: [ Checkbox(...), Text.rich(...) ]); 水平布局，把 Checkbox 和右侧文字放一行。
 * Checkbox( value: _isChecked,onChanged: (bool? value) { ... },
 *  value: _isChecked类似于Vue 的 :modelValue="xxx"
 * activeColor  勾选时方块背景色
 * checkColor ：对勾的颜色
 *  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10), // 圆角大小), 改变 Checkbox 的外形为圆角矩形
 * side: BorderSide(...) 设置未选中时的边框颜色和宽度（2.0），让样式更明显。
 * 富文本 ： Text.rich + TextSpan
 
- 
)
 */
  bool _isChecked = false;
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            _isChecked = value ?? false;
            setState(() {});
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /**
   * 登录按钮Widget
   * SizedBox 控制按钮尺寸，用 ElevatedButton 提供 Material 风格按钮，并通过 styleFrom 定制样式。
   * width: double.infinity 表示“尽可能宽”，在父容器允许的情况下撑满横向空间（常用于做全宽按钮）。
   * ElevatedButton(...) Material 的“凸起按钮”（带默认阴影/按压效果）
   * style: ElevatedButton.styleFrom(...) 快速构建按钮样式的方式：
   * currentState GlobalKey（以及 GlobalObjectKey）自带的一个属性 ，用来获取“当前绑定到这个 key 的那个 StatefulWidget 的 State 实例”。
   */
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if(_key.currentState!.validate()){
              // 进行勾选框的判断
              if(_isChecked){
                // 校验通过
              }else{
                // 校验不通过 
                ToastUtils.showToast(context, "请先勾选同意协议");
              }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 20),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
