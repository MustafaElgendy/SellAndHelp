
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellandhelp/firebase_options.dart';

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
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body:FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ), builder: 
        (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) { 
           switch (snapshot.connectionState){
                case ConnectionState.done:
                return Column(
            children: [
              TextField(controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter your email here"
              ),),
              TextField(controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: "Enter your password here"
              ),),
              TextButton(onPressed: () async {
     
                final email = _email.text;
                final password = _password.text;
                try{
                  final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email, password: password);
                print(user);
                }on FirebaseAuthException catch (e){
                  if (e.code == "user-not-found"){
                    print("User not found");
                  }else if(e.code == "wrong-password"){
                    print("Wrong password");
                  }else if(e.code == "unknown"){
                    print("Unknown!!!");
                  }else print(e.code);
                }
                
              },
              child: const Text("Login"),
              ),
            ],
          );
          default:
          return const Text("Loading....");
            }
         },
        ),
    );
  }
 
}