class Contact extends Comparable<Contact> {
  String name;
  String desc;

  @override
  String toString() {
    return 'AddressData{name: $name, desc: $desc}';
  }

  @override
  int compareTo(Contact other) {
    return name.compareTo(other.name);
  }

  Map<String, String> toMap() {
    Map<String, String> res = Map();
    res["name"] = name;
    res["desc"] = desc;
    return res;
  }

  Contact fromMap(Map<String, dynamic> map) {
    name = "${map["name"]}";
    desc = "${map["desc"]}";
    return this;
  }
}
