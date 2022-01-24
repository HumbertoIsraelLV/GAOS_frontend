import 'dart:convert';

PedidoModel pedidoModelFromJson(String str) => PedidoModel.fromJson(json.decode(str));

String pedidoModelToJson(PedidoModel data) => json.encode(data.toJson());

// Intl.defaultLocale = 'pt_BR';

class PedidoModel {
    String    id;
    String    nombreCliente;
    String    descripcion;
    double    precioTotal;
    bool      terminado;
    // String    usuario;
    DateTime  fechaPedido;

    PedidoModel({
        this.id,
        this.nombreCliente = '',
        this.descripcion = '',
        this.precioTotal = 0,
        this.terminado = false,
        // this.usuario = ''
        this.fechaPedido
        // .fo DateTime.now()
    });

    factory PedidoModel.fromJson(Map<String, dynamic> json) => PedidoModel(
      id                : json['_id'],
      nombreCliente     : json['nombreCliente'],
      descripcion       : json['descripcion'],
      precioTotal       : json['precioTotal']/1,
      terminado         : json['terminado'],
      fechaPedido       : DateTime.parse(json['fechaPedido'])
      // usuario           : json['usuario']['nombre']
    );

    Map<String, dynamic> toJson() => {
        //"id"        : id,
        "nombreCliente"   : nombreCliente,
        "descripcion"     : descripcion,
        "precioTotal"     : precioTotal,
        "terminado"       : terminado,
        "fechaPedido"     : fechaPedido
        // "usuario"         : usuario
    };
}
