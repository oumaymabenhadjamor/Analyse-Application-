import 'package:analyse_app/models/Testes.dart';
import 'package:analyse_app/models/students.dart';
import 'package:analyse_app/providers/test.dart';
import 'package:analyse_app/widgets/userWidget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Color lightBlue = Color(0xffdbf0f1);
Color darkBlue = Color(0xff39888e);
Color yellow = Color(0xffffe9a7);
Color pink = Color(0xfff1e7f5);
class TestWidget extends StatelessWidget {
  final TestModel test;

  const TestWidget({Key key, this.test}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print (test.scoreMyopie.toString());
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
                      Text(test.scoreMyopie.toString(), style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                      ),),

                    ],
                  ),






                ],
              ),
            ),
          ),


        ],
      ),
    );

  }
}

