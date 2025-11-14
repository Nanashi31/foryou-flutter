import 'package:app_foryou/features/login/domain/entities/client.dart';

class ClientModel extends Client {
  final String? telefono;
  final String? domicilio;
  final String? passwordHash;

  const ClientModel({
    required super.idCliente,
    required super.nombre,
    super.usuario,
    super.correo,
    this.telefono,
    this.domicilio,
    this.passwordHash,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      idCliente: json['id_cliente'] ?? '',
      nombre: json['nombre'] ?? '',
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
