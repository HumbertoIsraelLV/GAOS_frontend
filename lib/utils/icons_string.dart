import 'package:flutter/material.dart';
final _icons = <String, IconData>{
  'usuarios'      :Icons.people,
  'pedidos'       :Icons.view_headline,
  'encargos'      :Icons.assignment
};

Icon getIcon(String nombreIcono){
  return Icon(_icons[nombreIcono], color: Colors.blue,);
}