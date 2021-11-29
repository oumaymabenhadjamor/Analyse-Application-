import 'package:analyse_app/providers/class.dart';
import 'package:analyse_app/widgets/classwidget.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import '../widgets/custom_text.dart';
import 'screen_navigation.dart';
import 'classScreen.dart';


class ClassSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        title: CustomText(text: "الاقسام", size: 20,),
        elevation: 0.0,
        centerTitle: true,

      ),
      body: classProvider.searchedClasses.length < 1? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.search, color: Colors.grey, size: 30,),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(text: "لم يتم العثور على أقسام", color: Colors.grey, weight: FontWeight.w300, size: 22,),
            ],
          )
        ],
      ) : ListView.builder(
          itemCount: classProvider.searchedClasses.length,
          itemBuilder: (context, index){
            return GestureDetector(
                onTap: ()async{
                  changeScreen(context, ClassScreen(classModel: classProvider.searchedClasses[index]));
                },
                child: ClassWidget(classe: classProvider.searchedClasses[index]));
          }),
    );
  }
}
