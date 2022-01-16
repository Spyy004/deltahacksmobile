import 'package:deltahacks/Constants/constants.dart';
import 'package:deltahacks/Models/all_my_orders_model.dart';
import 'package:deltahacks/Screens/profile_page.dart';
import 'package:deltahacks/Screens/signuppage.dart';
import 'package:deltahacks/Services/getservices.dart';
import 'package:deltahacks/SharedPrefs/shared_preferences.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_orders.dart';
import 'explorepage.dart';
import 'loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetServices g1 = GetServices();
  Future<void>makeCall(String url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  String name="",accessToken="";
  SharedPrefs myprefs = SharedPrefs();
  void getData()async{
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name")!;
    accessToken = prefs.getString("token")!;
    print(name);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBody: true,
        body: Padding(
          padding: EdgeInsets.only(left: 0.03*width,right: 0.04*width,top: 0.04*height),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.04*width),
                    child: Text("Hello, $name",style: getStarted.copyWith(fontWeight: FontWeight.w600,fontSize: 28,color: Colors.black),),
                  ),
                  SizedBox(height: 0.03*height,),
                  Card(
                    shadowColor:Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text("Time Saved",style: getStarted.copyWith(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 25),),
                                SizedBox(height: 0.01*height,),
                                Text("Great work this week !",style: getStarted.copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),textAlign: TextAlign.start,),
                                SizedBox(height: 0.01*height,),
                                FAProgressBar(
                                  currentValue: 65,
                                  displayText:" mins",
                                  displayTextStyle: getStarted.copyWith(fontSize: 14),
                                  progressColor: const Color(0xfff37059),
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0.03*height,),
                  Padding(
                    padding: EdgeInsets.only(left: 0.04*width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your Orders",style: getStarted.copyWith(fontWeight: FontWeight.w700,fontSize: 24,color: Colors.black)),
                        Padding(
                          padding:  EdgeInsets.only(right: 0.02*width),
                          child: GestureDetector(
                            onTap: ()async{
                              //dynamic l1 = await g1.getMyAllOrders();

                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AddOrders()),
                              );
                            },
                            child: Container(
                              height: 0.05*height,
                              width: width*0.25,
                              margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xfff37059)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add,color: Colors.white,size: 16,),
                                    SizedBox(
                                      width: 0.02*width,
                                    ),
                                    Text("Add",style: getStarted.copyWith(fontSize: 18,fontWeight: FontWeight.w700),),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                FutureBuilder<AllMyOrders>(
                  future: g1.getMyAllOrders(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                      {
                        if(snapshot.data!.orders.isNotEmpty) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.orders.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: snapshot.data!.orders[index].uid ==
                                      "shubhamjain1922@gmail.com" ? Container(
                                    width: 0.13 * width,
                                    height: 0.07 * height,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10.0),
                                        color: Color(0xffffe5e6)
                                    ),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            "assets/Paper_Negative.svg")
                                    ),
                                  ) : Container(
                                    width: 0.13 * width,
                                    height: 0.07 * height,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10.0),
                                        color: Color(0xffd9ffe8)
                                    ),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            "assets/Paper_Plus.svg")
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        if (snapshot.data!.orders[index]
                                            .status != "delivered") {
                                          showModalBottomSheet(context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      13.0),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(snapshot.data!
                                                                .orders[index]
                                                                .name,
                                                              style: getStarted
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 24,
                                                                  fontWeight: FontWeight
                                                                      .bold),),
                                                            SizedBox(
                                                              width: width *
                                                                  0.05,),
                                                            Text(
                                                                "Reward: ${snapshot
                                                                    .data!
                                                                    .orders[index]
                                                                    .reputation}",
                                                                style: getStarted
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight
                                                                        .w500)),
                                                            SvgPicture.asset(
                                                              "assets/Coin.svg",
                                                              height: 40,),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 0.02 * height,
                                                        ),
                                                        snapshot.data!
                                                            .orders[index]
                                                            .status == "active"
                                                            ? Container()
                                                            : Wrap(
                                                          alignment: WrapAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Accepted By: ${snapshot
                                                                    .data!
                                                                    .orders[index]
                                                                    .dUid}",
                                                                style: getStarted
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight
                                                                        .w500)),
                                                            SizedBox(
                                                              width: width *
                                                                  0.15,),
                                                            GestureDetector(
                                                                onTap: () async {
                                                                  String url = 'tel:9324351530';
                                                                  setState(() {
                                                                    makeCall(
                                                                        url);
                                                                  });
                                                                },
                                                                child: Text(
                                                                    "📞:${snapshot
                                                                        .data!
                                                                        .orders[index]
                                                                        .uphone}",
                                                                    style: getStarted
                                                                        .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight
                                                                            .w500))),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 0.02 * height,
                                                        ),
                                                        Wrap(children: [
                                                          Text(
                                                              "Address: ${snapshot
                                                                  .data!
                                                                  .orders[index]
                                                                  .uaddress}",
                                                              style: getStarted
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .w500))
                                                        ]),
                                                        SizedBox(
                                                          height: 0.02 * height,
                                                        ),
                                                        Text("Status",
                                                            style: getStarted
                                                                .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 24,
                                                                fontWeight: FontWeight
                                                                    .w400)),
                                                        InputChip(
                                                          onPressed: () {

                                                          },
                                                          backgroundColor: Color(
                                                              0xfff37059),
                                                          label: Text(snapshot
                                                              .data!
                                                              .orders[index]
                                                              .status,
                                                            style: getStarted
                                                                .copyWith(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),),),
                                                        SizedBox(
                                                          height: 0.02 * height,
                                                        ),
                                                        ListView.builder(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            scrollDirection: Axis
                                                                .vertical,
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data!
                                                                .orders[index]
                                                                .items.length,
                                                            reverse: true,
                                                            itemBuilder: (
                                                                context,
                                                                index1) {
                                                              return Card(
                                                                child: Container(
                                                                  width: width,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .rectangle
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsets
                                                                        .all(
                                                                        15),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                            snapshot
                                                                                .data!
                                                                                .orders[index]
                                                                                .items[index1]
                                                                                .item),
                                                                        Text(
                                                                            "x" +
                                                                                snapshot
                                                                                    .data!
                                                                                    .orders[index]
                                                                                    .items[index1]
                                                                                    .qty
                                                                                    .toString()),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                        SizedBox(
                                                          height: 0.02 * height,
                                                        ),
                                                        /* Padding(
                                          padding: EdgeInsets.only(left: width*0.15),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: width*0.3,
                                                decoration: BoxDecoration(
                                                    color:  Color(0xff8fdea5),
                                                    border: Border.all(color: Color(0xff8fdea5)),
                                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      */ /*Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => HomePage()),
                                                          );*/ /*
                                                    },
                                                    child: Center(child: Text("Delivered",style: getStarted,)),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 0.02*width,
                                              ),
                                              Container(
                                                width: width*0.3,
                                                decoration: BoxDecoration(
                                                    color: Color(0xfff37059),
                                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Center(child: Text("Maps",style: getStarted,)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),*/
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        }
                                        else {
                                          {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          13.0),
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  snapshot.data!
                                                                      .orders[index]
                                                                      .name,
                                                                  style: getStarted
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 30,
                                                                      fontWeight: FontWeight
                                                                          .bold),),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.05,),
                                                                Text(snapshot
                                                                    .data!
                                                                    .orders[index]
                                                                    .uid ==
                                                                    "arnav2@gmail.com"
                                                                    ? "Reward: ${snapshot
                                                                    .data!
                                                                    .orders[index]
                                                                    .reputation}"
                                                                    : "Expense: ${snapshot
                                                                    .data!
                                                                    .orders[index]
                                                                    .reputation}",
                                                                    style: getStarted
                                                                        .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight
                                                                            .w500)),
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/Coin.svg",
                                                                  height: 40,),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 0.02 *
                                                                  height,
                                                            ),
                                                            SizedBox(
                                                              height: 0.02 *
                                                                  height,
                                                            ),
                                                            Text(
                                                                "Address: IIITG Boys Hostel,Bongora,Guwahati,Assam",
                                                                style: getStarted
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight
                                                                        .w500)),
                                                            SizedBox(
                                                              height: 0.02 *
                                                                  height,
                                                            ),
                                                            Text("Status",
                                                                style: getStarted
                                                                    .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight
                                                                        .w400)),
                                                            InputChip(
                                                              onPressed: () {

                                                              },
                                                              backgroundColor: Color(
                                                                  0xfff37059),
                                                              label: Text(
                                                                snapshot.data!
                                                                    .orders[index]
                                                                    .status,
                                                                style: getStarted
                                                                    .copyWith(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .white),),),
                                                            SizedBox(
                                                              height: 0.02 *
                                                                  height,
                                                            ),
                                                            ListView.builder(
                                                                physics: NeverScrollableScrollPhysics(),
                                                                scrollDirection: Axis
                                                                    .vertical,
                                                                shrinkWrap: true,
                                                                itemCount: snapshot
                                                                    .data!
                                                                    .orders[index]
                                                                    .items
                                                                    .length,
                                                                reverse: true,
                                                                itemBuilder: (
                                                                    context,
                                                                    idx) {
                                                                  return Card(
                                                                    child: Container(
                                                                      width: width,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .rectangle
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets
                                                                            .all(
                                                                            15),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                                snapshot
                                                                                    .data!
                                                                                    .orders[index]
                                                                                    .items[idx]
                                                                                    .item),
                                                                            Text(
                                                                                "x" +
                                                                                    snapshot
                                                                                        .data!
                                                                                        .orders[index]
                                                                                        .items[idx]
                                                                                        .item),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                            SizedBox(
                                                              height: 0.02 *
                                                                  height,
                                                            ),
                                                            /*Padding(
                                                 padding: EdgeInsets.only(
                                                     left: width * 0.15),
                                                 child: Row(
                                                   children: [
                                                     Container(
                                                       width: width * 0.3,
                                                       decoration: BoxDecoration(
                                                           color: Color(0xff8fdea5),
                                                           border: Border.all(
                                                               color: Color(
                                                                   0xff8fdea5)),
                                                           borderRadius: BorderRadius
                                                               .all(
                                                               Radius.circular(10))
                                                       ),
                                                       child: Padding(
                                                         padding: const EdgeInsets
                                                             .all(15.0),
                                                         child: GestureDetector(
                                                           onTap: () {
                                                             */ /*Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => HomePage()),
                                                            );*/ /*
                                                           },
                                                           child: Center(child: Text(
                                                             "Delivered",
                                                             style: getStarted,)),
                                                         ),
                                                       ),
                                                     ),
                                                     SizedBox(
                                                       width: 0.02 * width,
                                                     ),
                                                     Container(
                                                       width: width * 0.3,
                                                       decoration: BoxDecoration(
                                                           color: Color(0xfff37059),
                                                           borderRadius: BorderRadius
                                                               .all(
                                                               Radius.circular(10))
                                                       ),
                                                       child: Padding(
                                                         padding: const EdgeInsets
                                                             .all(15.0),
                                                         child: GestureDetector(
                                                           onTap: () {
                                                             Navigator.pop(context);
                                                           },
                                                           child: Center(child: Text(
                                                             "Maps",
                                                             style: getStarted,)),
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),*/
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        }
                                      },
                                      child: Icon(Icons.circle,
                                        color: snapshot.data!.orders[index]
                                            .status != "delivered"
                                            ? Colors.green
                                            : Colors.red, size: 20,)),
                                  title: Text(snapshot.data!.orders[index].name,
                                    style: getStarted.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black),),
                                  subtitle: Text(
                                    snapshot.data!.orders[index].uid ==
                                        "arnav2@gmail.com"
                                        ? "Income"
                                        : "Expense", style: getStarted.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color(0xff263238)),),
                                );
                              });
                        }
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(child: Text("You don't have any orders yet!",style: getStarted.copyWith(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.black),),),
                        );
                      }
                    return Center(child: const CircularProgressIndicator());
                  }
                )
                ],
              ),
            ),
          ),
        ),
      bottomNavigationBar: FloatingNavbar(
        onTap: (int val) {
          if(idx!=val) {
            idx = val;
            if(val==0)
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
            if(val==1)
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
              );
            }
            if(val==2)
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
            if(val==3)
            {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              const LoginPage()), (Route<dynamic> route) => false);
            }
          }
        },
        backgroundColor: Color(0xfff37059),
        currentIndex: idx,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
          FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
          FloatingNavbarItem(icon: Icons.exit_to_app, title: 'Logout'),
        ],
      ),
    );
  }
}
