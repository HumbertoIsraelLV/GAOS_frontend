import 'dart:convert';
// import 'package:gaos_front/models/pedido.dart';
// import 'package:gaos_front/preferences/preferences.dart';
import 'package:gaos_front/models/encargo.dart';
import 'package:http/http.dart' as http;

class EncargoProvider{
  // final prefs = Preferencias();
  final String _url = 'https://gaos_front.herokuapp.com';

  //CARGAR PEDIDOS
  Future<dynamic> cargarEncargos(int mode) async {
    final url  = '$_url/encargo?mode=$mode';
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<EncargoModel> encargos = List();
    // print(decodedData);
    // print(decodedData['pedidos']);
    if(mode==1){
      if(decodedData == null)
        return [];
      if(decodedData['error'] != null)
        return [];  
      decodedData['encargos'].forEach((encargo){
        final encargoTemp = EncargoModel.fromJson(encargo);
        encargos.add(encargoTemp); 
      });
    }
    if(mode==2){
      return decodedData;
    }
    
    return encargos;
  }

  Future<bool> crearEncargo(String user, String pedido) async {
    final url  = '$_url/encargo';
    final body = {
        'usuario'             :user,
        'pedido'              :pedido,
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
//   Future<bool> editarPedido(PedidoModel pedido) async {
//     final body = {
//         'id'                  :pedido.id,
//         'nombreCliente'       :pedido.nombreCliente,
//         'precioTotal'         :pedido.precioTotal.toString(),
//         'descripcion'         :pedido.descripcion,
//         'terminado'           :pedido.terminado.toString(),
//         // 'usuario'             :pedido.
//     };
//     final resp = await http.put('$_url/pedido',
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded"
//       }, 
//       body: body
//     );
//     Map<String, dynamic> decodedResp = json.decode(resp.body);
//     print(decodedResp);
//     // return decodedResp;
//     return true;
//   }
  Future<bool> borrarEncargo(String id, int mode) async {
    final resp = await http.delete('$_url/encargo?id=$id&mode=$mode');
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    // return decodedResp;
    return true;
  }
}