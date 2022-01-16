import 'package:deltahacks/Constants/constants.dart';
import 'package:deltahacks/Screens/homescreen.dart';
import 'package:deltahacks/Screens/signuppage.dart';
import 'package:deltahacks/Services/postservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  PostServices p1 = PostServices();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
      body:Stack(
        children: [
          Container(
            height: height,
            width: width,

            child: SvgPicture.asset("assets/Login_Page.svg",height: height,width: width,fit: BoxFit.fill,),
          ),
          Positioned(
              top: 0.48*height,
              child:
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 0.08*width),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Login",style: getStarted.copyWith(fontWeight: FontWeight.w700,fontSize: 36),),
                      SizedBox(height: height*0.030,),
                      Container(
                        width: width*0.8,
                        // margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: email,
                          cursorColor: Colors.black,
                          // keyboardType: TextInputType.,
                          decoration: const InputDecoration(
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
                          style: const TextStyle(color: Colors.white),
                          controller: password,
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
                          cursorColor: Colors.black,
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
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: ()async{
                                if(_formKey.currentState!.validate())
                                  {
                                    _formKey.currentState!.save();
                                   var x = await p1.loginUser(email.text, password.text);
                                   if(x==false)
                                     {
                                       Fluttertoast.showToast(msg: "Sorry, Wrong Credentials!");
                                     }
                                   else
                                     {
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(builder: (context) => HomePage()),
                                       );
                                     }
                                  }
                                },
                              child: Center(child: Text("Login",style: getStarted,)),
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
                                Text("New Here?",style: getStarted.copyWith(fontSize: 16),),
                                GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                                      );
                                    },
                                    child: Text("Register",style: getStarted.copyWith(fontSize: 18,decoration: TextDecoration.underline,fontWeight: FontWeight.w400),)),
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
