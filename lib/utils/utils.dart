import 'package:flutter/material.dart';
bool isNumeric(String s){
  if(s.isEmpty)return false;
  final n = num.tryParse(s);
  return (n==null)?false:true;
}

void mostrarAlerta(BuildContext context, String t, String m){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(t),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(m),
            ],
          ),
          actions: <Widget>[
            // FlatButton(
            //   child: Text('Cancelar'),
            //   onPressed: ()=>Navigator.of(context).pop(),
            // ),  
            FlatButton(
              child: Text('OK'),
              onPressed: ()=>Navigator.of(context).pop(),
            ),  
          ],
        );
      }
    );
  }