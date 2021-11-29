
import 'package:analyse_app/providers/app.dart';
import 'package:analyse_app/providers/class.dart';
import 'package:analyse_app/providers/student.dart';
import 'package:analyse_app/providers/test.dart';
import 'package:analyse_app/widgets/ClasseWidget.dart';
import 'package:analyse_app/widgets/classwidget.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

Color lightBlue = Color(0xffdbf0f1);
class StatByClass extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final _key =GlobalKey<ScaffoldState>();
class _HomePageState extends State<StatByClass> {
   bool reverse;




  @override
  Widget build(BuildContext context) {
    final test = Provider.of<TestProvider>(context);
    final classe = Provider.of<ClassProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final student = Provider.of<StudentProvider>(context);
classe.loadClassesByUser();

String classs="";

 int testes=test.testsByClass.length;

int students=student.studentsByClass.length;
    return Scaffold(
     //backgroundColor: lightBlue,
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

      ),
      body:

      Column(


          children: <Widget>[
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left:200.0),
              child: Row(

                children: <Widget>[
                  Text(" : قائمة الاقسام ",textAlign: TextAlign.right,
                    style: TextStyle(fontSize:  21, color: Colors.grey ),
                  ),

                ],
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,

                  itemCount: classe.classesByUser.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        test.countTestsByClass(ClassId: classe.classesByUser[index].id);

                             test.countDyslexieByClass(ClassId: classe.classesByUser[index].id);
                             test.countMyopieByClass(ClassId: classe.classesByUser[index].id);
                             test.countDaltonismeByClass(ClassId: classe.classesByUser[index].id);
                        test.countDyscalculieByClass(ClassId: classe.classesByUser[index].id);

                        test.countDysphasieByClass(ClassId: classe.classesByUser[index].id);
                        test.countDyspraxieByClass(ClassId: classe.classesByUser[index].id);

                        student.loadStudentsByClass(classId: classe.classesByUser[index].id);
                      classs=  classe.classesByUser[index].classname;
                             app.changeLoading();


                      },
                      child:  ClasseWidget(classe: classe.classesByUser[index],)
                    );
                  }),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left:100.0),
              child: Row(

                children: <Widget>[

                  Text(" : احصائيات التلاميذ حسب القسم ",textAlign: TextAlign.right,
                    style: TextStyle(fontSize:  21, color: Colors.grey ),
                  ),

                ],
              ),
            ),

            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:20,left: 20),
                  child: Container(
                    // color: baseColor,
                      height: 70,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: lightBlue),

                          boxShadow: [
                            BoxShadow(color: lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                          ]
                      ),
                      child:  Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Text("اختبار", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),),
                              SizedBox(width: 10,),
                              Icon(Icons.equalizer, size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("تلميذ" ,textAlign: TextAlign.center , style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                ),),
                                Text(testes.toString() ,textAlign: TextAlign.center , style: TextStyle(
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
                  padding: const EdgeInsets.only(top:20,left: 20),
                  child: Container(
                    // color: baseColor,
                      height: 70,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: lightBlue),

                          boxShadow: [
                            BoxShadow(color:  lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                          ]
                      ),
                      child:  Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("عدد التلاميذ", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),),
                              SizedBox(width: 5,),
                              Icon(Icons.equalizer, size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top:5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("تلميذ",textAlign: TextAlign.center , style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                ),),
                                Text(students.toString() ,textAlign: TextAlign.center , style: TextStyle(
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
                  padding: const EdgeInsets.only(top:20,left: 20),
                  child: Container(
                    // color: baseColor,
                      height: 70,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: lightBlue),

                          boxShadow: [
                            BoxShadow(color: lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                          ]
                      ),
                      child:  Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Text("Myopie", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),),
                              SizedBox(width: 10,),
                              Icon(Icons.equalizer, size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("حالة" ,textAlign: TextAlign.center , style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                ),),
                                Text(test.myopieByClass.length.toString() ,textAlign: TextAlign.center , style: TextStyle(
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
                  padding: const EdgeInsets.only(top:20,left: 20),
                  child: Container(
                    // color: baseColor,
                      height: 70,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: lightBlue),

                          boxShadow: [
                            BoxShadow(color:  lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                          ]
                      ),
                      child:  Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Dyslexie", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),),
                              SizedBox(width: 5,),
                              Icon(Icons.equalizer, size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top:5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("حالة",textAlign: TextAlign.center , style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                ),),
                                Text(test.dyslexieByClass.length.toString() ,textAlign: TextAlign.center , style: TextStyle(
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
                  padding: const EdgeInsets.only(top:20,left: 20),
                  child: Container(
                    // color: baseColor,
                      height: 70,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: lightBlue),

                          boxShadow: [
                            BoxShadow(color: lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                          ]
                      ),
                      child:  Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Text("Dyscalculie", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),),
                              SizedBox(width: 10,),
                              Icon(Icons.equalizer, size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("حالة" ,textAlign: TextAlign.center , style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                ),),
                                Text(test.dyscalculieByClass.length.toString() ,textAlign: TextAlign.center , style: TextStyle(
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
                  padding: const EdgeInsets.only(top:20,left: 20),
                  child: Container(
                    // color: baseColor,
                      height: 70,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: lightBlue),

                          boxShadow: [
                            BoxShadow(color:  lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                          ]
                      ),
                      child:  Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Daltonisme", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),),
                              SizedBox(width: 5,),
                              Icon(Icons.equalizer, size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top:5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("حالة",textAlign: TextAlign.center , style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                ),),
                                Text(test.daltonismeByClass.length.toString() ,textAlign: TextAlign.center , style: TextStyle(
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
                  padding: const EdgeInsets.only(top:20,left: 20),
                  child: Container(
                    // color: baseColor,
                      height: 70,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: lightBlue),

                          boxShadow: [
                            BoxShadow(color: lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                          ]
                      ),
                      child:  Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Text("Dysphasie", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),),
                              SizedBox(width: 10,),
                              Icon(Icons.equalizer, size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("حالة" ,textAlign: TextAlign.center , style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                ),),
                                Text( test.dysphasieByClass.length.toString() ,textAlign: TextAlign.center , style: TextStyle(
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
                  padding: const EdgeInsets.only(top:20,left: 20),
                  child: Container(
                    // color: baseColor,
                      height: 70,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: lightBlue),

                          boxShadow: [
                            BoxShadow(color:  lightBlue, spreadRadius: 0.9,offset: Offset(4, 2))
                          ]
                      ),
                      child:  Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Dyspraxie", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,

                              ),),
                              SizedBox(width: 5,),
                              Icon(Icons.equalizer, size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0,top:5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("حالة",textAlign: TextAlign.center , style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey
                                ),),
                                Text(test.dyspraxieByClass.length.toString() ,textAlign: TextAlign.center , style: TextStyle(
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

          ])
    );

  }


}
