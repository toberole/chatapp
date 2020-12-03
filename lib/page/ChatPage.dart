import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_app/base/BaseState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/ChatMessage.dart';
import 'package:flutter_app/bean/Contact.dart';
import 'package:flutter_app/bean/Conversation.dart';
import 'package:flutter_app/common/TLSizeFit.dart';
import 'package:flutter_app/db/DB.dart';

import '../Constant.dart';

class ChatPage extends StatefulWidget {
  Contact contact;

  ChatPage(this.contact);

  @override
  _ChatPageState createState() => _ChatPageState(contact);
}

class _ChatPageState extends BaseState<ChatPage> with WidgetsBindingObserver {
  static const int PAGE_COUNT = 50;

  List<ChatMessage> datas = [];

  ScrollController _controller = ScrollController();

  TextEditingController _textEditingController = TextEditingController();

  Contact contact;

  _ChatPageState(this.contact) {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print(contact);

    DB.getAllMessageBySenderReceiver(USER, contact.name).then((value) {
      if (value != null && value.length > 0) {
        datas.addAll(value);
        setState(() {
          Timer(Duration(milliseconds: 100), () {
            _controller.jumpTo(_controller.position.maxScrollExtent);
          });
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _controller.dispose();
  }

  @override
  void didChangeMetrics() {
    var bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    /**
     * 判断键盘show hide
     */
    var isShow = bottomInset > 0.0;
    print("bottomInset: $bottomInset");
    if (isShow) {
      Timer(Duration(milliseconds: 50), () {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      });
    }
  }

  void sendMsg(String text) async {
    if (text.isNotEmpty) {
      ChatMessage m = ChatMessage();
      m.sender = USER;
      m.receiver = contact.name;
      m.time = "${DateTime.now().millisecondsSinceEpoch}";
      m.msg = text;
      datas.add(m);
      DB.insertMessage(m);
      setState(() {
        Timer(Duration(milliseconds: 100), () {
          _controller.jumpTo(_controller.position.maxScrollExtent);
        });
      });

      Conversation conversation = Conversation();
      conversation.name = contact.name;
      conversation.desc = contact.desc;
      DB.updateConversation(conversation);

      Timer(Duration(milliseconds: 150), () {
        m = ChatMessage();
        m.sender = contact.name;
        m.receiver = USER;
        m.time = "${DateTime.now().millisecondsSinceEpoch}";
        m.msg = text;
        datas.add(m);
        DB.insertMessage(m);
        setState(() {
          Timer(Duration(milliseconds: 50), () {
            _controller.jumpTo(_controller.position.maxScrollExtent);
          });
        });
      });

      // Map<String, String> map = new Map();
      //
      // var url = Uri.parse("");
      // var httpClient = HttpClient();
      // httpClient
      //     .postUrl(url)
      //     .then((HttpClientRequest request) {
      //   request.headers.contentType = ContentType("application", "json");
      //   request.write(json.encode(map));
      //   return request.close();
      // }).then((HttpClientResponse response) {
      //   print("response.statusCode: ${response.statusCode}");
      //   if (response.statusCode == 200) {
      //     response.transform(utf8.decoder).join().then((String string) {
      //       print(string);
      //     });
      //   } else {
      //     print("error");
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "ChatPage",
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text("ChatPage"),
    //     ),
    //     resizeToAvoidBottomInset: true,
    //     body: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         Expanded(
    //             child: ListView.builder(
    //                 shrinkWrap: true,
    //                 controller: _controller,
    //                 itemCount: datas.length,
    //                 keyboardDismissBehavior:
    //                     ScrollViewKeyboardDismissBehavior.onDrag,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   var m = datas[index];
    //                   if (m.sender == "me") {
    //                     return ChatRightItem(m);
    //                   } else {
    //                     return ChatLeftItem(m);
    //                   }
    //
    //                   // return ChatLeftItem(m);
    //                 })),
    //         Container(
    //           width: double.infinity,
    //           height: 50,
    //           padding: EdgeInsets.only(left: 5, right: 5),
    //           child: IntrinsicHeight(
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.max,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Expanded(
    //                     child: TextField(
    //                   controller: _textEditingController,
    //                   textAlign: TextAlign.start,
    //                   maxLines: null,
    //                   keyboardType: TextInputType.multiline,
    //                   decoration: InputDecoration(
    //                       hintText: "今天天气怎么样",
    //                       border: OutlineInputBorder(
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(5))),
    //                       contentPadding:
    //                           EdgeInsets.only(left: 3, top: 0, bottom: 0)),
    //                 )),
    //                 Container(
    //                   margin: EdgeInsets.only(left: 5),
    //                   height: 50,
    //                   child: RaisedButton(
    //                     color: Colors.lightGreen,
    //                     shape: RoundedRectangleBorder(
    //                         side: BorderSide.none,
    //                         borderRadius: BorderRadius.all(Radius.circular(5))),
    //                     onPressed: () {
    //                       print(_textEditingController.text);
    //                       sendMsg(_textEditingController.text);
    //                       _textEditingController.text = "";
    //                     },
    //                     child: Text(
    //                       "Send",
    //                       textAlign: TextAlign.center,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      title: "ChatPage",
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.white,
              height: TLSizeFit.statusHeight,
            ),
            Container(
              color: Colors.white,
              height: 50,
              child: Center(
                child: Text("聊天页面"),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    itemCount: datas.length,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (BuildContext context, int index) {
                      var m = datas[index];
                      if (m.sender == "me") {
                        return ChatRightItem(m);
                      } else {
                        return ChatLeftItem(m);
                      }

                      // return ChatLeftItem(m);
                    })),
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TextField(
                      controller: _textEditingController,
                      textAlign: TextAlign.start,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: "今天天气怎么样",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          contentPadding:
                              EdgeInsets.only(left: 3, top: 0, bottom: 0)),
                    )),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 50,
                      child: RaisedButton(
                        color: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        onPressed: () {
                          print(_textEditingController.text);
                          sendMsg(_textEditingController.text);
                          _textEditingController.text = "";
                        },
                        child: Text(
                          "Send",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatLeftItem extends StatefulWidget {
  ChatMessage message;

  ChatLeftItem(this.message) {}

  @override
  _ChatLeftItemState createState() => _ChatLeftItemState(message);
}

class _ChatLeftItemState extends State<ChatLeftItem> {
  ChatMessage message;

  _ChatLeftItemState(this.message) {}

  @override
  Widget build(BuildContext context) {
    var b1 = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Image.asset("images/p.jpg", width: 50, height: 50),
        ),
        Expanded(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: [
              Text(
                "${message.msg}",
                textAlign: TextAlign.start,
                maxLines: 1000,
              )
            ],
          ),
        ),
      ],
    );
    var b2 = Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.spaceAround,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Image.asset("images/p.jpg", width: 50, height: 50),
        ),
        Text(
          "${message.msg}",
          textAlign: TextAlign.start,
          maxLines: 1000,
        )
      ],
    );

