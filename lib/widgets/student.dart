import 'package:analyse_app/models/Testes.dart';
import 'package:analyse_app/models/students.dart';
import 'package:analyse_app/providers/app.dart';
import 'package:analyse_app/providers/student.dart';
import 'package:analyse_app/providers/test.dart';
import 'package:analyse_app/widgets/userWidget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Color lightBlue = Color(0xffdbf0f1);
Color darkBlue = Color(0xff39888e);
Color yellow = Color(0xffffe9a7);
Color pink = Color(0xfff1e7f5);
class StudentWidget extends StatelessWidget {
  final StudentModel student;

  const StudentWidget({Key key, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stud =Provider.of<StudentProvider>(context);
    final app = Provider.of<AppProvider>(context);
   return  Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: lightBlue.withOpacity(0.5)
      ),
      child: Row(
        children: [

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(student.age, style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                      ),)
                    ],
                  ),



                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: const Icon(Icons.delete),color: Colors.red,

                          onPressed: () async {
    mydialog(context,
    title: "حذف",
    content:  "هل تريد أن تحذف  " +student.name,
    ok: () async {
      Navigator.of(context).pop();


      await stud.removeStudent(id: student.id);
      app.changeLoading();
    });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:2.0),
                        child: Text(student.name, style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,

                        ),),
                      ),

                    ],
                  ),

                 /* Padding(
                    padding: const EdgeInsets.only(right:18.0),
                    child: Text(student.email, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: darkBlue
                    ),),
                  ),
*/




                ],
              ),
            ),
          ),

          Container (
            width: 140,
            height: 190,
    child: ClipRRect(
    borderRadius: BorderRadius.only(
    topRight:Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
           child: Image.network(student.image, fit: BoxFit.cover,),
    ), )
        ],
      ),
    );

  }
}
mydialog(BuildContext context,
    {String title, String content, VoidCallback ok}) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(left:98.0),
            child: Text(title),
          ),
          content: Padding(
            padding: const EdgeInsets.only(left:98.0),
            child: Text(content),
          ),
          actions: [
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("لا"),
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
            ),
            Padding(
              padding: const EdgeInsets.only(right:61.0),
              child: RaisedButton(
                onPressed: ok,
                child: Text("نعم"),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),

              ),
            ),
          ],
        );
      });
}


