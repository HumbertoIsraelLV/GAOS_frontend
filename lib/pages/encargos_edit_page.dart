import 'package:flutter/material.dart';


import 'package:gaos_front/models/encargo.dart';
import 'package:gaos_front/providers/encargo_provider.dart';
// import 'package:gaos_front/utils/utils.dart' as utils;
// import 'package:gaos_front/models/pedido.dart';

// import 'package:gaos_front/providers/pedido_provider.dart';

// import 'package:gaos_front/models/usuario.dart';
// import 'package:gaos_front/providers/usuario_provider.dart';

class EncargosEditPage extends StatefulWidget {
  @override
  _EncargosEditPageState createState() => _EncargosEditPageState();
}
class _EncargosEditPageState extends State<EncargosEditPage> {
  final encargoProvider = EncargoProvider();
  final formKey = GlobalKey<FormState>();

  bool _guardando = false;
  EncargoModel encargo = EncargoModel();

  String _userValue;
  String _pedidoValue;

  List<Map<String, dynamic>> listaDePedidos = [];
  List<Map<String, dynamic>> listaDeUsuarios = [];

  @override
  void initState() {
    super.initState();
    crearDatosDropDown();
  }
  Future<bool> crearDatosDropDown()async{
    final coleccion = await encargoProvider.cargarEncargos(2);
    // print(coleccion);
    if(coleccion['encargos']['usuarios']==null||coleccion['encargos']['pedidos']==null)
      return false;
    final usuarios = coleccion['encargos']['usuarios'];
    final pedidos = coleccion['encargos']['pedidos'];
    setState(() {
      usuarios.forEach((us){
        listaDeUsuarios.add(us);
      });
      pedidos.forEach((ped){
        listaDePedidos.add(ped);
      });
    });
    return true;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // key: scaffKey,
      appBar: AppBar(
        title: Text(('Encargos')),
        actions: <Widget>[
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // alignment: AlignmentGeometry.lerp(a, b, t),
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(),
                _crearDropDownUsuarios(),
                _crearDropDownPedidos(),
                // _crearListado(context),
                // _mostrarFoto(),
                // _crearNombreCliente(),
                // _crearDescripcion(),
                // _crearPrecioTotal(),
                // _crearEstado(),
                Divider(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _crearNombreCliente(){
  //   return TextFormField(
  //     initialValue: pedido.nombreCliente,
  //     decoration: InputDecoration(
  //       labelText: 'Nombre de cliente',
  //     ),
  //     onSaved: (value) => pedido.nombreCliente=value,
  //     validator: (value)=>(value.length<3)?'Ingrese nombre de cliente':null,
  //   );
  // }
  // Widget _crearDescripcion(){
  //   return TextFormField(
  //     minLines: 4,
  //     maxLines: 4,
  //     initialValue: pedido.descripcion,
  //     decoration: InputDecoration(
  //       labelText: 'Descripción del pedido',
  //     ),
  //     onSaved: (value) => pedido.descripcion=value,
  //     validator: (value)=>(value.length<3)?'Ingrese descripción de pedido':null,
  //   );
  // }
  // Widget _crearPrecioTotal(){
  //   return TextFormField(
  //     // initialValue: pedido.precioTotal.toString(),
  //     initialValue: (pedido.id==null)?'':pedido.precioTotal.toString(),
  //     keyboardType: TextInputType.numberWithOptions(decimal: true),
  //     decoration: InputDecoration(
  //       labelText: 'Precio',
  //     ),
  //     onSaved: (value) => pedido.precioTotal=double.parse(value),
  //     validator: (value)=> (utils.isNumeric(value))?null:'Ingresa un número',
  //   );
  // }
  
  
  

  // Widget _crearEstado(){
  //   return SwitchListTile(
  //     value: pedido.terminado,
  //     title: Text('¿Terminado?'),
  //     activeColor: Colors.blue,
  //     onChanged: (value) => setState((){
  //       pedido.terminado = value;
  //     }),
  //   );
  // }
  

  

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
      // print((pedido.id==null)?'hola':'fdf'); 
      // if(pedido.id==null)
      //   await pedidoProvider.crearPedido(pedido);
      // else
      //   await pedidoProvider.editarPedido(pedido);
      print('$_userValue   $_pedidoValue');
      encargoProvider.crearEncargo(_userValue, _pedidoValue);
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
  List<DropdownMenuItem> _getOpcionesDropDownUsuarios(){
    List<DropdownMenuItem> lista = List();
    listaDeUsuarios.forEach((us){
      // print(us['_id']);
      lista.add(DropdownMenuItem(
        child: Text(us['nombre']),
        value: us['_id'],
      ));
    });
    return lista;
  } 
  Widget _crearDropDownUsuarios(){
    return DropdownButton(
      icon: Icon(Icons.people_outline),
      isExpanded: true,
      itemHeight: null,
      hint: Text('Usuario a encargar pedido'),
      value: _userValue,
      elevation: 24,
      items: _getOpcionesDropDownUsuarios(),
      onChanged: (opt){
        setState(() {
          _userValue=opt;
        });
      },
    );
  }

  List<DropdownMenuItem> _getOpcionesDropDownPedidos(){
    List<DropdownMenuItem> lista = List();
    listaDePedidos.forEach((us){
      // print(us['_id']);
      lista.add(DropdownMenuItem(
        child: Text('${us['nombreCliente']} ${us['precioTotal']}'),
        value: us['_id'],
      ));
    });
    return lista;
  } 
  Widget _crearDropDownPedidos(){
    return DropdownButton(
      icon: Icon(Icons.assignment),
      isExpanded: true,
      itemHeight: null,
      hint: Text('Pedido a ser encargado'),
      value: _pedidoValue,
      elevation: 24,
      items: _getOpcionesDropDownPedidos(),
      onChanged: (opt){
        setState(() {
          _pedidoValue=opt;
        });
      },
    );
  }
}