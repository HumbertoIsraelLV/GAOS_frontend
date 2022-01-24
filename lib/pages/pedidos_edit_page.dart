import 'package:flutter/material.dart';
// import 'package:intl/intl.Dart' as intl;

// intl.DateFormat




import 'package:gaos_front/models/pedido.dart';

import 'package:gaos_front/providers/pedido_provider.dart';

// import 'package:gaos_front/models/usuario.dart';
// import 'package:gaos_front/providers/usuario_provider.dart';
import 'package:gaos_front/utils/utils.dart' as utils;

class PedidosEditPage extends StatefulWidget {
  @override
  _PedidosEditPageState createState() => _PedidosEditPageState();
}

class _PedidosEditPageState extends State<PedidosEditPage> {
  // final fecha = ae.DateFormat('yyyy-MM-dd').format('fdfdfd');
  final pedidoProvider = PedidoProvider();
  final formKey = GlobalKey<FormState>();
  // String _fecha=intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _fecha = '';
  TextEditingController _inputTextController = TextEditingController();

  bool _guardando = false;
  PedidoModel pedido = PedidoModel();
  @override
  Widget build(BuildContext context) {

    final PedidoModel pedData = ModalRoute.of(context).settings.arguments;

    if(pedData!=null){
      pedido = pedData;
      // _fecha = intl.DateFormat('yyyy-MM-dd').format(pedido.fechaPedido);
      _fecha='';
    }

    return Scaffold(
      // key: scaffKey,
      appBar: AppBar(
        title: Text(('Pedidos')),
        actions: <Widget>[
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
                _crearNombreCliente(),
                _crearDescripcion(),
                _crearPrecioTotal(),
                Container(
                  height: 20,
                ),
                _crearFecha(),
                _crearEstado(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombreCliente(){
    return TextFormField(
      initialValue: pedido.nombreCliente,
      decoration: InputDecoration(
        labelText: 'Nombre de cliente',
      ),
      onSaved: (value) => pedido.nombreCliente=value,
      validator: (value)=>(value.length<3)?'Ingrese nombre de cliente':null,
    );
  }
  Widget _crearDescripcion(){
    return TextFormField(
      minLines: 4,
      maxLines: 4,
      initialValue: pedido.descripcion,
      decoration: InputDecoration(
        labelText: 'Descripción del pedido',
      ),
      onSaved: (value) => pedido.descripcion=value,
      validator: (value)=>(value.length<3)?'Ingrese descripción de pedido':null,
    );
  }
  Widget _crearPrecioTotal(){
    return TextFormField(
      // initialValue: pedido.precioTotal.toString(),
      initialValue: (pedido.id==null)?'':pedido.precioTotal.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => pedido.precioTotal=double.parse(value),
      validator: (value)=> (utils.isNumeric(value))?null:'Ingresa un número',
    );
  }

  //////////////////////////////////////////////
  Widget _crearFecha(){
    return TextFormField(
      controller: _inputTextController,
      enableInteractiveSelection: false,
      decoration: InputDecoration( 
        // hintText: 'Ingresa tu nac',
        labelText: 'Fecha de pedido:',
        icon: Icon(Icons.calendar_today),
        suffixIcon: Icon(Icons.arrow_upward),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      ),
      initialValue: _fecha,
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
      onSaved: (value) => pedido.fechaPedido=DateTime.parse(_fecha),
    );
  }
  //TODO: Arreglar fecha
  _selectDate(BuildContext context) async{
    DateTime picked = await showDatePicker(
      locale: Locale('es', 'ES'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
    );
    if(picked!=null){
      setState(() {
        // _fecha=intl.DateFormat('yyyy-MM-dd').format(picked);
        _fecha = '';
        // pedido.fechaPedido=picked;
        _inputTextController.text =_fecha;
      });  
    }
  }
  /////////////////////////////////////////////////
  
  
  

  Widget _crearEstado(){
    return SwitchListTile(
      value: pedido.terminado,
      title: Text('¿Terminado?'),
      activeColor: Colors.blue,
      onChanged: (value) => setState((){
        pedido.terminado = value;
      }),
    );
  }
  

  

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
      print((pedido.id==null)?'hola':'fdf'); 
      if(pedido.id==null)
        await pedidoProvider.crearPedido(pedido);
      else
        await pedidoProvider.editarPedido(pedido);

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