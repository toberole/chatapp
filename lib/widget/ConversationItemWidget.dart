import 'package:flutter/material.dart';
import 'package:flutter_app/bean/Contact.dart';
import 'package:flutter_app/bean/Conversation.dart';
import 'package:flutter_app/page/ChatPage.dart';

class ConversationItemWidget extends StatefulWidget {
  Conversation data;

  ConversationItemWidget(Conversation data) {
    this.data = data;
  }

  @override
  _ConversationItemWidgetState createState() => _ConversationItemWidgetState(data);
}

class _ConversationItemWidgetState extends State<ConversationItemWidget> {
  Conversation data;

  _ConversationItemWidgetState(Conversation data) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.only(top: 2, bottom: 2),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset(
                  "images/p.jpg",
                  width: 50,
                  height: 50,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Text("${data.name}"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Text("${data.desc}"),
                  )
                ],
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Text(
                    "${data.time}",
                    style: TextStyle(
                        color: Colors.red, backgroundColor: Colors.white),
                  ),
                ),
              ))
            ],
          ),
        ),
        onTap: () {
          print(data);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            Contact contact = Contact();
            contact.name = data.name;
            contact.desc = data.desc;
            return ChatPage(contact);
          }));
        },
      ),
    );
  }
}
