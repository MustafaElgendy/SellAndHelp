import 'package:flutter/material.dart';
import 'package:sellandhelp/constants/routes.dart';
import 'package:sellandhelp/services/auth/auth_service.dart';

import '../enums/menu_action.dart';

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
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(LoginRoute, (_) => false);
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
