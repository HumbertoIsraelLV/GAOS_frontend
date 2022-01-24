import 'package:flutter/material.dart';
import 'package:gaos_front/preferences/preferences.dart';

import 'package:gaos_front/utils/icons_string.dart';
import 'package:gaos_front/providers/menu_provider.dart';


class HomePage extends StatelessWidget {
  final prefs = Preferencias();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido ${(prefs.activeUser).nombre}'),
      ),
      body: _lista(),

    );
  }
  Widget _lista(){
    return FutureBuilder(
      future: MenuProvider().cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
        return ListView(
          children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context){
    final List<Widget> opciones = [];

    data.forEach((opt){
      final aux = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.arrow_right, color: Colors.blue,),
        onTap: (){
           Navigator.pushNamed(context, opt['ruta']);
        },
      );
      opciones..add(aux)
              ..add(Divider());
    });
    return opciones;
  }
}