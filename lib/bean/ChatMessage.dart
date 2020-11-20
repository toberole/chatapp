class ChatMessage {
  String sender;
  String receiver;
  String msg;
  String time;

  Map<String, String> toMap() {
    Map<String, String> map = Map();
    map["sender"] = sender;
    map["receiver"] = receiver;
    map["msg"] = msg;
    map["time"] = time;
    return map;
  }

  ChatMessage fromMap(Map<String, dynamic> map) {
    sender = "${map["sender"]}";
    receiver = "${map["receiver"]}";
    msg = "${map["msg"]}";
    time = "${map["time"]}";
    return this;
  }

  @override
  String toString() {
    return 'ChatMessage{sender: $sender, receiver: $receiver, msg: $msg, time: $time}';
  }
}
