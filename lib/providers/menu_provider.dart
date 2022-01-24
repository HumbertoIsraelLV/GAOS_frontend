import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:gaos_front/models/usuario.dart';
import 'package:gaos_front/preferences/preferences.dart';

class MenuProvider{
  List<dynamic> opciones = [];
  static final prefs = Preferencias();
  // final activeUser = UsuarioModel();
  //  String gol = prefs.activeUser;
  // prefs.activeUser.set(activeUser); 

  UsuarioModel activeUser = prefs.activeUser;
  Future<List<dynamic>> cargarData() async {
    String datos = await rootBundle.loadString('data/menu_opts.json');
    Map dataMap = json.decode(datos);
    switch(activeUser.role){
      case 'ADMIN_ROLE':
        opciones = dataMap['admin'];
      break;
      case 'WORKER_ROLE':
        opciones = dataMap['worker'];
      break;  
    }
    return opciones;
  }
}

// final menuProvider = MenuProvider();