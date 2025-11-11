import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int idCliente;
  final String nombre;
  final String? usuario;
  final String? correo;

  const Client({
    required this.idCliente,
    required this.nombre,
    this.usuario,
    this.correo,
  });

  @override
  List<Object?> get props => [idCliente, nombre, usuario, correo];
}
