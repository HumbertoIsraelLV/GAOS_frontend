import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gaos_front/models/encargo.dart';
import 'package:gaos_front/providers/encargo_provider.dart';

// import 'package:gxaos/models/pedido.dart';
// import 'package:gaos_front/providers/pedido_provider.dart';

class EncargosPage extends StatefulWidget {
  @override
  _EncargosPageState createState() => _EncargosPageState();
}
class _EncargosPageState extends State<EncargosPage> {
  EncargoProvider encargoProvider = EncargoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encargos en gaos_front'),
      ),
      body: RefreshIndicator(
        child: _crearListado(context),
        onRefresh: ()=>Future.delayed(Duration(seconds: 1)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // _crearBotonVer(context),
           _crearBotonNuevo(context)],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }

  Widget _crearListado(BuildContext context){
    return FutureBuilder(
      future: encargoProvider.cargarEncargos(1),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasData){
          final encargos = snapshot.data;
          return ListView.builder(
            itemCount: encargos.length,
            itemBuilder: (context, i) => _crearItem(encargos[i], context),
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
      onPressed: () => Navigator.pushNamed(context, 'encargos_edit'),
    );
  }
  // Widget _crearBotonVer(BuildContext context){
  //   return FloatingActionButton(
  //     heroTag: 2,
  //     child: Icon(Icons.remove_red_eye),
  //     backgroundColor: (verInactivos)?Colors.red:Colors.blue,
  //     onPressed: () => 
  //       setState((){
  //         if(verInactivos)
  //           verInactivos=false;
  //         else
  //           verInactivos=true;
  //       })
  //     ,
  //   );
  // }

  Widget _crearItem(EncargoModel enc, BuildContext context){
    final item =  Dismissible(
      key: UniqueKey(),
      background: Container(

        color: Colors.red
      ),
      onDismissed: (direccion){
        // if(ped.estado==false)
          encargoProvider.borrarEncargo(enc.id, 1);
        // else 
        //   usuarioProvider.borrarUsuario(user.id, 1);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${enc.usuario} - ${enc.pedido}'),
              // subtitle: Text('${ped.usuario} - ${(ped.terminado)?'Pedido terminado':'Pendiente de terminar'}'),
              // onTap: ()=>Navigator.of(context).pushNamed('pedidos_edit', arguments: ped),
              onTap: (){},
            ),
          ],
        ),
      ),
    );
    return Visibility(
      child: item,
      // visible: (user.estado||verInactivos)?true:false
    );
  } 
}