import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellandhelp/views/login_view.dart';
import 'package:sellandhelp/views/register_view.dart';
import 'package:sellandhelp/views/verify_email_view.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        "/login/":(context) => const LoginPage(),
        "/register/":(context) => const RegisterPage(),
        "/verification/":(context) => const VerifyEmailView(),
        "/mainui/":(context) => const MainUI(),
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ), builder: 
        (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) { 
           switch (snapshot.connectionState){
                case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if (user != null){
                  if (user.emailVerified){
                    return const MainUI();
                  }else{
                    return const VerifyEmailView();
                  }
                }else{
                  return const LoginPage();
                }
                
          default:
          return Scaffold(body: Center(child: const CircularProgressIndicator()));
            }
         },
        ),
    );
  }
}

enum MenuAction {logout}

class MainUI extends StatefulWidget {
  const MainUI({super.key});

  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main UI"),
      actions: [
        PopupMenuButton<MenuAction>(
          onSelected: (value) async{
            switch (value){
              case MenuAction.logout:
              final shouldLogOut = await showLogOutDialog(context);
              if(shouldLogOut){
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil("/login/", (_) => false);
              }
            }
              
            },
          itemBuilder:(context) {
            return const[
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("Log Out"))
            ];
          
        },)
      ],
      ),
      body: Center(child: const Text("Hello Customer",style: TextStyle(color: Colors.red,fontSize: 30.0
      ,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog(context: context, 
  builder:(context) {
    return AlertDialog(
      title: const Text("Sign Out"),
      content: const Text("Are tou sure you want to sign out?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, 
        child: const Text("Cancel")),
        TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, 
        child: const Text("Log Out")),
      ],
    );
  }
  ).then((value) => value ?? false);
}

