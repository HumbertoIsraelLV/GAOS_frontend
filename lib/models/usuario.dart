import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    String id;
    String nombre;
    String curp;
    String password;
    String role;
    bool   estado;

    UsuarioModel({
        this.id,
        this.nombre = '',
        this.curp = '',
        this.password = '',
        this.role = "WORKER_ROLE",
        this.estado = true
    });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
      id          : json['_id'],
      nombre      : json['nombre'],
      curp        : json['curp'],
      password    : json['password'],
      role        : json['role'],
      estado      : json['estado']
    );

    Map<String, dynamic> toJson() => {
        //"id"        : id,
        "nombre"    : nombre,
        "curp"      : curp,
        "password"  : password,
        "estado"    : estado,
        "role"      : role
    };
}
