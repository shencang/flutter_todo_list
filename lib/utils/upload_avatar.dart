import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// 自定义的上传头像组件。
class UploadAvatar extends StatefulWidget {
  @override
  _UploadAvatarState createState() => _UploadAvatarState();
}

/// 与自定义的上传头像组件关联的状态子类。
class _UploadAvatarState extends State<UploadAvatar> {
  // 文件（`File`）类，对文件系统上的文件的引用。
  /// 从相册选择的图片文件。
  File _image;

  /// 打开系统相册并选择一张照片。
  Future getImage() async {
    // Flutter团队开发的图片选择器（`image_picker`）插件。
    // 适用于iOS和Android的Flutter插件，用于从图像库中拾取图像，并使用相机拍摄新照片。
    // https://pub.dartlang.org/packages/image_picker
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      // 更新用作头像的照片。
      _image = image;
    });
  }

  // TODO: 第3步：实现“默认头像图片”
  /// 自定义的默认头像组件，用来显示默认图片。
  Widget defaultImage = Stack(
    children: <Widget>[
      Align(
        // 默认头像图片放在左上方。
        alignment: Alignment.topLeft,
        child: Image.asset(
          'assets/avatar/man.png',
          fit: BoxFit.contain,
          height: 130.0,
          width: 135.0,
        ),
      ),
      Align(
        // 编辑头像图片放在右下方。
        alignment: Alignment.bottomRight,
          child: Icon(Icons.mode_edit),
//        child: Image.asset(
//          'assets/icon_edit.png',
//          fit: BoxFit.contain,
//          height: 48.0,
//        ),
      ),
    ],
  );

  // TODO: 第4步：实现“圆形头像图片”
  /// 自定义的椭圆形头像组件，用来裁剪显示头像。
  Widget ovalImage(File image) {
    return Stack(
      children: <Widget>[
        Container(
          // 通过容器（`Container`）组件的填充（`padding`）属性，使头像对齐边框。
          padding: EdgeInsets.fromLTRB(9.0, 10.5, 0.0, 0.0),
          // 剪辑椭圆形（`ClipOval`）组件，使用椭圆剪辑其子项的组件。
          child: ClipOval(
            // 图片.文件（`Image.file`）构造函数，创建一个窗口组件，显示从文件获取的图片流。
            child: Image.file(
              image,
              fit: BoxFit.cover,
              height: 109.0,
              width: 109.0,
            ),
          ),
        ),
        // 头像边框图片默认放在左上方。
        Image.asset(
          'assets/icon_head_default_null.png',
          fit: BoxFit.contain,
          height: 130.0,
          width: 135.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // 主轴对齐（`mainAxisAlignment`）属性，如何将子组件放在主轴上。
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: getImage,
          child: Container(
            width: 130.0,
            height: 135.0,
            child: _image == null
            // 第3步实现的自定义组件。
                ? defaultImage
            // 第4步实现的自定义组件。
                : ovalImage(_image),
          ),
        ),
      ],
    );
  }
}