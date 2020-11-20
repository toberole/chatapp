import 'package:flutter_app/bean/ChatMessage.dart';
import 'package:flutter_app/bean/Contact.dart';
import 'package:flutter_app/bean/Conversation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static const String DB_NAME = "my.db";

  static const String TB_MESSAGE = "tb_message";
  static const String TB_CONVERSATION = "tb_conversation";
  static const String TB_CONTACT = "tb_contact";

  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    print("path: $path");

    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      String sql =
          "CREATE TABLE $TB_MESSAGE (msg TEXT,sender TEXT,receiver TEXT,time TEXT)";
      await db.execute(sql);

      sql = "CREATE TABLE $TB_CONVERSATION (name TEXT,desc TEXT,time TEXT)";
      await db.execute(sql);

      sql = "CREATE TABLE $TB_CONTACT (name TEXT,desc TEXT)";
      await db.execute(sql);
    });
  }

  static insertMessage(ChatMessage m) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    var db = await openDatabase(path, version: 1);
    await db.insert(TB_MESSAGE, m.toMap());
  }

  static Future<List<ChatMessage>> getAllMessage() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);

    var db = await openDatabase(path, version: 1);
    var ms = await db.query(TB_MESSAGE,
        columns: ["msg", "sender", "receiver", "time"], orderBy: "time");

    List<ChatMessage> res = [];
    for (int i = 0; i < ms.length; i++) {
      Map<String, dynamic> map = ms[i];
      ChatMessage chatMessage = ChatMessage();
      chatMessage.fromMap(map);
      res.add(chatMessage);
      print(chatMessage);
    }
    return res;
  }

  static Future<List<ChatMessage>> getAllMessageBySenderReceiver(
      String sender, String receiver) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);

    var db = await openDatabase(path, version: 1);
    var ms = await db.query(TB_MESSAGE,
        columns: ["msg", "sender", "receiver", "time"],
        where: "(sender = ? and receiver = ?) or (sender = ? and receiver = ?)",
        whereArgs: [sender, receiver, receiver, sender],
        orderBy: "time");

    List<ChatMessage> res = [];
    for (int i = 0; i < ms.length; i++) {
      Map<String, dynamic> map = ms[i];
      ChatMessage chatMessage = ChatMessage();
      chatMessage.fromMap(map);
      res.add(chatMessage);
      print(chatMessage);
    }
    return res;
  }

  static insertContact(Contact contact) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    var db = await openDatabase(path, version: 1);
    await db.insert(TB_CONTACT, contact.toMap());
  }

  static insertContacts(List<Contact> cs) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    var db = await openDatabase(path, version: 1);
    for (int i = 0; i < cs.length; i++) {
      await db.insert(TB_CONTACT, cs[i].toMap());
    }
  }

  static Future<List<Contact>> getAllContact() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);

    var db = await openDatabase(path, version: 1);
    var ms = await db.query(TB_CONTACT, columns: ["name", "desc"]);
    List<Contact> res = [];
    for (int i = 0; i < ms.length; i++) {
      Map<String, dynamic> map = ms[i];
      Contact contact = Contact();
      contact.fromMap(map);
      res.add(contact);
      print(contact);
    }
    return res;
  }

  static updateConversation(Conversation conversation) async {
    List<Conversation> cs = await getAllConversationByName(conversation.name);
    if (cs.length <= 0) {
      insertConversation(conversation);
    }
  }

  static insertConversation(Conversation conversation) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);
    var db = await openDatabase(path, version: 1);
    await db.insert(TB_CONVERSATION, conversation.toMap());
  }

  static Future<List<Conversation>> getAllConversationByName(
      String name) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);

    var db = await openDatabase(path, version: 1);
    var ms = await db.query(TB_CONVERSATION,
        columns: ["name", "desc", "time"],
        where: "name = ?",
        whereArgs: [name]);
    List<Conversation> res = [];
    for (int i = 0; i < ms.length; i++) {
      Map<String, dynamic> map = ms[i];
      Conversation conversation = Conversation();
      conversation.fromMap(map);
      res.add(conversation);
      print(conversation);
    }
    return res;
  }

  static Future<List<Conversation>> getAllConversation() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);

    var db = await openDatabase(path, version: 1);
    var ms = await db.query(TB_CONVERSATION, columns: ["name", "desc", "time"]);
    List<Conversation> res = [];
    for (int i = 0; i < ms.length; i++) {
      Map<String, dynamic> map = ms[i];
      Conversation conversation = Conversation();
      conversation.fromMap(map);
      res.add(conversation);
      print(conversation);
    }
    return res;
  }
}
