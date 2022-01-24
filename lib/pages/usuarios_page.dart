import 'package:flutter/material.dart';

import 'dart:async';
// import 'package:gaos_front/bloc/usuarios_bloc.dart';
// import 'package:gaos_front/bloc/provider.dart';
import 'package:gaos_front/models/usuario.dart';


import 'package:gaos_front/providers/usuario_provider.dart';


// import 'dart:async';
// import 'package:rxdart/rxdart.dart';

class UsuariosPage extends StatefulWidget {

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  UsuarioProvider usuarioProvider = UsuarioProvider();

  bool verInactivos = false;

  @override
  Widget build(BuildContext context) {
    // final usuariosBloc = Provider.usuariosBloc(context);
    // usuariosBloc.cargarUsuarios();


    return Scaffold(
      appBar: AppBar(
        title: Text('Personal de gaos_front'),
      ),
      body: RefreshIndicator(
        child: _crearListado(context),
        onRefresh: ()=>Future.delayed(Duration(seconds: 1)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _crearBotonVer(context),
           _crearBotonNuevo(context)],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }

  Widget _crearListado(BuildContext context){
    return FutureBuilder(
      future: usuarioProvider.cargarUsuarios(),
      builder: (BuildContext context, AsyncSnapshot<List<UsuarioModel>> snapshot){
        if(snapshot.hasData){
          final usuarios = snapshot.data;
          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, i) => _crearItem(usuarios[i], context),
          );
        }else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  Widget _crearBotonNuevo(BuildContext context){
    return FloatingActionButton(
      heroTag: 1,
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
      onPressed: () => Navigator.pushNamed(context, 'usuarios_edit'),
    );
  }
  Widget _crearBotonVer(BuildContext context){
    return FloatingActionButton(
      heroTag: 2,
      child: Icon(Icons.remove_red_eye),
      backgroundColor: (verInactivos)?Colors.red:Colors.blue,
      onPressed: () => 
        setState((){
          if(verInactivos)
            verInactivos=false;
          else
            verInactivos=true;
        })
      ,
    );
  }

  Widget _crearItem(UsuarioModel user, BuildContext context){
    final item =  Dismissible(
      key: UniqueKey(),
      background: Container(

        color: Colors.red
      ),
      onDismissed: (direccion){
        if(user.estado==false)
          usuarioProvider.borrarUsuario(user.id, 2);
        else 
          usuarioProvider.borrarUsuario(user.id, 1);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            // (prod.fotoUrl==null)
            // ?Image(image: AssetImage('assets/no-image.png'),)
            // :FadeInImage(
            //   image: NetworkImage(prod.fotoUrl),
            //   placeholder: AssetImage('assets/loading.gif'),
            //   height: 300,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),
            ListTile(
              title: Text('${user.nombre} - ${user.curp}'),
              subtitle: Text('${user.role} - ${(user.estado)?'Existente en plantilla':'Fuera de plantilla'}'),
              onTap: ()=>Navigator.of(context).pushNamed('usuarios_edit', arguments: user),
            ),
          ],
        ),
      ),
    );
    return Visibility(
      child: item,
      visible: (user.estado||verInactivos)?true:false
    );
  } 
}