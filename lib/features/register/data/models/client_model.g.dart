// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) => ClientModel(
  idCliente: json['id_cliente'] as String,
  nombre: json['nombre'] as String,
  usuario: json['usuario'] as String,
  correo: json['correo'] as String,
  telefono: json['telefono'] as String,
  domicilio: json['domicilio'] as String,
);

Map<String, dynamic> _$ClientModelToJson(ClientModel instance) =>
    <String, dynamic>{
      'id_cliente': instance.idCliente,
      'nombre': instance.nombre,
      'usuario': instance.usuario,
      'correo': instance.correo,
      'telefono': instance.telefono,
      'domicilio': instance.domicilio,
    };
