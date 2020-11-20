import 'package:flutter/material.dart';
import 'package:flutter_app/base/BaseState.dart';

import 'ConversationPage.dart';
import 'AddressPage.dart';
import 'MePage.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends BaseState<LaunchPage> {
  var tab_text_color = Colors.black;
  var tab_text_color_selected = Colors.green;
  var cur_apge = 0;

  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      print("pageController VoidCallback");
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ZeroPage",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Container(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Text("WeChat"),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(Icons.ac_unit),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(Icons.timer),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: PageView(
                children: [ConversationPage(), AddressPage(), MePage()],
                controller: pageController,
                onPageChanged: (index) {
                  print("index: $index");
                  setState(() {
                    cur_apge = index;
                  });
                },
              )),
              Container(
                height: 50,
                color: Colors.white70,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (cur_apge != 0) {
                            pageController.jumpToPage(0);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "消息",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: cur_apge == 0
                                    ? tab_text_color_selected
                                    : tab_text_color),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (cur_apge != 1) {
                            pageController.jumpToPage(1);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "通讯录",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: cur_apge == 1
                                    ? tab_text_color_selected
                                    : tab_text_color),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (cur_apge != 2) {
                              // pageController.animateToPage(
                              //     2, duration: Duration(milliseconds: 300),
                              //     curve: Curves.easeIn);
                              pageController.jumpToPage(2);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("我",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: cur_apge == 2
                                        ? tab_text_color_selected
                                        : tab_text_color)),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