    var b3 = Container(
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.asset("images/p.jpg", width: 50, height: 50),
          ),
          Positioned(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: [
                Text(
                  "${message.msg}",
                  textAlign: TextAlign.start,
                  maxLines: 1000,
                )
              ],
            ),
            left: 50,
            top: 0,
          )
        ],
      ),
    );

    var b4 = Flexible(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.asset("images/p.jpg", width: 50, height: 50),
            ),
            Expanded(
              child: Text(
                "${message.msg}",
                textAlign: TextAlign.start,
                maxLines: 1000,
              ),
            )
          ],
        )
      ],
    ));

    var b5 = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset("images/p.jpg", width: 50, height: 50),
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      "${message.msg}",
                      textAlign: TextAlign.start,
                      maxLines: 1000,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );

    var b6 = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.asset("images/p.jpg", width: 50, height: 50),
          ),
          Expanded(
            child: Text(
              "${message.msg}",
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
    return Container(
      width: double.infinity,
      child: b6,
    );
  }
}

/////////////////////////////////////////////////////////////////////////
class ChatRightItem extends StatefulWidget {
  ChatMessage message;

  ChatRightItem(this.message) {}

  @override
  _ChatRightItemState createState() => _ChatRightItemState(message);
}

class _ChatRightItemState extends State<ChatRightItem> {
  ChatMessage message;

  _ChatRightItemState(this.message) {}

  @override
  Widget build(BuildContext context) {
    var b1 = Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          children: [
            Text(
              "${message.msg}",
              textAlign: TextAlign.start,
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Image.asset("images/p.jpg", width: 50, height: 50),
        ),
      ],
    );

    var b2 = IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              "${message.msg}",
              textAlign: TextAlign.end,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.asset("images/p.jpg", width: 50, height: 50),
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      child: b2,
    );
  }
}
