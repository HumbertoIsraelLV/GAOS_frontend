
import 'package:flutter/material.dart';

import 'package:gaos_front/pages/encargos_edit_page.dart';
import 'package:gaos_front/pages/encargos_page.dart';
import 'package:gaos_front/pages/home_page.dart';
import 'package:gaos_front/pages/login_page.dart';
import 'package:gaos_front/pages/pedidos_edit_page.dart';
import 'package:gaos_front/pages/pedidos_page.dart';
import 'package:gaos_front/pages/usuarios_page.dart';
import 'package:gaos_front/pages/usuarios_edit_page.dart';


final rutas = <String, WidgetBuilder>{
  '/'               : (BuildContext context) => LoginPage(),
  'home'            : (BuildContext context) => HomePage(),
  'usuarios'        : (BuildContext context) => UsuariosPage(),
  'usuarios_edit'   : (BuildContext context) => UsuariosEditPage(),
  'pedidos'         : (BuildContext context) => PedidosPage(),
  'pedidos_edit'    : (BuildContext context) =>PedidosEditPage(),
  'encargos'        : (BuildContext context) => EncargosPage(),
  'encargos_edit'   : (BuildContext context) =>EncargosEditPage(),
};