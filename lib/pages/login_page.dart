import 'package:flutter/material.dart';

import 'package:gaos_front/providers/usuario_provider.dart';
import 'package:gaos_front/preferences/preferences.dart';
import 'package:gaos_front/utils/utils.dart' as utils;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioProvider = UsuarioProvider();
  final _prefs = Preferencias();

  final formKey = GlobalKey<FormState>();

  bool _guardando = false;
  String curp = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height*.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1),
          ]
        ),
      ),
    );
    return Stack(
      children: <Widget>[
        fondoMorado,
        Container(
          padding: EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              Text('gaos_front', style: TextStyle(color: Colors.white, fontSize: 25),),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context){
    // final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height*.3,
            ),
          ),
          Container(
            width: size.width*.8,
            padding: EdgeInsets.symmetric(vertical: 50),
            margin: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0, 5),
                  spreadRadius: 3
                ),
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Text('Ingreso', style: TextStyle(fontSize: 20),),
                  SizedBox(height: size.height*.025 ,),
                  _crearCurp(),
                  SizedBox(height: size.height*.025 ,),
                  _crearPassword(),
                  SizedBox(height: size.height*.025,),
                  _crearBoton(context),
                ],
              ),
            )
          ),
          SizedBox(height: size.height*.1,)
        ],
      ),
    );
  }

  Widget _crearCurp(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
          hintText: 'Ingresa tu CURP',
          labelText: 'CURP:',
        ),
        onSaved: (value) => curp=value,
        // validator: (value)=> (utils.isNumeric(value))?null:'Ingresa un CURP',
        validator: null,
      ),
    );
  }

  Widget _crearPassword(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.deepPurple,),
          hintText: 'Ingresa tu contraseña',
          labelText: 'Contraseña:',
        ),
        onSaved: (value) => pass=value,
        // validator: (value)=> (utils.isNumeric(value))?null:'Ingresa un CURP',
        validator: null,
      ),
    );    
  }

  Widget _crearBoton(BuildContext context){
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      // onPressed: snapshot.hasData?()=>_login(bloc, context):null,
      onPressed: (_guardando)?null:_submit,
    );
  }

  void _submit() async{
    if(!formKey.currentState.validate()) return;
    else{
      formKey.currentState.save();
      setState(() { _guardando = true; });

      final resp = await usuarioProvider.login(curp, pass); 
      if(resp==null)
        utils.mostrarAlerta(context, 'Error al ingresar', 'Credenciales invalidas');
      else{
        _prefs.activeUser = resp;
        Navigator.pushNamed(context, 'home');
      }
      setState(() { _guardando = false; });
    }
  }
}