import 'package:app_foryou/features/register/domain/entities/client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClientModel extends Client {
  ClientModel({
    required super.idCliente,
    required super.nombre,
    required super.usuario,
    required super.correo,
    required super.telefono,
    required super.domicilio,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientModelToJson(this);
}
