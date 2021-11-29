import 'package:analyse_app/models/class.dart';
import 'package:analyse_app/providers/student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';
import '../screens/loading.dart';

Color lightBlue = Color(0xffdbf0f2);
class ClasseWidget extends StatefulWidget {
  final ClassModel classe;

  const ClasseWidget({Key key, this.classe}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<ClasseWidget> {

  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[


          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                border: Border.all(width: 1.6, color:lightBlue),

                boxShadow: [
                  BoxShadow(color:  lightBlue, spreadRadius: 1.4,offset: Offset(2, 2))
                ]
            ),
          ),

            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(widget.classe.classname, textAlign:TextAlign.right,style:TextStyle(color: Colors.black54, fontSize: 16,)),
            )
        ],
      ),
    );
  }
}
