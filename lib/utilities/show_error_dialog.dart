
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context,String erorrText){
  return showDialog(context: context, 
  builder:(context) {
    return AlertDialog(
      title: const Text("Something went wrong"),
      content: Text(erorrText),
      actions:<Widget> [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, 
        child: const Text("Close")),
        
      ],
    );
  }
  );
}