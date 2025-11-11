import 'package:app_foryou/features/login/domain/entities/client.dart';

class ClientModel extends Client {
  final String? telefono;
  final String? domicilio;
  final String? passwordHash;

  const ClientModel({
    required String idCliente,
    required String nombre,
    String? usuario,
    String? correo,
    this.telefono,
    this.domicilio,
    this.passwordHash,
  }) : super(
          idCliente: idCliente,
          nombre: nombre,
          usuario: usuario,
          correo: correo,
        );

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      idCliente: json['id_cliente'],
      nombre: json['nombre'],
      usuario: json['usuario'],
      correo: json['correo'],
      telefono: json['telefono'],
      domicilio: json['domicilio'],
      passwordHash: json['password_hash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'nombre': nombre,
      'usuario': usuario,
      'correo': correo,
      'telefono': telefono,
      'domicilio': domicilio,
      'password_hash': passwordHash,
    };
  }
}
