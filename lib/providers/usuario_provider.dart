import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:gaos_front/models/usuario.dart';


class UsuarioProvider{
  
  final String _url = 'https://gaos_front.herokuapp.com';

  //LOGIN
  Future<UsuarioModel> login (String curp, String pass) async {
    final body = {
        'curp'              :curp,
        'password'          :pass
    };
    final url = '$_url/login';
    final resp = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      }, 
      body: body
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if(decodedResp.containsKey('usuario'))
      return UsuarioModel.fromJson(decodedResp['usuario']);
    else
      return null;  
  }

  //CARGAR USUARIOS
  Future<List<UsuarioModel>> cargarUsuarios() async {
    final url  = '$_url/usuario';

    final response = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(response.body);

    final List<UsuarioModel> usuarios = List();

    // print(decodedData['usuarios']);
    

    if(decodedData == null)
      return [];

    if(decodedData['error'] != null)
      return [];  

    decodedData['usuarios'].forEach((user){
      // print(user);
      final usuarioTemp = UsuarioModel.fromJson(user);

      // usuarioTemp.id = id;

      usuarios.add(usuarioTemp); 
    });
    return usuarios;
  }
  Future<bool> crearUsuario(UsuarioModel usuario) async {
    final url  = '$_url/usuario';
    final body = {
        'nombre'            :usuario.nombre,
        'curp'              :usuario.curp,
        'password'          :usuario.password,
        'role'              :usuario.role,
        'estado'            :usuario.estado.toString()
    };
    final resp = await http.post(Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      }, 
      // body: json.encode(body)
      body: body
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print( decodedResp);
    return true;
  }
  Future<bool> editarUsuario(UsuarioModel usuario) async {
    final body = {
        'id'                :usuario.id,
        'nombre'            :usuario.nombre,
        // 'curp'              :usuario.curp,
        'password'          :usuario.password,
        'role'              :usuario.role,
        'estado'            :usuario.estado.toString()
    };
    final resp = await http.put('$_url/usuario',
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
  Future<bool> borrarUsuario(String id, int mode) async {
    final resp = await http.delete('$_url/usuario?id=$id&mode=$mode');
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    // return decodedResp;
    return true;
  }
  // Future<Map<String, dynamic>> getUsuarios() async {
  //   final resp = await http.get('$_url/usuario');
  //   Map<String, dynamic> decodedResp = json.decode(resp.body);
  //   return decodedResp;
  // }
}