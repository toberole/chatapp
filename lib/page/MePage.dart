import 'package:flutter/material.dart';
import 'package:flutter_app/Constant.dart';
import 'package:flutter_app/base/BaseState.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends BaseState<MePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.asset(
                      "images/p.jpg",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(USER),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              Positioned(child: Text(USER)),
                              Positioned(
                                child: Icon(Icons.ac_unit,size: 10,),
                                right: 10,
                              )
                            ],
                          ))
                        ],
                      )
                    ],
                  ))
                ],
              ),
            )
          ],
        ));
  }
}
