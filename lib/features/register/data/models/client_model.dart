import 'package:app_foryou/features/register/domain/entities/client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClientModel extends Client {
  ClientModel({
    required String idCliente,
    required String nombre,
    required String usuario,
    required String correo,
    required String telefono,
    required String domicilio,
  }) : super(
          idCliente: idCliente,
          nombre: nombre,
          usuario: usuario,
          correo: correo,
          telefono: telefono,
          domicilio: domicilio,
        );

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);
}
