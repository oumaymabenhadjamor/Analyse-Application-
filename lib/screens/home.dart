
import 'dart:core';

import 'package:adobe_xd/pinned.dart';
import 'package:analyse_app/providers/class.dart';
import 'package:analyse_app/providers/student.dart';
import 'package:analyse_app/providers/test.dart';
import 'package:analyse_app/screens/helloScreen.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:analyse_app/providers/user.dart';
import 'package:analyse_app/screens/screen_navigation.dart';
import 'package:analyse_app/screens/Login.dart';

import 'package:analyse_app/screens/classList.dart';

import 'package:clay_containers/widgets/clay_container.dart';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

import 'StatByClass.dart';
import '../widgets/custom_text.dart';
import 'loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Color lightBlue = Color(0xffdbf0f1);
class _HomePageState extends State<HomePage> {

double dyslexie;
double myop;
double dalto;
double dysphasie;
double dyscalculie;
double dyspraxie;
double dysorthographie;
  @override
  void initState() {


    super.initState();

  }




  double value=0;
  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context);
    student.loadStudentsByLevel();
    final List<EarningsTimeline> listEarnings = [
    for(var menu in student.studentsByLevel )

        EarningsTimeline(name: menu.name, level: menu.niveau),

 ];
    List<charts.Series<EarningsTimeline, String>> timeline = [
      charts.Series(
        id: 'Subscribers',
        data: listEarnings,
        domainFn: (EarningsTimeline timeline, _) => timeline.name,
        measureFn: (EarningsTimeline timeline, _) => timeline.level,

      )
    ];

    final test = Provider.of<TestProvider>(context);
    test.countStudentsByEnseignant();
    int students=test.students.length;
   test.countDyslexie();
   test.countDysphasie();
   test.countDyscalculie();
   test.countDyspraxie();

   int troublesDys=test.dysphasie.length+test.dyscalculie.length+test.dyslexie.length+test.dyspraxie.length;


   dyslexie=test.dyslexie.length*100/100;
    test.countDaltonisme();
    dalto=test.daltonisme.length*100/100;
    test.countMyopie();
    myop=test.myopie.length*100/100;

