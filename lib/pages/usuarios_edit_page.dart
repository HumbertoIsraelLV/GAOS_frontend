import 'package:flutter/material.dart';

// import 'package:gaos_front/bloc/usuarios_bloc.dart';
// import 'package:gaos_front/bloc/provider.dart';
import 'package:gaos_front/models/usuario.dart';
import 'package:gaos_front/providers/usuario_provider.dart';
// import 'package:gaos_front/utils/utils.dart' as utils;
// import 'package:image_picker/image_picker.dart';


class UsuariosEditPage extends StatefulWidget {
  @override
  _UsuariosEditPageState createState() => _UsuariosEditPageState();
}

class _UsuariosEditPageState extends State<UsuariosEditPage> {

  final usuarioProvider = UsuarioProvider();
  final formKey = GlobalKey<FormState>();
  // final scaffKey = GlobalKey<ScaffoldState>();
  // UsuariosBloc usuariosBloc;

  bool _guardando = false;

  // File foto;

  UsuarioModel usuario = UsuarioModel();
  @override
  Widget build(BuildContext context) {

    // usuariosBloc = Provider.usuariosBloc(context);



    final UsuarioModel userData = ModalRoute.of(context).settings.arguments;

    if(userData!=null){
      usuario = userData;
    }


    return Scaffold(
      // key: scaffKey,
      appBar: AppBar(
        title: Text(('Usuarios')),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.photo_size_select_actual),
          //   onPressed: _seleccionarFoto,
          // ),
          // IconButton(
          //   icon: Icon(Icons.camera_alt),
          //   onPressed: _tomarFoto,
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                // _mostrarFoto(),
                _crearNombre(),
                _crearCurp(),
                _crearPassword(),
                // _crearPrecio(),
                _crearRole(),
                _crearEstado(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: usuario.nombre,
      decoration: InputDecoration(
        labelText: 'Nombre de usuario',
      ),
      onSaved: (value) => usuario.nombre=value,
      validator: (value)=>(value.length<3)?'Ingrese nombre de usuario':null,
    );
  }
  Widget _crearCurp(){
    return TextFormField(
      initialValue: usuario.curp,
      decoration: InputDecoration(
        labelText: 'CURP de usuario',
      ),
      // enableInteractiveSelection: false,
      // readOnly: true,
      enabled: (usuario.id!=null)?false:true,
      // onTap: null,
      // focusNode: FocusNode(canRequestFocus: false),
      onSaved: (value) => usuario.curp=value,
      validator: (value)=>(value.length<3)?'Ingrese CURP de usuario':null,
    );
  }
  Widget _crearPassword(){
    return TextFormField(
      initialValue: usuario.password,
      decoration: InputDecoration(
        labelText: 'Password de usuario',
      ),
      onSaved: (value) => usuario.password=value,
      validator: (value)=>(value.length<3)?'Ingrese password de usuario':null,
    );
  }
  Widget _crearRole(){
    return SwitchListTile(
      value: (usuario.role == 'ADMIN_ROLE')?true:false,
      title: Text('Rol de Administrador'),
      activeColor: Colors.blue,
      onChanged: (value) => setState((){

        if(value)
          usuario.role = 'ADMIN_ROLE';
        else
          usuario.role = 'WORKER_ROLE';
      }),
    );
  }

  Widget _crearEstado(){
    return SwitchListTile(
      value: usuario.estado,
      title: Text('Existencia en plantilla'),
      activeColor: Colors.blue,
      onChanged: (value) => setState((){
        usuario.estado = value;
      }),
    );
  }
  

  // Widget _crearPrecio(){
  //   return TextFormField(
  //     initialValue: producto.valor.toString(),
  //     keyboardType: TextInputType.numberWithOptions(decimal: true),
  //     decoration: InputDecoration(
  //       labelText: 'Precio',
  //     ),
  //     onSaved: (value) => producto.valor=double.parse(value),
  //     validator: (value)=> (utils.isNumeric(value))?null:'Ingresa un número',
  //   );
  // }
  // 

  Widget _crearBoton(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando)?null:_submit,
      color: Colors.blue,
      textColor: Colors.white,
      
    );
  }

  void _submit() async{
    if(!formKey.currentState.validate()) return;
    else{
      formKey.currentState.save();
      
      
      setState(() { _guardando = true; });

      // if(foto!= null){
      //   producto.fotoUrl = await productosBloc.subirFoto(foto);
      // }

      // final Map<String, dynamic> resp = new Map<String, dynamic>(); 
      if(usuario.id==null)
        await usuarioProvider.crearUsuario(usuario);
      else
        await usuarioProvider.editarUsuario(usuario);

      setState(() { _guardando = false; });
      // mostrarSnackBar('Registro guardado'); 
      Navigator.pop(context);  
    }
  }
  // void mostrarSnackBar(String msg){
  //   final snack = SnackBar(
  //     content: Text(msg),
  //     duration: Duration(milliseconds: 1500),
  //   );
  //   scaffKey.currentState.showSnackBar(snack);
  // }
  // Widget _mostrarFoto(){
  //   if(producto.fotoUrl!=null)
  //     return FadeInImage(
  //       image: NetworkImage(producto.fotoUrl),
  //       placeholder: AssetImage('assets/loading.gif'),
  //       height: 300,
  //       fit: BoxFit.cover,
  //     );  
  //   else{
  //     return Image(
  //       image: (foto==null)? AssetImage('assets/no-image.png'): FileImage(foto),
  //       height: 300,
  //       fit: BoxFit.cover,
  //     );
  //   }
  // }
//   _seleccionarFoto() async {
//     _procesarImagen(ImageSource.gallery);
    
//   }
//    _tomarFoto() async{
//     _procesarImagen(ImageSource.camera);
//   }
//   _procesarImagen(ImageSource tipo) async{
//     foto = await ImagePicker.pickImage(source: tipo);

//     if(foto!=null){
//       producto.fotoUrl=null;
//     }
//     setState((){});
//   }
}