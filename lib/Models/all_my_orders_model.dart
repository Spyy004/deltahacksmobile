// To parse this JSON data, do
//
//     final allMyOrders = allMyOrdersFromJson(jsonString);

import 'dart:convert';

AllMyOrders globalOrdersFromJson(String str) => AllMyOrders.fromJson(json.decode(str));

String globalOrdersToJson(AllMyOrders data) => json.encode(data.toJson());

class AllMyOrders {
  AllMyOrders({
    required this.orders,
  });

  List<Order> orders;

  factory AllMyOrders.fromJson(Map<String, dynamic> json) => AllMyOrders(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  Order({
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
  List<Items> items;
  String status;
  String dUid;
  int reputation;
  List<String> symptoms;
  String upayments;
  String uphone;
  String uaddress;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    name: json["name"],
    uid: json["uid"],
    items: List<Items>.from(json["items"].map((x) => Items.fromJson(x))),
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

class Items {
  Items({
    required this.item,
    required this.qty,
  });

  String item;
  dynamic qty;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    item: json["item"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "item": item,
    "qty": qty,
  };
}



