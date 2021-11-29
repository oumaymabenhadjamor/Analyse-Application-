import 'package:analyse_app/models/class.dart';
import 'package:analyse_app/providers/app.dart';
import 'package:analyse_app/providers/class.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Color lightBlue = Color(0xffdbf0f1);
Color darkBlue = Color(0xff39888e);
Color yellow = Color(0xffffe9a7);
Color pink = Color(0xfff1e7f5);
class ClassWidget extends StatefulWidget {
  final ClassModel classe;

  const ClassWidget({Key key, this.classe}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<ClassWidget> {

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final classes =Provider.of<ClassProvider>(context);
    final app = Provider.of<AppProvider>(context);
     return  Container(
      key: _key,
      margin: EdgeInsets.only(top: 20),
      height: 130,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: lightBlue.withOpacity(0.5)
      ),

            child: Container(


              child: Padding(
                padding: const EdgeInsets.only(left:108.0),
                child: Row(
                  children: <Widget>[
                    Column(

                      children: [


                        Padding(
                          padding: const EdgeInsets.only(top:29.0),
                          child: Text(widget.classe.classname, style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,

                          ),),
                        ),

                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:3),
                              child: IconButton(
                                icon: const Icon(Icons.delete),color: Colors.red,

                                onPressed: () async {
                                  mydialog(context,
                                      title: "حذف",
                                      content: "هل تريد أن تحذف  "+ widget.classe.classname ,
                                      ok: () async {
                                        Navigator.of(context).pop();


                                        await classes.removeClass(id:widget.classe.id);
                                        app.changeLoading();
                                      });


                                },
                              ),
                            ),
                          ],
                        ),



                      ],
                    ),
                  ],
                ),
              ),

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



