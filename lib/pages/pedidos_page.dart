import 'package:flutter/material.dart';
import 'package:gaos_front/models/pedido.dart';
import 'package:gaos_front/preferences/preferences.dart';

import 'dart:async';
import 'package:gaos_front/providers/pedido_provider.dart';

class PedidosPage extends StatefulWidget {

  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  PedidoProvider pedidoProvider = PedidoProvider();
  final prefs = Preferencias();
  // bool verInactivos = false;
  @override
  Widget build(BuildContext context) {
    // final usuariosBloc = Provider.usuariosBloc(context);
    // usuariosBloc.cargarUsuarios();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos de gaos_front'),
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
      future: pedidoProvider.cargarPedidos(),
      builder: (BuildContext context, AsyncSnapshot<List<PedidoModel>> snapshot){
        if(snapshot.hasData){
          final pedidos = snapshot.data;
          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, i) => _crearItem(pedidos[i], context),
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
      onPressed: () => Navigator.pushNamed(context, 'pedidos_edit'),
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

  Widget _crearItem(PedidoModel ped, BuildContext context){
    final item =  Dismissible(
      key: UniqueKey(),
      background: Container(

        color: Colors.red
      ),
      onDismissed: (direccion){
        if(ped.terminado){
          if((prefs.activeUser).role=='ADMIN_ROLE')
            pedidoProvider.borrarPedido(ped.id, 2);
          else{
            ped.terminado=false;
            pedidoProvider.editarPedido(ped);
          }
        }else{
          pedidoProvider.borrarPedido(ped.id, 1);
        }
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${ped.nombreCliente} - ${ped.precioTotal}'),
              subtitle: Text('${0} - ${(ped.terminado)?'Pedido terminado':'Pendiente de terminar'}'),
              //TODO: Agregar fecha de pedido
              onTap: ()=>Navigator.of(context).pushNamed('pedidos_edit', arguments: ped),
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