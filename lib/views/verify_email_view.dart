import 'package:flutter/material.dart';
import 'package:sellandhelp/constants/routes.dart';
import 'package:sellandhelp/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.only(left: 35.0, top: 100.0,right: 35.0),
        child: Column(
          children: [
                 Image.asset("assets/images/FLogo3.png",
                  height: 150.0,),
                  SizedBox(height: 16.0,),
                  Text("We have sent you an email verification",
                  style: TextStyle(color: Colors.green,fontSize: 30.0,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0,),
                  Text("Please go to your mail box and verify your email",
                  style: TextStyle(color: Colors.green,fontSize: 12.0,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0,),
                Container(
                   width: size.width * 0.8,
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                             gradient: LinearGradient(
                              colors: <Color>[
                                Color.fromARGB(255, 133, 240, 137),
                                Color.fromARGB(255, 33, 139, 37),
                              ]
                              ),
                        ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: TextButton(onPressed: ()async{
                      AuthService.firebase().sendEmailVerification();
                      Navigator.of(context).pushNamedAndRemoveUntil(LoginRoute, (route) => false);
                    }, 
                    child: const Text("Re-send Verification"
                    ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                   width: size.width * 0.8,
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                             gradient: LinearGradient(
                              colors: <Color>[
                                Color.fromARGB(255, 133, 240, 137),
                                Color.fromARGB(255, 33, 139, 37),
                              ]
                              ),
                        ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: TextButton(onPressed: ()async{
                      await AuthService.firebase().logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(RegisterRoute, (route) => false);
                    }, 
                    child: const Text("Restart"
                    ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),),
                    ),
                  ),
                ),
              ]
              ),
      ),
    );
  }
}