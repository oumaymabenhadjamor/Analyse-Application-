import 'package:analyse_app/models/class.dart';
import 'package:analyse_app/providers/app.dart';
import 'package:analyse_app/providers/student.dart';
import 'package:analyse_app/providers/test.dart';

import 'package:analyse_app/screens/student.dart';
import 'package:analyse_app/screens/studentSearch.dart';
import 'package:analyse_app/widgets/student.dart';
import 'package:analyse_app/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text.dart';
import 'loading.dart';
import 'screen_navigation.dart';
Color lightBlue = Color(0xffdbf0f1);
final _key =GlobalKey<ScaffoldState>();

class ClassScreen extends StatelessWidget {
  final ClassModel classModel;

  const ClassScreen({Key key, this.classModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final authProvider =Provider.of<StudentProvider>(context);
    final testt = Provider.of<TestProvider>(context);
    final student = Provider.of<StudentProvider>(context);
    student.loadStudentsByClass(classId:classModel.id);
    final test = Provider.of<TestProvider>(context);


    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
            size: 30,
          ),
            onPressed: (){Navigator.pop(context);}
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
      body: Column(

            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/searchBg2.png")
                    )
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Text(":القسم", style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'circe'
                      ),),
                      Text(classModel.classname, style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'circe',
                          fontWeight: FontWeight.w700
                      ),),
                      Expanded(
                          child: Container()
                      ),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white
                        ),
                        child: Row(
                          children: [

                            Expanded(
                              child: TextField(
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (pattern)async{
                                    app.changeLoading();

                                    await student.search(name:pattern,id: classModel.id);
                                    changeScreen(context, StudentSearchScreen());

                                    app.changeLoading();
                                  },
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'circe'
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "ابحث عن التلاميذ",

                                ),
                                  textAlign: TextAlign.right
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              ),
            /*  Stack(
                children: <Widget>[

              Column(
                children: studentProvider.studentsByClass
                    .map((item) => GestureDetector(
                  onTap: () {
                    changeScreen(context, Student(student: item,));
                  },
                  child: StudentWidget(
                    student: item,
                  ),
                ))
                    .toList(),
              )


            ],

          ),*/
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("قائمة التلاميذ", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),

                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child:  Column(
                            children: student.studentsByClass
                                .map((item) => GestureDetector(
                              onTap: () async {
                          print(item.ud);


                            if(await testt.loadtestsByUser(student: item.ud) == true)
                         {  testt.loadtestsByUser(student: item.ud);
                         app.changeLoading();
                         changeScreen(context, Student(student: item));

                         }
                              },
                              child: StudentWidget(
                                student: item,
                              ),


                            ))
                                .toList(),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              )
   ]
    )
    ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              authProvider.classe=classModel.id;
              authProvider.image="https://firebasestorage.googleapis.com/v0/b/login-demo-37c2c.appspot.com/o/Enfant1.jpg?alt=media&token=5a70fcef-8b4d-4aa6-a9c6-fe10d9e5d62b";
             authProvider.niveau=0;
              return AlertDialog(
                title: Padding(
                  padding: const EdgeInsets.only(left:78.0),
                  child: Text('إضافة تلميذ'),
                ),
                content: ListView(
                  shrinkWrap: true,
                  children: [


                    TextFormField(
                        controller: authProvider.name,
                        decoration: InputDecoration(hintText: 'الإ سم'),
                        textAlign: TextAlign.right
                    ),
                    TextFormField(
                        controller: authProvider.age,
                        decoration: InputDecoration(hintText: 'العمر'),
                        textAlign: TextAlign.right
                    ),
                    TextFormField(
                        controller: authProvider.email,
                        decoration: InputDecoration(hintText: 'اللقب'),
                        textAlign: TextAlign.right
                    ),
                    TextFormField(
                        controller: authProvider.password,
                        decoration: InputDecoration(hintText: 'كلمة السر'),
                        textAlign: TextAlign.right
                    ),


                  ],
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
                        app.changeLoading();
                       // uploadPic();

                        await authProvider.signUpStudent() ;



                        authProvider.clearController();

                        Navigator.pop(context);
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
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),);
  }
}
