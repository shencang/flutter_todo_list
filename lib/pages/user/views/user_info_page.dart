import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/myHttp/api.dart';
import 'package:flutter_todo_list/myHttp/model_state_info.dart';
import 'package:flutter_todo_list/pages/login/login_page.dart';

import 'package:flutter_todo_list/pages/user/views/modify_email_page.dart';

import 'modfify_signature_page.dart';
import 'modifty_name_page.dart';
import 'modify_avatar.dart';
import 'modify_phone_page.dart';
import 'modify_sex_page.dart';

///用户界面
class InfoScreen extends StatefulWidget {
  @override
  _InfoScreen createState() => new _InfoScreen();
}

class _InfoScreen extends State<InfoScreen> {
   bool isModAvatar =true;
  //static user userShow = GetInfo.userShow;
  Image  userHeadBlur = new Image.network(
    Api.BaseUrl_com + GetInfo.userShow.userAvatar,
    width: MediaQueryData.fromWindow(window).size.width,
    height: 300,
    fit: BoxFit.fitWidth,
  );
  Image userHead = new Image.network(
    Api.BaseUrl_com + GetInfo.userShow.userAvatar,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(GetInfo.userShow.username),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        userHeadBlur,
                        BackdropFilter(
                          filter: new ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: new Container(
                            color: Colors.white.withOpacity(0.1),
                            width: MediaQueryData.fromWindow(window).size.width,
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                 ModifyAvatar(),
//
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.email, color: Colors.black),
                        title: Text(GetInfo.userShow.userEmail),
                        subtitle: Text("电子邮箱"),
                        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                          return new ModifyEmailScreen();
                        })),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.assignment_ind, color: Colors.black),
                        title: Text(GetInfo.userShow.username),
                        subtitle: Text("姓名"),
                        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                          return new ModifyNameScreen();
                        })),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone_android, color: Colors.black),
                        title: Text(GetInfo.userShow.userPhone == null
                            ? "未填写"
                            : GetInfo.userShow.userPhone),
                        subtitle: Text("手机号码"),
                        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                          return new ModifyPhoneScreen();
                        })),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings_input_component,
                            color: Colors.black),
                        title: Text(GetInfo.userShow.userSex == null
                            ? "未填写"
                            : GetInfo.userShow.userSex),
                        subtitle: Text("性别"),
                        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                          return new ModifySexScreen();
                        })),
                      ),
                      ListTile(
                        leading: Icon(Icons.perm_identity, color: Colors.black),
                        title: Text(GetInfo.userShow.userIdentity == null
                            ? "未填写"
                            : GetInfo.userShow.userIdentity),
                        subtitle: Text("用户组"),
                        //onTap: () => launchURL(GITHUB_URL),
                      ),
                      ListTile(
                        leading: Icon(Icons.assignment, color: Colors.black),
                        title: Text(GetInfo.userShow.userSignature == null
                            ? "未填写"
                            : GetInfo.userShow.userSignature),
                        subtitle: Text("签名"),
                        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                          return new ModifySignatureScreen();
                        })),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsetsDirectional.only(top: 10)),
            ],
          ),
        ),
      ),
    );
  }

//  @override
//  void setState(fn) {
//    // TODO: implement setState
//    super.setState(fn);
//    if(GetInfo.needRefresh){
//      //GetInfo.userShow =GetInfo.userShow;
//      userHeadBlur = new Image.network(
//        Api.BaseUrl_com + GetInfo.userShow.userAvatar,
//        width: MediaQueryData.fromWindow(window).size.width,
//        height: 300,
//        fit: BoxFit.fitWidth,
//      );
//      print("info_reflash");
//      GetInfo.needRefresh=false;
//    }
//
//  }


void _loadBannerData() {
  print(GetInfo.needRefresh);
  setState((){
    if(GetInfo.needRefresh){

      GetInfo.userShow =GetInfo.userShow;
      GetInfo.needRefresh=false;
    }else{
      GetInfo.userShow =GetInfo.userShow;
      GetInfo.needRefresh=false;
    }
    userHeadBlur = new Image.network(
      Api.BaseUrl_com + GetInfo.userShow.userAvatar,
      width: MediaQueryData.fromWindow(window).size.width,
      height: 300,
      fit: BoxFit.fitWidth,
    );

  });
}
}