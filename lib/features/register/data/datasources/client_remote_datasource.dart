import 'package:app_foryou/features/register/data/models/client_model.dart';
import 'package:app_foryou/features/register/domain/repositories/client_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstracción del origen de datos remoto para el registro de clientes.
abstract class ClientRemoteDataSource {
  /// Registra un nuevo cliente en el sistema.
  ///
  /// Primero, crea el usuario en Supabase Auth.
  /// Luego, guarda la información del perfil en la tabla 'clientes'.
  Future<ClientModel> registerClient(RegisterParams params);
}

/// Implementación del origen de datos para el registro usando Supabase.
class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  // Usamos la instancia global del cliente de Supabase.
  final _supabase = Supabase.instance.client;

  @override
  Future<ClientModel> registerClient(RegisterParams params) async {
    try {
      // 1. Registrar el usuario en Supabase Auth con verificación de correo.
      //
      // Al llamar a `signUp`, Supabase automáticamente:
      // - Crea un nuevo usuario en la tabla `auth.users`.
      // - Genera un token de confirmación único.
      // - Envía un correo electrónico a la dirección proporcionada con un
      //   enlace que contiene dicho token.
      //
      // El usuario no podrá iniciar sesión hasta que haga clic en ese enlace
      // y verifique su cuenta.
      final authResponse = await _supabase.auth.signUp(
        email: params.email,
        password: params.password,
        // No es necesario `emailRedirectTo` para la verificación estándar.
        // Supabase gestiona la redirección a la URL de tu sitio configurada
        // en el panel de control del proyecto.
      );

      // Si el registro en Auth fue exitoso y tenemos un usuario, procedemos.
      if (authResponse.user == null) {
        // Esto es poco probable si no hubo excepción, pero es una buena práctica verificar.
        throw Exception('Fallo en el registro: el usuario no fue creado en el sistema de autenticación.');
      }

      // El registro fue exitoso, pero el usuario aún necesita verificar su correo.
      // La sesión (`authResponse.session`) será `null` en este punto.

      final userId = authResponse.user!.id;

      // 2. Insertar los datos del perfil en la tabla 'clientes'.
      // Esta tabla debe tener una política de RLS que permita a los usuarios recién creados
      // insertar su propio perfil.
      final response = await _supabase.from('clientes').insert({
        'id_cliente': userId, // Vinculado al id del usuario en 'auth.users'.
        'nombre': params.nombre,
        'usuario': params.usuario,
        'correo': params.email,
        'telefono': params.telefono,
        'domicilio': params.domicilio,
      }).select(); // .select() devuelve el registro recién creado.

      // Si la inserción fue exitosa, 'response' contendrá una lista con el nuevo cliente.
  // Normalizamos la respuesta a una lista de mapas para trabajar con ella.
  final rows = List<Map<String, dynamic>>.from(response);
  if (rows.isEmpty) {
    // Si la inserción no devolvió datos, lo más probable es que la política
    // de RLS (Row Level Security) de la tabla 'clientes' impida la
    // inserción cuando la petición no está autenticada como el nuevo
    // usuario. Tras `signUp` la sesión suele ser `null` hasta que el
    // usuario verifique su email, por lo que la inserción desde el
    // cliente puede fallar.
    throw Exception(
    'Fallo en el registro: no se pudo guardar el perfil del usuario. Posible causa: políticas RLS que bloquean inserciones sin sesión (el usuario aún no ha verificado el email). Recomendado: crear un trigger en la base de datos que inserte el perfil al crearse el usuario en auth.users, o realizar el guardado desde un backend seguro con la service_role key.');
  }

  // Si recibimos datos, convertimos el resultado a nuestro modelo y lo devolvemos.
  return ClientModel.fromJson(rows.first);

    } on AuthException catch (e) {
      // Capturamos errores específicos de la autenticación (ej: email ya en uso).
      throw Exception('Error de registro: ${e.message}');
    } catch (e) {
      // Capturamos cualquier otro error.
      throw Exception('Ocurrió un error inesperado durante el registro: ${e.toString()}');
    }
  }
}
