import 'package:flutter/material.dart';
import 'package:flutter_app/bean/Contact.dart';
import 'package:flutter_app/page/ChatPage.dart';

class AddressItemWidget extends StatelessWidget {
  Contact data;
  bool isShowTitle = true;

  AddressItemWidget(Contact data, bool isShowTitle) {
    this.data = data;
    this.isShowTitle = isShowTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ChatPage(data);
          }));
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              color: Colors.grey,
              height: isShowTitle ? 30 : 0,
              child: Text(
                "${data.name[0]}",
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Image.asset(
                        "images/p.jpg",
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("${data.name}"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
