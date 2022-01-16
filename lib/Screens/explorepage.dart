import 'package:deltahacks/Constants/constants.dart';
import 'package:deltahacks/Models/global_active_orders.dart';
import 'package:deltahacks/Screens/profile_page.dart';
import 'package:deltahacks/Services/getservices.dart';
import 'package:deltahacks/Services/postservices.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'homescreen.dart';
import 'loginpage.dart';
class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  GetServices g1 = GetServices();
  PostServices p1 = PostServices();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: Future.wait([g1.getAllActiveOrders(),g1.getAcceptedOrdersByMe()]),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return Padding(
                padding: EdgeInsets.only(left: 0.03*width,right: 0.04*width,top: 0.04*height),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0.04*width),
                          child: Text("Explore",style: getStarted.copyWith(fontWeight: FontWeight.w600,fontSize: 28,color: Colors.black),),
                        ),
                        SizedBox(height: 0.02*height,),
                        Padding(
                          padding: EdgeInsets.only(left: 0.04*width),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  if(activeState==false)
                                  {
                                    setState(() {
                                      activeState=true;
                                      acceptedState=false;
                                    });
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color:activeState?Color(0xfff37059):Colors.transparent,
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text("Active Orders",style: getStarted.copyWith(color: Colors.black,fontSize: 18),),
                                    )),
                              ),
                              GestureDetector(
                                onTap: (){
                                  if(acceptedState==false)
                                  {
                                    setState(() {
                                      activeState=false;
                                      acceptedState=true;
                                    });
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color:acceptedState?Color(0xff8fdea5):Colors.transparent,
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text("Accepted Orders",style: getStarted.copyWith(color: Colors.black,fontSize: 18)),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        activeState?
                               ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data[0]!.length,
                                    reverse: true,
                                    itemBuilder: (context, index) {
                                      if(snapshot.data[0].isNotEmpty) {
                                        return ListTile(
                                          leading: Container(
                                            width: 0.13 * width,
                                            height: 0.07 * height,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(10.0),
                                                color: Colors.white
                                            ),
                                            child: Center(
                                                child: SvgPicture.asset(
                                                    "assets/Paperbag.svg")
                                            ),
                                          ),
                                          trailing: GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .all(13.0),
                                                          child: SingleChildScrollView(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(snapshot
                                                                    .data![0][index]
                                                                    .name,
                                                                  style: getStarted
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 30,
                                                                      fontWeight: FontWeight
                                                                          .bold),),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                        "Reward: ${snapshot
                                                                            .data![0][index]
                                                                            .reputation
                                                                            .toString()}",
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
                                                                Text("Symptoms",
                                                                    style: getStarted
                                                                        .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 24,
                                                                        fontWeight: FontWeight
                                                                            .w400)),
                                                                Container(
                                                                  width: width *
                                                                      0.8,
                                                                  height: height *
                                                                      0.05,
                                                                  child: ListView
                                                                      .builder(
                                                                    scrollDirection: Axis
                                                                        .horizontal,
                                                                    itemCount: snapshot
                                                                        .data![0][index]
                                                                        .symptoms
                                                                        .length,
                                                                    itemBuilder: (
                                                                        context,
                                                                        idx) {
                                                                      return Row(
                                                                        children: [
                                                                          InputChip(
                                                                            onPressed: () {

                                                                            },
                                                                            backgroundColor: Color(
                                                                                0xfff37059),
                                                                            label: Text(
                                                                              snapshot
                                                                                  .data![0][index]
                                                                                  .symptoms[idx],
                                                                              style: getStarted
                                                                                  .copyWith(
                                                                                  fontSize: 14,
                                                                                  color: Colors
                                                                                      .white),),),
                                                                          SizedBox(
                                                                            width: width *
                                                                                0.02,),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                ListView
                                                                    .builder(
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    scrollDirection: Axis
                                                                        .vertical,
                                                                    shrinkWrap: true,
                                                                    itemCount: snapshot
                                                                        .data[0][index]
                                                                        .items
                                                                        .length,
                                                                    reverse: true,
                                                                    itemBuilder: (
                                                                        context,
                                                                        idx2) {
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
                                                                                        .data[0][index]
                                                                                        .items[idx2]
                                                                                        .item),
                                                                                Text(
                                                                                    "x" +
                                                                                        snapshot
                                                                                            .data[0][index]
                                                                                            .items[idx2]
                                                                                            .qty
                                                                                            .toString()),
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
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      left: width *
                                                                          0.15),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width: width *
                                                                            0.3,
                                                                        decoration: BoxDecoration(
                                                                            color: Color(
                                                                                0xff8fdea5),
                                                                            border: Border
                                                                                .all(
                                                                                color: Color(
                                                                                    0xff8fdea5)),
                                                                            borderRadius: BorderRadius
                                                                                .all(
                                                                                Radius
                                                                                    .circular(
                                                                                    10))
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              15.0),
                                                                          child: GestureDetector(
                                                                            onTap: () async {
                                                                              var x = await p1
                                                                                  .acceptOrder(
                                                                                  snapshot
                                                                                      .data[0][index]
                                                                                      .id.toString());
                                                                              if (x ==
                                                                                  true) {
                                                                                setState(() {
                                                                                  activeState =
                                                                                  false;
                                                                                  acceptedState=true;
                                                                                });
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              }
                                                                              else {
                                                                                Fluttertoast
                                                                                    .showToast(
                                                                                    msg: "Sorry, Couldn't accept the order");
                                                                              }
                                                                            },
                                                                            child: Center(
                                                                                child: Text(
                                                                                  "Accept",
                                                                                  style: getStarted,)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 0.02 *
                                                                            width,
                                                                      ),
                                                                      Container(
                                                                        width: width *
                                                                            0.3,
                                                                        decoration: BoxDecoration(
                                                                            color: Color(
                                                                                0xfff37059),
                                                                            borderRadius: BorderRadius
                                                                                .all(
                                                                                Radius
                                                                                    .circular(
                                                                                    10))
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              15.0),
                                                                          child: GestureDetector(
                                                                            onTap: () {
                                                                              Navigator
                                                                                  .pop(
                                                                                  context);
                                                                            },
                                                                            child: Center(
                                                                                child: Text(
                                                                                  "Go Back",
                                                                                  style: getStarted,)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Icon(
                                                  Icons.navigate_next_sharp,
                                                  color: Color(0xfff37059))),
                                          title: Text(
                                            snapshot.data![0][index].name,
                                            style: getStarted.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Colors.black),),
                                          subtitle: Row(
                                            children: [
                                              Text("Created By:" +
                                                  snapshot.data![0][index].uid,
                                                style: getStarted.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontSize: 8),),
                                            ],
                                          ),
                                        );
                                      }
                                      return const Center(
                                        child: Text("No Active Orders"),
                                      );
                                    }):
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data[1].orders.length,
                            reverse: true,
                            itemBuilder: (context,index){
                              if(snapshot.data[1].orders.length>0)
                                {
                                   return ListTile(
                                    leading: Container(
                                      width: 0.13*width,
                                      height: 0.07*height,
                                      decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.white
                                      ) ,
                                      child: Center(
                                          child: SvgPicture.asset("assets/completed.svg")
                                      ),
                                    ),
                                    trailing:
                                    GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(context: context, builder: (context){
                                            return Container(
                                              child: Padding(
                                                padding: EdgeInsets.all(13.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(snapshot.data![1].orders[index].name,style: getStarted.copyWith(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text("Reward: ${snapshot.data![1].orders[index].reputation.toString()}",style: getStarted.copyWith(color: Colors.black,fontSize: 16,fontWeight:FontWeight.w500)),
                                                          SvgPicture.asset("assets/Coin.svg",height: 40,),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 0.02 * height,
                                                      ),
                                                      Wrap(
                                                        direction: Axis.horizontal,
                                                        alignment: WrapAlignment.spaceBetween,
                                                        children: [
                                                          Text("upi id:"+ snapshot.data![1].orders[index].upayments,
                                                              style: getStarted
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .w500)),
                                                          SizedBox(
                                                            width: width * 0.2,),
                                                          Text(
                                                              "Phone No:${snapshot.data![1].orders[index].uphone}",
                                                              style: getStarted
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .w500)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 0.02 * height,
                                                      ),
                                                      Wrap(
                                                        alignment: WrapAlignment.start,
                                                        children: [

                                                          Text(
                                                              "Address: ${snapshot.data![1].orders[index].uaddress}",
                                                              style: getStarted
                                                                  .copyWith(
                                                                  color: Colors.black,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .w500))],
                                                      ),
                                                      SizedBox(
                                                        height: 0.02 * height,
                                                      ),
                                                      Text("Symptoms",style: getStarted.copyWith(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w400)),
                                                      Container(
                                                        width: width*0.8,
                                                        height: height*0.05,
                                                        child: ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: snapshot.data![1].orders[index].symptoms.length,
                                                          itemBuilder: (context,idx){
                                                            return Row(
                                                              children: [
                                                                InputChip(
                                                                  onPressed: (){

                                                                  },
                                                                  backgroundColor: Color(0xfff37059),
                                                                  label: Text(snapshot.data![1].orders[index].symptoms[idx],style: getStarted.copyWith(fontSize: 14,color: Colors.white),),),
                                                                SizedBox(width: width*0.02,),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      ListView.builder(
                                                          physics: NeverScrollableScrollPhysics(),
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: snapshot.data[1].orders[index].items.length,
                                                          reverse: true,
                                                          itemBuilder: (context,idx2){
                                                            return  Card(
                                                              child: Container(
                                                                width: width,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.rectangle
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(15),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text(snapshot.data[1].orders[index].items[idx2].item),
                                                                      Text("x"+ snapshot.data[1].orders[index].items[idx2].qty.toString()),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                      SizedBox(
                                                        height: 0.02*height,
                                                      ),
                                                      Padding(
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
                                                                  onTap: ()async{
                                                                    Fluttertoast.showToast(msg: "Hang On");
                                                                    await p1.deliverOrder(snapshot.data[1].orders[index].id.toString());
                                                                    Navigator.pop(context);
                                                                    /*Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => HomePage()),
                                                            );*/
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
                                                                    MapsLauncher.launchQuery(
                                                                        '${snapshot.data[1].orders[index].uaddress}');
                                                                  },
                                                                  child: Center(child: Text("Maps",style: getStarted,)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        },
                                        child: Icon(Icons.navigate_next_sharp,color:Color(0xfff37059))),
                                    title: Text(snapshot.data![1].orders[index].name,style: getStarted.copyWith(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),),
                                    subtitle: Row(
                                      children: [
                                        SvgPicture.asset("assets/Coin.svg",height: 40,),
                                        Text(snapshot.data![1].orders[index].reputation.toString(),style: getStarted.copyWith(fontWeight: FontWeight.w400,color: Colors.black),),
                                      ],
                                    ),
                                  );
                                }
                              return const Center(
                                child: Text("No Orders Accepted By You"),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              );
            }
          return const Center(child: CircularProgressIndicator());
        }
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


/*
GestureDetector(
onTap: () {
showModalBottomSheet(
context: context, builder: (context) {
return Container(
child: Padding(
padding: EdgeInsets.all(13.0),
child: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment
    .start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment
    .start,
children: [
Text("Piles Medicines",
style: getStarted
    .copyWith(
color: Colors.black,
fontSize: 30,
fontWeight: FontWeight
    .bold),),
SizedBox(
width: width * 0.05,),
Text("Reward: 30",
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
Row(
mainAxisAlignment: MainAxisAlignment
    .start,
children: [
Text("upi:abc@okicici",
style: getStarted
    .copyWith(
color: Colors
    .black,
fontSize: 16,
fontWeight: FontWeight
    .w500)),
SizedBox(
width: width * 0.2,),
Text(
"Phone No:9898989898",
style: getStarted
    .copyWith(
color: Colors
    .black,
fontSize: 16,
fontWeight: FontWeight
    .w500)),
],
),
SizedBox(
height: 0.02 * height,
),
Text(
"Address: IIITG Boys Hostel,Bongora,Guwahati,Assam",
style: getStarted
    .copyWith(
color: Colors.black,
fontSize: 16,
fontWeight: FontWeight
    .w500)),
SizedBox(
height: 0.02 * height,
),
Text("Status",
style: getStarted
    .copyWith(
color: Colors.black,
fontSize: 24,
fontWeight: FontWeight
    .w400)),
Row(
children: [
InputChip(
onPressed: () {

},
backgroundColor: Color(
0xfff37059),
label: Text('Accepted',
style: getStarted
    .copyWith(
fontSize: 14,
color: Colors
    .white),),),
SizedBox(
width: width * 0.02,),
InputChip(
onPressed: () {

},
backgroundColor: Color(
0xfff37059),
label: Text('Taken',
style: getStarted
    .copyWith(
fontSize: 14,
color: Colors
    .white),),),
SizedBox(
width: width * 0.02,),
InputChip(
onPressed: () {

},
backgroundColor: Color(
0xfff37059),
label: Text('Delivered',
style: getStarted
    .copyWith(
fontSize: 14,
color: Colors
    .white),),),
],
),
SizedBox(
height: 0.02 * height,
),
ListView.builder(
physics: NeverScrollableScrollPhysics(),
scrollDirection: Axis
    .vertical,
shrinkWrap: true,
itemCount: 4,
reverse: true,
itemBuilder: (context,
index) {
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
"Paracetamol"),
Text("x3"),
],
),
),
),
);
}),
SizedBox(
height: 0.02 * height,
),
Padding(
padding: EdgeInsets.only(
left: width * 0.15),
child: Row(
children: [
Container(
width: width * 0.3,
decoration: BoxDecoration(
color: Color(
0xff8fdea5),
border: Border
    .all(
color: Color(
0xff8fdea5)),
borderRadius: BorderRadius
    .all(
Radius
    .circular(
10))
),
child: Padding(
padding: const EdgeInsets
    .all(15.0),
child: GestureDetector(
onTap: () {
*/
/*Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => HomePage()),
                                                                );*//*

},
child: Center(
child: Text(
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
color: Color(
0xfff37059),
borderRadius: BorderRadius
    .all(
Radius
    .circular(
10))
),
child: Padding(
padding: const EdgeInsets
    .all(15.0),
child: GestureDetector(
onTap: () {
Navigator.pop(
context);
},
child: Center(
child: Text(
"Maps",
style: getStarted,)),
),
),
),
],
),
),
],
),
),
),
);
});
},
child: Icon(Icons.navigate_next_sharp,
color: Color(0xfff37059),))*/
