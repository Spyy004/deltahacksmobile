import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_api/http_api.dart' as xyz;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostServices
{
  var dio = Dio();
  var fdata = xyz.FormData();
    Future<dynamic>loginUser(String name, String password)async{
      print(name);
      print(password);
      String url = "https://getmedspy.herokuapp.com/users/";
      Map<String,String>body = {
        'username':name,
        'password':password
      };
      var uri = Uri.parse('https://getmedspy.herokuapp.com/login');
    /*  var request = await dio.post(url,data: body,options: Options(contentType: Headers.formUrlEncodedContentType));
      print(request.data);
      print(request.statusCode);*/
   /*   Map<String, String> requestBody = <String,String>{
        "username":name,
        "password":password
      };*/
      var request = http.MultipartRequest('POST', uri)
       //if u have headers, basic auth, token bearer... Else remove line
       ..fields.addAll(body);
      var response = await request.send();
      final respStr = await http.Response.fromStream(response);
      print(respStr.body);
      var jsonBody = jsonDecode(respStr.body);
      if(respStr.statusCode==200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("name", jsonBody["name"]);
        if(jsonBody["phone"]!=null)
          {
            prefs.setString("phone", jsonBody["phone"]);
          }
       /* if(jsonBody["address"])
          {
            prefs.setString("address", jsonBody["address"][0]);
          }*/
        prefs.setString("password", password);
        prefs.setString("access_token",jsonBody["access_token"]);
          return true;
      }
    return false;
    }
    Future<dynamic>registerUser(String name, String email, String password)async{
      var uri = Uri.parse('https://getmedspy.herokuapp.com/users/');
      Map<String,String> body = {
        "name":name,
        "id":email,
        "password":password,
      };
      var req = await dio.post('https://getmedspy.herokuapp.com/users/',data: body);
    //  print(req.statusCode);
      if(req.statusCode==200)
        {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("name", name);
          prefs.setString("password", password);
          //print(req.data);
          return true;
        }
      return false;
    }
    Future<bool>acceptOrder(String id)async{
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access_token")!;
      var uri = ('https://getmedspy.herokuapp.com/orders/$id/accept');
      var headers = {"Authorization":"Bearer $accessToken"};
      var req = await dio.put(uri,options: Options(headers: headers));
      //  print(req.statusCode);
      if(req.statusCode==200)
      {
        return true;
      }
      return false;
    }
  Future<bool>deliverOrder(String id)async{
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access_token")!;
    var uri = ('https://getmedspy.herokuapp.com/orders/$id/complete');
    var headers = {"Authorization":"Bearer $accessToken"};
    var req = await dio.put(uri,options: Options(headers: headers));
    //  print(req.statusCode);
    if(req.statusCode==200)
    {
      return true;
    }
    return false;
  }
  Future<dynamic> AddAddress(String address,String phone,String upi) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access_token")!;
    var url='https://getmedspy.herokuapp.com/users/';
    Uri uri=Uri.parse(url);
    var data={
      "address":address,
      "phone":phone,
      "payments":upi
    };
    var header={
      "Content-Type":"application/json",
      "Authorization":"Bearer $accessToken"
    };
    var req=await dio.put(url,data: data,options: Options(headers: header));
    print(req.statusCode);
    print(req.data);
  }

  Future<dynamic> CreateOrder(List medication,List symptoms,String name) async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access_token")!;
    print(accessToken);
    var url='https://getmedspy.herokuapp.com/orders/';
    var data={
      "items":medication,
      "symptoms":symptoms,
      "name":name,
      "reputation":3,
    };
    var header={
      "Content-Type":"application/json",
      "Authorization":"Bearer $accessToken",
    };

    var req=await dio.post(url,data: data,options: Options(headers: header));
    print(req.data);
    print(req.statusCode);

  }
}