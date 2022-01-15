import 'package:deltahacks/Constants/constants.dart';
import 'package:deltahacks/Services/postservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'loginpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
 PostServices p1 = PostServices();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,

            child: SvgPicture.asset("assets/Register_Page.svg",height: height,width: width,fit: BoxFit.fill,),
          ),
          Positioned(
              top: 0.38*height,
              child:
          Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 0.08*width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Register",style: getStarted.copyWith(fontWeight: FontWeight.w700,fontSize: 36),),
                SizedBox(height: height*0.030,),
                Container(
                  width: width*0.8,
                  // margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: name,
                    // keyboardType: TextInputType.,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16,color: Colors.white),
                      hintText: 'Full Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(height: height*0.025,),
                Container(
                  width: width*0.8,
                  // margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: email,
                    validator: (text){
                      if(text!.isEmpty)
                      {
                        return "Enter something";
                      }
                      if(text.contains("@gmail.com")==false)
                      {
                        return "Should be more than 6 characters";
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    // keyboardType: TextInputType.,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16,color: Colors.white),
                      hintText: 'Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(height: height*0.025,),
                Container(
                  width: width*0.8,
                  // margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: password,
                    cursorColor: Colors.black,
                    validator: (text){
                      if(text!.isEmpty)
                      {
                        return "Enter something";
                      }
                      if(text!.length<6)
                      {
                        return "Should be more than 6 characters";
                      }
                      return null;
                    },
                    // keyboardType: TextInputType.,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16,color: Colors.white),
                      hintText: 'Password',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(height: height*0.03,),
                Padding(
                  padding: EdgeInsets.only(left: width*0.5),
                  child: Container(
                    width: width*0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: ()async
                        {/*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );*/
                            if(_formKey.currentState!.validate())
                              {
                                _formKey.currentState!.save();
                                await p1.registerUser(name.text,email.text,password.text);
                                Fluttertoast.showToast(msg: "Please Login Now");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                              }
                            else
                              {
                                Fluttertoast.showToast(msg: "Sorry, Wrong Credentials!");
                              }
                        },
                        child: Text("Register",style: getStarted,),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height*0.035,),
                Row(
                  children:[
                    Container
                      (width: width*0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset("assets/applelogo.svg"),
                      ),
                    ),
                    SizedBox(width: width*0.03,),
                    Container(
                      width: width*0.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset("assets/fblogo.svg",color: Colors.blueAccent,),
                      ),
                    ),
                    SizedBox(width: width*0.03,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: SvgPicture.asset("assets/googlelogo.svg",fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(width: width*0.12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Already a Member?",style: getStarted.copyWith(fontSize: 16),),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                            child: Text("Login",style: getStarted.copyWith(fontSize: 18,decoration: TextDecoration.underline,fontWeight: FontWeight.w400),)),

                      ],
                    )
                  ]

                )
              ],
            ),
          ),
          ))
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
