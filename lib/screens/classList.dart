
import 'package:analyse_app/providers/app.dart';
import 'package:analyse_app/providers/class.dart';

import 'package:analyse_app/screens/screen_navigation.dart';

import 'package:analyse_app/screens/classScreen.dart';
import 'package:analyse_app/widgets/classwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:analyse_app/providers/student.dart';

import 'classSearch.dart';

Color lightBlue = Color(0xffdbf0f1);
class ClassList extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
final FirebaseAuth _auth = FirebaseAuth.instance;

final _key =GlobalKey<ScaffoldState>();
class _HomePageState extends State<ClassList> {

  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
  ];
  double value=0;




  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final student = Provider.of<StudentProvider>(context);
    final classe = Provider.of<ClassProvider>(context);







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
                height: MediaQuery.of(context).size.height*0.25,
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

                      Text(":عدد الاقسام", style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'circe'
                      ),),
                      Padding(

                        padding: const EdgeInsets.only(right:30.0),
                        child: Text( classe.classesByUser.length.toString(), style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'circe',
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                      Expanded(
                          child: Container()
                      ),
                      Container(
                        height: 50,
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

                                      await classe.search(name:pattern);
                                      changeScreen(context, ClassSearchScreen());

                                    app.changeLoading();
                                  },
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'circe'
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "ابحث عن القسم",

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
                          Text("قائمة  الاقسام", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),

                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child:  Column(
                            children:  classe.classesByUser
                                .map((item) => GestureDetector(
                              onTap: () async {
                                app.changeLoading();

                                await student.loadStudentsByClass(
                                    classId: item.id);
                                 app.changeLoading();

                                changeScreen(
                                    context,
                                    ClassScreen(
                                      classModel: item,
                                    ));
                              },
                              child:  ClassWidget(classe: item,),
                            ))
                                .toList(),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ]
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {

              return AlertDialog(
                title: Padding(
                  padding: const EdgeInsets.only(left:78.0),
                  child: Text('إضافة قسم'),
                ),
                content: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(

                      controller: classe.name,
                      decoration: InputDecoration(hintText: 'إسم القسم'),

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
                        if(!await classe.createClass()) {

                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("لم تتم  الإضافة !"))
                          );
                          return;
                        }

                        classe.clearController();
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
      ),
    );
  }


}
