import 'dart:convert';
import 'package:gaos_front/models/pedido.dart';
import 'package:gaos_front/preferences/preferences.dart';
import 'package:http/http.dart' as http;



class PedidoProvider{
  final prefs = Preferencias();
  final String _url = 'https://gaos_front.herokuapp.com';

  //CARGAR PEDIDOS
  Future<List<PedidoModel>> cargarPedidos() async {
    final url  = '$_url/pedido';
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<PedidoModel> pedidos = List();
    // print(decodedData);
    // print(decodedData['pedidos']);
    if(decodedData == null)
      return [];
    if(decodedData['error'] != null)
      return [];  
    decodedData['pedidos'].forEach((pedido){
      final pedidoTemp = PedidoModel.fromJson(pedido);
      pedidos.add(pedidoTemp); 
    });
    return pedidos;
  }

  Future<bool> crearPedido(PedidoModel pedido) async {
    final url  = '$_url/pedido';
    final body = {
        'nombreCliente'       :pedido.nombreCliente,
        'precioTotal'         :pedido.precioTotal.toString(),
        'descripcion'         :pedido.descripcion,
        'terminado'           :pedido.terminado.toString(),
        'usuario'             :(prefs.activeUser).id
    };
    final resp = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      }, 
      body: body
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print( decodedResp);
    return true;
  }
  Future<bool> editarPedido(PedidoModel pedido) async {
    final body = {
        'id'                  :pedido.id,
        'nombreCliente'       :pedido.nombreCliente,
        'precioTotal'         :pedido.precioTotal.toString(),
        'descripcion'         :pedido.descripcion,
        'terminado'           :pedido.terminado.toString(),
        // 'usuario'             :pedido.
    };
    final resp = await http.put('$_url/pedido',
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      }, 
      body: body
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    // return decodedResp;
    return true;
  }
  Future<bool> borrarPedido(String id, int mode) async {
    final resp = await http.delete('$_url/pedido?id=$id&mode=$mode');
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    // return decodedResp;
    return true;
  }
}