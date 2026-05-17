class BookingModel {
  final int id;

  final String serviceType;

  final String status;

  BookingModel({
    required this.id,
    required this.serviceType,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json["id"],
      serviceType: json["service_type"],
      status: json["status"],
    );
  }
}
