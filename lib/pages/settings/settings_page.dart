import 'package:flutter/material.dart';
import 'package:flutter_todo_list/utils/app_constant.dart';
import 'package:flutter_todo_list/utils/app_util.dart';

///设置子页面的UI
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("风格",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    ListTile(
                      leading: Icon(Icons.camera, color: Colors.black),
                      title: Text("主题变更"),
                      subtitle: Text("变幻色彩"),
                      //onTap: () => launchURL(GITHUB_URL),
                    ),
                    ListTile(
                      leading: Icon(Icons.airline_seat_legroom_extra,
                          color: Colors.black),
                      title: Text("夜间模式"),
                      subtitle: Text("夜晚浏览尤佳"),
                      //onTap: () => launchURL(GITHUB_URL),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                    child: Text("数据",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: FONT_MEDIUM)),
                  ),
                  ListTile(
                    leading: Icon(Icons.clear, color: Colors.black),
                    title: Text("清除缓存"),
                    subtitle: Text("抹除痕迹"),
                    //onTap: () => launchURL(GITHUB_URL),
                  ),
                ]),
              ),
              Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                    child: Text("其他",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: FONT_MEDIUM)),
                  ),
                  ListTile(
                    leading: Icon(Icons.web, color: Colors.black),
                    title: Text("官方网站"),
                    subtitle: Text("404 not found"),
                    //onTap: () => launchURL(GITHUB_URL),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.fiber_manual_record, color: Colors.black),
                    title: Text("大号占位符"),
                    subtitle: Text("思考接下来怎么做"),
                    //onTap: () => launchURL(GITHUB_URL),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
