import 'package:app_foryou/features/register/domain/entities/client.dart';

abstract class ClientRepository {
  Future<Client> registerClient(RegisterParams params);
}

class RegisterParams {
  final String nombre;
  final String usuario;
  final String email;
  final String password;
  final String telefono;
  final String domicilio;

  RegisterParams({
    required this.nombre,
    required this.usuario,
    required this.email,
    required this.password,
    required this.telefono,
    required this.domicilio,
  });
}