dyscalculie=test.dyscalculie.length*100/100;
dyspraxie=test.dyspraxie.length*100/100;
dysphasie=test.dysphasie.length*100/100;
    Color baseColor = Color(0xFFF2F2F2);

    Map<String, double> dataMap = {
      "Dyslexie": dyslexie,
      "Dysphasie":dysphasie,
      "Dyspraxie":dyspraxie,
      "Dyscalculie":dyscalculie,

      "قصر النظر": myop,
      "عمى الألوان": dalto,


    };
    PieChart(dataMap: dataMap);
    final user = Provider.of<UserProvider>(context);

    final classe = Provider.of<ClassProvider>(context);
    classe.loadClassesByUser();

    return Scaffold(
      backgroundColor: lightBlue,
      body:  Stack(

        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                  Colors.lightBlue.shade200,
                    lightBlue,
                  ],
                  begin:Alignment.bottomCenter,
                  end: Alignment.topCenter,


                )
            ),
          ),

          SafeArea(
            child: Container(
              width:500,
              padding: EdgeInsets.only(top:8.0,left:140.0),
              child: Column(
                children: <Widget>[
                  DrawerHeader(child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                       backgroundImage: NetworkImage(user.userModel?.image ?? "https://firebasestorage.googleapis.com/v0/b/login-demo-37c2c.appspot.com/o/Enfant1.jpg?alt=media&token=5a70fcef-8b4d-4aa6-a9c6-fe10d9e5d62b"),

                      ),
                      SizedBox(height: 10.0,),
                      Text(user.userModel?.name ?? "تحميل اسم المستخدم ...",
                        style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold),),


                    ],
                  ) ,
                  ),

                  Expanded(child: ListView(
                    children: [
                      ListTile(
                        onTap: (){
                         changeScreen(context, HomePage());
                        },
                        leading: Icon(Icons.home,
                            color: Colors.white),
                        title: Text("الصفحة الرئيسية",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center),


                      ),

                      ListTile(
                        onTap: (){
                          changeScreen(context, ClassList());
                        },

                        title: Text("الاقسام",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                        leading: Icon(Icons.person,
                            color: Colors.white),

                      ),
                      ListTile(
                        onTap: (){
                          changeScreen(context, StatByClass());
                        },

                        title: Text("الإحصائيات",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                        leading: Icon(Icons.timeline,
                            color: Colors.white),

                      ),
                      ListTile(
                        onTap: (){showDialog(
                          context: context,
                          builder: (_) {

                            return AlertDialog(
                              title: Padding(
                                padding: const EdgeInsets.only(left:78.0),
                                child: Text('هل تريد حقا الخروج؟'),
                              ),

                              actions: [
                                RaisedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('إلغاء'),
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right:61.0),
                                  child: RaisedButton(
                                    onPressed: () async {

                                      user.signOut();
                                      changeScreenReplacement(context, Log());
                                    },
                                    child: Text('تَأْكيد'),
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16.0))),

                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        },
                        leading:
                        Icon(Icons.block,
                            color: Colors.white),
                        title: Text("تسجيل خروج",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center),



                      )
                    ],
                  ),)
                ],
              ),
            ),

          )
          ,
          TweenAnimationBuilder(tween: Tween<double>(begin: 0,end:value),
              duration: Duration(milliseconds:500 ),
              curve: Curves.easeIn,
              builder: (_,double val,__){
                return(Transform(
                  alignment: Alignment.center,
                  transform:Matrix4.identity()..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200*val)
                    ..rotateY((pi/6)*val),
                  child: Scaffold(
                      backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,

                      leading: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: (){changeScreenReplacement(context, HelloScreen());}
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.notifications_none,
                            color: Colors.black,
                            size: 30,

                          ),
                        )
                      ],
                    ),
                    body:

                    SafeArea(

                      child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left:50.0,top: 40),
                              child: Row(

                                children: <Widget>[
                                Text(" : إحصائيات التلاميذ حسب صعوبات التعلم",textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 20 ?? 16, color: Colors.grey ),
                              ),

                                ],
                              ),
                            ),
                            Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Container(
                        height: 200
                          ,width: 330,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white.withOpacity(0.5)
                        ),
                        child: PieChart(

                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                         // colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 32,
                          // centerText: "HYBRID",
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            //legendPosition: LegendPosition.right,
                            showLegends: true,
                            // legendShape: _BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            //showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                            decimalPlaces: 0,
                          ),
                        ),
                      ),
                    ),
                            SizedBox(
                              height: 40,
                            ),


                          /*  Padding (
                              padding: const EdgeInsets.only(left:10.0,top:120),
                            //  Pin(size: 153.0, middle: 0.6522),
                             // Pin(size: 120.0, middle: 0.6154),
                              child: Container(
                                height : 80.0,
                                width:50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: const Color(0xffdae11a),
                                  border: Border.all(width: 1.0, color: const Color(0xffdae11a)),
                                ),
                                child:Container(
                                    height : 80.0,
                                    width:20.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: const Color(0xffffffff),
                                      border: Border.all(width: 1.0, color: const Color(0xffdae11a)),
                                    ),) ,
                              ),
                            ),*/


                                 Row(
                                   children: <Widget>[
                                     Padding(
                                       padding: const EdgeInsets.all(2),
                                       child: Container(
                                       // color: baseColor,
                                        height: 70,
                                        width: 150,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(15.0),
                                             color: Colors.white,
                                             border: Border.all(width: 1.0, color: lightBlue),

                                               boxShadow: [
                                                 BoxShadow(color:  lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                                               ]
                                           ),
                                        child:  Column(

                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[

                                                Text("DYS اضطرابات", style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,

                                                ),),
                                                SizedBox(width: 10,),
                                                Icon(Icons.equalizer, size: 20),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left:8.0,top: 8),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('حالة ' ,textAlign: TextAlign.center , style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey
                                                  ),),
                                                  Text(troublesDys.toString(), style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey
                                                  ),),
                                                ],
                                              ),
                                            ),

                                          ],)
                                ),

                                     ),
                                     SizedBox(width: 20,),
                                     Padding(
                                       padding: const EdgeInsets.all(8),
                                       child: Container(
                                          // color: baseColor,
                                           height: 70,
                                           width: 150,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(15.0),
                                               color: Colors.white,
                                               border: Border.all(width: 1.0, color: lightBlue),

                                               boxShadow: [
                                                 BoxShadow(color:  lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                                               ]
                                           ),
                                           child:  Column(

                                             children: [

                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: <Widget>[
                                                   Text("قصر النظر", style: TextStyle(
                                                     fontSize: 15,
                                                     fontWeight: FontWeight.w700,

                                                   ),),
                                                   SizedBox(width: 5,),
                                                   Icon(Icons.equalizer, size: 20),
                                                 ],
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.only(left:8.0,top:8),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                                     Text('تلميذ ' ,textAlign: TextAlign.center , style: TextStyle(
                                                         fontSize: 20,
                                                         color: Colors.grey
                                                     ),),
                                                     Text( test.myopie.length.toString()  , style: TextStyle(
                                                         fontSize: 20,
                                                         color: Colors.grey
                                                     ),),
                                                   ],
                                                 ),
                                               ),

                                             ],)
                                       ),
                                     ),


                                   ],
                                 ),


                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 100),
                                  child: Container(
                                      //color: baseColor,
                                      height: 70,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          color: Colors.white,
                                          border: Border.all(width: 1.0, color: lightBlue),

                                          boxShadow: [
                                            BoxShadow(color:  lightBlue, spreadRadius: 0.9,offset: Offset(4, 2),)
                                          ]
                                      ),
                                      child:  Column(

                                        children: [


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("عمى الألوان", style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,

                                              ),),
                                              SizedBox(width: 15,),
                                              Icon(Icons.equalizer, size: 20),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:8.0,top:8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('تلميذ ' ,textAlign: TextAlign.center , style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey
                                                ),),
                                                Text(test.daltonisme.length.toString() , style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.grey
                                                ),),
                                              ],
                                            ),
                                          ),
                                        ],)
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: Row(

                                children: <Widget>[
                                  Text(" : المستوى الحالى للتلاميذ الذين يجتازون الاختبارات",textAlign: TextAlign.left,
                                    style: TextStyle(fontSize:  18, color: Colors.grey ),
                                  ),

                                ],
                              ),
                            ),

                    Container(
                      height: 300,
                      padding: EdgeInsets.all(20),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              children: <Widget>[

                        Expanded(
                          child: charts.BarChart(timeline, animate: true,vertical: false,),

                        ),

                        ],
                      ),
                    ),
                  ),
                )
]))
                  ),
                )

                );
              }),
         GestureDetector(
            onHorizontalDragUpdate:(e){
              if (e.delta.dx>0){
                setState(() {
                  value=-1;
                });
              }else {
                setState(() {
                  value=0;
                });
              }
            } ,
            /* onTap: (){
              setState(() {
                value == 0 ? value =-1 :value=0;
              });
            },*/
          )
        ],
      ),
    );

  }

}
class GDPData {
  GDPData(this.trouble, this.taux);
  final String trouble;
  final double taux;
}



class EarningsTimeline {
  final String name;
  final int level;

  EarningsTimeline({
    @required this.name,
    @required this.level,

  });
}
