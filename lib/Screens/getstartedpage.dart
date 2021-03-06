import 'package:deltahacks/Constants/constants.dart';
import 'package:deltahacks/Screens/loginpage.dart';
import 'package:deltahacks/Screens/signuppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: SvgPicture.asset("assets/Home_Page_1.svg",height: height,width: width,fit: BoxFit.fill,),
          ),
          Positioned(
              top: height*0.85,
              left: width*0.6,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );},
            child: Text("Get Started",style: getStarted,),
          ),
                ),
              )),
          Positioned(
              top: height*0.4,
              left: width*0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/pill.svg",fit: BoxFit.cover,),
                  Text("GetMeds",style: getStarted.copyWith(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  Text("Meds delivered by Buds",style: getStarted.copyWith(color: Colors.black,fontSize: 18),textAlign: TextAlign.start,)
                ],
              ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}