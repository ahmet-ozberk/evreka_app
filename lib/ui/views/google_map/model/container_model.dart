// ignore_for_file: public_member_api_docs, sort_constructors_first

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ContainerModel {
/*
{
  "date": "2014-12-27 00:00:00.000Z",
  "percentage": "71",
  "temperature": "93",
  "location": "Instance of 'GeoPoint'",
  "containerId": "17122750114840926",
  "sensorId": "17122750114840871"
} 
*/

  String? date;
  String? percentage;
  String? temperature;
  double? latitude;
  double? longitude;
  String? containerId;
  String? sensorId;

  ContainerModel({
    this.date,
    this.percentage,
    this.temperature,
    this.latitude,
    this.longitude,
    this.containerId,
    this.sensorId,
  });
  ContainerModel.fromJson(Map<String, dynamic> json) {
    date = json['date']?.toString();
    percentage = json['percentage']?.toString();
    temperature = json['temperature']?.toString();
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    containerId = json['containerId']?.toString();
    sensorId = json['sensorId']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['percentage'] = percentage;
    data['temperature'] = temperature;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['containerId'] = containerId;
    data['sensorId'] = sensorId;
    return data;
  }

  ContainerModel copyWith({
    String? date,
    String? percentage,
    String? temperature,
    double? latitude,
    double? longitude,
    String? containerId,
    String? sensorId,
  }) {
    return ContainerModel(
      date: date ?? this.date,
      percentage: percentage ?? this.percentage,
      temperature: temperature ?? this.temperature,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      containerId: containerId ?? this.containerId,
      sensorId: sensorId ?? this.sensorId,
    );
  }

  @override
  String toString() {
    return 'ContainerModel(date: $date, percentage: $percentage, temperature: $temperature, latitude: $latitude, longitude: $longitude, containerId: $containerId, sensorId: $sensorId)';
  }
}
