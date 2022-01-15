// To parse this JSON data, do
//
//     final singleOrderInfo = singleOrderInfoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SingleOrderInfo singleOrderInfoFromJson(String str) => SingleOrderInfo.fromJson(json.decode(str));

String singleOrderInfoToJson(SingleOrderInfo data) => json.encode(data.toJson());

class SingleOrderInfo {
  SingleOrderInfo({
    required this.id,
    required this.name,
    required this.uid,
    required this.items,
    required this.status,
    required this.dUid,
    required this.reputation,
    required this.symptoms,
    required this.upayments,
    required this.uphone,
    required this.uaddress,
  });

  int id;
  String name;
  String uid;
  List<Item> items;
  String status;
  String dUid;
  int reputation;
  List<String> symptoms;
  String upayments;
  String uphone;
  String uaddress;

  factory SingleOrderInfo.fromJson(Map<String, dynamic> json) => SingleOrderInfo(
    id: json["id"],
    name: json["name"],
    uid: json["uid"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    status: json["status"],
    dUid: json["d_uid"],
    reputation: json["reputation"],
    symptoms: List<String>.from(json["symptoms"].map((x) => x)),
    upayments: json["upayments"],
    uphone: json["uphone"],
    uaddress: json["uaddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "uid": uid,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "status": status,
    "d_uid": dUid,
    "reputation": reputation,
    "symptoms": List<dynamic>.from(symptoms.map((x) => x)),
    "upayments": upayments,
    "uphone": uphone,
    "uaddress": uaddress,
  };
}

class Item {
  Item({
    required this.item,
    required this.qty,
  });

  String item;
  dynamic qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    item: json["item"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "item": item,
    "qty": qty,
  };
}
