
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellandhelp/constants/routes.dart';
import 'package:sellandhelp/firebase_options.dart';
import 'package:sellandhelp/utilities/show_error_dialog.dart';
import 'dart:developer' as devtools show log;

import 'package:sellandhelp/views/verify_email_view.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isLoading = false;
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/FLogo3.png",
                    height: 150.0,),
                    SizedBox(height: 16.0,),
                    Text("Welcome Back",
                    style: TextStyle(color: Colors.green,fontSize: 36.0,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0,),
                    Text("Sign In",
                    style: TextStyle(color: Colors.green,fontSize: 24.0,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0,),
                   Container(
                    width: size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 189, 252, 191),
                          border: Border.all(color: Color.fromARGB(255, 47, 114, 50)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: TextField(
                          controller: _email,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email"
                          ),),
                        ),
                      ),
                    SizedBox(height: 16.0,),
                    Container(
                      width: size.width * 0.9,
                         decoration: BoxDecoration(
                            color: Color.fromARGB(255, 189, 252, 191),
                            border: Border.all(color: Color.fromARGB(255, 47, 114, 50)),
                            borderRadius: BorderRadius.circular(12),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: TextField(
                          controller: _password,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password"
                          ),),
                        ),
                      ),
                    SizedBox(height: 16.0,),
                     Container(
                      width: size.width * 0.9,
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
                                child: TextButton(
                                  onPressed: () async {
                                    
                                  final email = _email.text;
                                  final password = _password.text;
                                  try{
                                    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: email, password: password);
                                    devtools.log(user.toString());
                                  }on FirebaseAuthException catch (e){
                                    if (e.code == "user-not-found"){
                                      await showErrorDialog(context, "User Not Found");
                                    }else if(e.code == "wrong-password"){
                                      await showErrorDialog(context, "Wrong password");
                                    }else if(e.code == "unknown"){
                                     await showErrorDialog(context, "Unknown User");
                                    }else showErrorDialog(context, e.code.toString());
                                    
                                  }catch (e){
                                    await showErrorDialog(context, e.toString());
                                  }
                                  final user2 = FirebaseAuth.instance.currentUser;
                                  if (user2 != null){
                                  if (user2.emailVerified){
                                    Navigator.of(context).pushNamedAndRemoveUntil(MainUIRoute, (route) => false);
                                  }else{
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const VerifyEmailView()),);
                                  }
                                }
                                },
                                child: const Text("Sign In",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),),
                                ),
                              ),
                            ),
                    SizedBox(height: 16.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not registered yet!"),
                         TextButton(onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(RegisterRoute, (route) => false);
                    }, 
                    child: const Text("Register here.",style: TextStyle(fontWeight: FontWeight.bold),)),
                      ],
                    ),
                   
                  ],
                ),
        ),
      ),
    );
  }
 
}



