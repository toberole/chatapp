class Conversation {
  String name;
  String desc;
  String time = "11:30";

  @override
  String toString() {
    return 'ConversationItemData{name: $name, desc: $desc, time: $time}';
  }

  Map<String, String> toMap() {
    Map<String, String> map = Map();
    map["name"] = name;
    map["desc"] = desc;
    map["time"] = time;
    return map;
  }

  Conversation fromMap(Map<String, dynamic> map) {
    name = "${map["name"]}";
    desc = "${map["desc"]}";
    time = "${map["time"]}";
    return this;
  }
}
