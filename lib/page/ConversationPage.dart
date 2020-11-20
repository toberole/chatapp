import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/base/BaseState.dart';
import 'package:flutter_app/bean/Conversation.dart';
import 'package:flutter_app/db/DB.dart';
import 'package:flutter_app/widget/ConversationItemWidget.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends BaseState<ConversationPage> {
  List<Conversation> datas = List();
  ScrollController _controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    DB.getAllConversation().then((value) {
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
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
          itemCount: datas.length,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return ConversationItemWidget(datas[index]);
          }),
    );
  }
}
