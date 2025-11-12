class SolicitudModel {
  final String idCliente;
  final String direccion;
  final String descripcion;
  final String tipoProyecto;
  final String materiales;
  final String diasDisponibles;
  final DateTime fechaCita;

  SolicitudModel({
    required this.idCliente,
    required this.direccion,
    required this.descripcion,
    required this.tipoProyecto,
    required this.materiales,
    required this.diasDisponibles,
    required this.fechaCita,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'direccion': direccion,
      'descripcion': descripcion,
      'tipo_proyecto': tipoProyecto,
      'materiales': materiales,
      'dias_disponibles': diasDisponibles,
      'fecha_cita': fechaCita.toIso8601String(),
    };
  }
}
