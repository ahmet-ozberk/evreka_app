// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateLocationModel {
  final String containerId;
  final double latitude;
  final double longitude;
  UpdateLocationModel({
    required this.containerId,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() =>
      'UpdateLocationModel(containerId: $containerId, latitude: $latitude, longitude: $longitude)';
}
