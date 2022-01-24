import 'dart:convert';

EncargoModel encargoModelFromJson(String str) => EncargoModel.fromJson(json.decode(str));

String encargoModelToJson(EncargoModel data) => json.encode(data.toJson());

class EncargoModel {
    String id;
    var usuario;
    dynamic pedido;

    EncargoModel({
        this.id,
        this.usuario,
        this.pedido
    });

    factory EncargoModel.fromJson(Map<String, dynamic> json) => EncargoModel(
      id                : json['_id'],
      usuario           : json['usuario']['nombre'],
      pedido            : json['pedido']['_id']
    );

    Map<String, dynamic> toJson() => {
        //"id"        : id,
        "usuario"         : usuario,
        "pedido"          : pedido
    };
}
