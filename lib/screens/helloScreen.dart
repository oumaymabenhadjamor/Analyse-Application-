
import 'package:analyse_app/helpers/AppColor.dart';
import 'package:analyse_app/helpers/AppTextStyle.dart';
import 'package:analyse_app/providers/user.dart';
import 'package:analyse_app/screens/Register2.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'loading.dart';
import 'screen_navigation.dart';
import 'Login.dart';
Color lightBlue = Color(0xffdbf0f1);
  Color darkBlue = Color(0xff39888e);
class HelloScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<HelloScreen> {

  final _key =GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider =Provider.of<UserProvider>(context);
    return Scaffold(
      key:_key,
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
               /* begin: Alignment.topLeft,
                end: Alignment.topCenter,*/
                colors: [lightBlue,  AppColor.primaryLight ]),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.75,

                        child: Image.asset("assets/splash2.png"),
                      ),

                  Padding(
                    padding: const EdgeInsets.only(right:60.0,bottom: 80),
                    child: Container(

                      height: 56,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topCenter,
                          colors: [
                            lightBlue,
                            AppColor.primary.withOpacity(0.2)
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(5, 5),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(Icons.arrow_back,
                                color: Colors.white, size: 28),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: ()async{

                                changeScreenReplacement(context, Register());
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Text(
                                    'إنشاء حساب',
                                    style: AppTextStyle.style(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.only(right:60.0,top: 500),
                    child: Container(

                      height: 56,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topCenter,
                          colors: [
                            lightBlue,
                            AppColor.primary.withOpacity(0.2)
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(5, 5),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(Icons.arrow_back,
                                color: Colors.white, size: 28),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: ()async{

                                changeScreenReplacement(context, Log());
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Text(
                                    'تسجيل الدخول',
                                    style: AppTextStyle.style(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),



                ],
              ),



            ],
          ),
        ),

    );
  }
}