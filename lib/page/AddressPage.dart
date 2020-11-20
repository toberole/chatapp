import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/base/BaseState.dart';
import 'package:flutter_app/bean/Contact.dart';
import 'package:flutter_app/db/DB.dart';
import 'package:flutter_app/widget/AddressItemWidget.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends BaseState<AddressPage> {
  List<Contact> datas = [];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    DB.getAllContact().then((value) {
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
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 2, left: 5),
      child: ListView.builder(
          itemCount: datas.length,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return AddressItemWidget(datas[index], true);
            } else {
              bool b = false;
              var preData = datas[index - 1];
              var curData = datas[index];
              var preDataCh = preData.name[0];
              var curDataCh = curData.name[0];

              if (curDataCh != preDataCh) {
                b = true;
              } else {
                b = false;
              }
              return AddressItemWidget(datas[index], b);
            }
          }),
    );
  }
}
