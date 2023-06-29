import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellandhelp/constants/routes.dart';
import 'package:sellandhelp/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:sellandhelp/utilities/show_error_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

 @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/FLogo3.png",
                      height: 150.0,),
                      SizedBox(height: 16.0,),
                      Text("Sign Up Now",
                      style: TextStyle(color: Colors.green,fontSize: 36.0,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0,),
                      Text("Be Part Of Our Family",
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
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(controller: _email,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your email"
                          ),),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 189, 252, 191),
                            border: Border.all(color: Color.fromARGB(255, 47, 114, 50)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(controller: _password,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your password"
                          ),),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 189, 252, 191),
                            border: Border.all(color: Color.fromARGB(255, 47, 114, 50)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(controller: _confirmPassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Confirm your password"
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
                          child: TextButton(onPressed: () async {
                               
                            final email = _email.text;
                            final password = _password.text;
                            final confirmPassword = _confirmPassword.text;
                            if (confirmPassword != password){
                              await showErrorDialog(context, "Password is not matching");
                            } else if (confirmPassword == password){
                              try{
                              final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email, password: password);
                              devtools.log(user.toString());
                              Navigator.of(context).pushNamedAndRemoveUntil(VerifyRoute, (route) => false);
                            } on FirebaseAuthException catch (e){
                              if(e.code == "weak-password"){
                                await showErrorDialog(context, "Weak Password");
                              }else if(e.code == "email-already-in-use"){
                                await showErrorDialog(context, "Email already in use");
                              }else if(e.code == "invalid-email"){
                                await showErrorDialog(context, "Invalid Email");
                              }
                              else{
                              await showErrorDialog(context, e.code);
                              }
                            }catch (e){
                              await showErrorDialog(context, e.toString());
                            }
              
                            }
                            
                            
                          },
                          child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Already Registered!"),
                         TextButton(onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(LoginRoute, (route) => false);
                      }, 
                      child: const Text("Sign In Here", style: TextStyle(fontWeight: FontWeight.bold),)),
                      ],
                      ),
                     
            
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

