

import 'package:analyse_app/models/Testes.dart';
import 'package:analyse_app/models/students.dart';
import 'package:analyse_app/providers/app.dart';
import 'package:analyse_app/providers/test.dart';
import 'package:analyse_app/providers/user.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text.dart';
import 'loading.dart';

class Student extends StatefulWidget {
  final StudentModel student;

  const Student({@required this.student});






  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Student>  {
  int quantity = 1;
  List<TestModel> l;
  int l2;
  bool _loading;
  double _progressValue;

  final _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _loading = true;
    _progressValue = 0.0;

  }
  double dyslexie,dyscalculie,dysphasie,dyspraxie,myopie,daltonisme, dysorthographie;
  @override
  Widget build(BuildContext context) {
    final test=Provider.of<TestProvider>(context);

    test.loadtestsByUser(student:widget.student.ud)  ;
print(9-test.testsByUser.first.scoreColorBlind);
int d1=test.testsByUser.first.scoreColorBlind==null?0:9-test.testsByUser.first.scoreColorBlind;
int d2=test.testsByUser.first.scoreDyslexie==null?0:4-test.testsByUser.first.scoreDyslexie;
    int d3=test.testsByUser.first.scoreDysphasie==null?0:2-test.testsByUser.first.scoreDysphasie;
    int d4=test.testsByUser.first.scoreMyopie==null?0:6-test.testsByUser.first.scoreMyopie;
    int d5=test.testsByUser.first.scoreDyspraxie==null?0:3-test.testsByUser.first.scoreDyspraxie;
    int d6=test.testsByUser.first.scoreDyscalculie==null?0:6-test.testsByUser.first.scoreDyscalculie;
    daltonisme =d1*100/9;
    dyslexie=d2*100/4;
    dysphasie=d3*100/2;
    myopie =d4*100/6;
    dyspraxie=d5*100/3;
    dyscalculie=d6*100/6;
    dysorthographie =2*100/2;


    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[


        ],
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){Navigator.pop(context);}),
      ),
      backgroundColor: Colors.white,
      body:test.testsByUser.length==0?Padding(
        padding: const EdgeInsets.only(left:40.0,top: 200),
        child: Text("لم يجرى الاختبار أي بعد",textAlign: TextAlign.center,style: TextStyle(fontSize: 35,color: Colors.black54),),
      ) :
      Stack(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:58.0),
              child: CircleAvatar(
                radius: 120,
               backgroundImage: NetworkImage(widget.student.image),
              ),
            ),
            SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.only(top:255.0,left:120),
              child: CustomText(text: "الاسم:"+widget.student.name,size: 26,weight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left:170,top:300.0),
              child: CustomText(text: "العمر:"+"${widget.student.age }",size: 20,weight: FontWeight.bold,color: Colors.teal,),
            ),


            SizedBox(height: 15,),



            Padding(
              padding: const EdgeInsets.only(top:360.0,left: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                  CustomText(text:test.testsByUser.first.scoreColorBlind==null?'لم يجرى الاختبار  بعد':"%"+daltonisme.toString().substring(0,3),size: 16,weight: FontWeight.bold,color: Colors.indigo),
                  SizedBox(width: 10,),
                  CustomText(text: " (Daltonisme)عمى الألوان",size: 12,weight: FontWeight.w400),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:400.0,left: 140),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[



                  CustomText(text:test.testsByUser.first.scoreMyopie==null?'لم يجرى الاختبار  بعد': "%"+myopie.toString().substring(0,3),size: 16,weight: FontWeight.bold,color: Colors.indigo),
                  SizedBox(width: 10,),
                  CustomText(text: "  (Myopie)قصر النظر",size: 12,weight: FontWeight.w400),


                ])

    ),
            Padding(
              padding: const EdgeInsets.only(top:440.0,left: 130),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  CustomText(text:test.testsByUser.first.scoreDyslexie==null?'لم يجرى الاختبار  بعد':"%"+dyslexie.toString().substring(0,3),size: 16,weight: FontWeight.bold,color: Colors.indigo),
                  SizedBox(width: 10,),
                  CustomText(text: " (Dyslexie)عسر القراءة ",size: 12,weight: FontWeight.w400),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:480.0,left: 110),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  CustomText(text:test.testsByUser.first.scoreDyscalculie==null?'لم يجرى الاختبار  بعد':"%"+dyscalculie.toString().substring(0,3),size: 16,weight: FontWeight.bold,color: Colors.indigo),
                  SizedBox(width: 10,),
                  CustomText(text: "(Dyscalculie) عسر الحساب",size: 12,weight: FontWeight.w400),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:520.0,left: 120),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  CustomText(text:test.testsByUser.first.scoreDysphasie==null?'لم يجرى الاختبار  بعد':"%"+dysphasie.toString().substring(0,3),size: 16,weight: FontWeight.bold,color: Colors.indigo),
                  SizedBox(width: 10,),
                  CustomText(text: "(Dysphasie)خلل الكلام",size: 12,weight: FontWeight.w400),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:560.0,left: 170),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  CustomText(text:test.testsByUser.first.scoreDyspraxie==null?'لم يجرى الاختبار  بعد':"%"+dyspraxie.toString().substring(0,3),size: 16,weight: FontWeight.bold,color: Colors.indigo),
                  SizedBox(width: 10,),
                  CustomText(text: "Dyspraxie",size: 12,weight: FontWeight.w400),

                ],
              ),
            ),
    /*    test.testsByUser.length==0?Text("لم يجرى الاختبار بعد") :Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                  CustomText(text:test.testsByUser.first.scoreDyslexie.toString(),size: 12,weight: FontWeight.bold,color: Colors.indigo),
                SizedBox(width: 10,),
                  CustomText(text: test.testsByUser.first.scoreMyopie.toString(),size: 16,weight: FontWeight.bold,color: Colors.indigo),
                SizedBox(width: 10,),
                  CustomText(text:test.testsByUser.first.scoreColorBlind.toString(),size: 16,weight: FontWeight.bold,color: Colors.indigo),
                SizedBox(width: 10,),





              ],
            ),*/

          ],

      ),

      );

  }


}
