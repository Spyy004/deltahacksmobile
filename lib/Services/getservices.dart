import 'dart:convert';

import 'package:deltahacks/Models/accepted_orders_by_me_model.dart';
import 'package:deltahacks/Models/all_my_orders_model.dart';
import 'package:deltahacks/Models/global_active_orders.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class GetServices{
  var dio = Dio();
   Future<AllMyOrders>getMyAllOrders()async{
     final prefs = await SharedPreferences.getInstance();
     String accessToken = prefs.getString("access_token")!;
     var uri = Uri.parse('https://getmedspy.herokuapp.com/users/orders/all');
     var headers = {"Authorization":"Bearer $accessToken"};
     var request = await http.get(uri,headers:headers);
    var jsonData = jsonDecode(request.body);
     return AllMyOrders.fromJson(jsonData);
   }
   Future<List<GlobalOrders>>getAllActiveOrders()async{
     final prefs = await SharedPreferences.getInstance();
     String accessToken = prefs.getString("access_token")!;
     var uri = Uri.parse('https://getmedspy.herokuapp.com/orders/');
     var headers = {"Authorization":"Bearer $accessToken"};
     var request = await http.get(uri,headers:headers);
     var jsonData = jsonDecode(request.body);
     print(request.body);
     var x =  (jsonData as List)
         .map((jsonData) => GlobalOrders.fromJson(jsonData))
         .toList();
     print("THIS IS $x");
     return x;
   }
   Future<AllMyAcceptedOrders>getAcceptedOrdersByMe()async
   {
     final prefs = await SharedPreferences.getInstance();
     String accessToken = prefs.getString("access_token")!;
     var uri = Uri.parse('https://getmedspy.herokuapp.com/users/orders/accepted');
     var headers = {"Authorization":"Bearer $accessToken"};
     var request = await http.get(uri,headers:headers);
     var jsonData = jsonDecode(request.body);
     print(request.body);
     return AllMyAcceptedOrders.fromJson(jsonData);
   }
  getSingleOrderInfo(String id)async
  {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access_token")!;
    var uri = ('https://getmedspy.herokuapp.com/users/orders/$id');
    var headers = {"Authorization":"Bearer $accessToken"};
    var request = await dio.get(uri,options: Options(headers: headers));
    print(request.data);
  }
}