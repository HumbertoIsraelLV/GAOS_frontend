import 'package:gaos_front/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferencias  {
  static final Preferencias _instancia  = Preferencias._internal();
  factory Preferencias(){
    return _instancia;
  }
  Preferencias._internal();
  SharedPreferences _prefs;
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }
  /////USUARIO
  get activeUser{
    final usuario = UsuarioModel();
    usuario.id      =_prefs.getString('id');
    usuario.curp    =_prefs.getString('curp');
    usuario.nombre  =_prefs.getString('nombre');
    usuario.role    =_prefs.getString('role');
    usuario.estado  =_prefs.getBool('estado');
    return (_prefs.getBool('estado'))?usuario:null;
  }

  set activeUser(UsuarioModel usuario){
    _prefs.setString('id', usuario.id);
    _prefs.setString('curp', usuario.curp);
    _prefs.setString('nombre', usuario.nombre);
    _prefs.setString('role', usuario.role);
    _prefs.setBool('estado', usuario.estado);
  }
}