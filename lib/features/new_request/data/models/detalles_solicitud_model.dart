class DetallesSolicitudModel {
  final int idSolicitud;
  final double? medAlt;
  final double? medAnc;

  DetallesSolicitudModel({
    required this.idSolicitud,
    this.medAlt,
    this.medAnc,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_solicitud': idSolicitud,
      'med_alt': medAlt,
      'med_anc': medAnc,
    };
  }
}
