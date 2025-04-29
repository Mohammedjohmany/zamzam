import 'dart:convert';

class LocationModel {
   

    final String? name;
    final String? address;
    final String? city;
    final String? postalCode;
    final int? latitude;
    final int? longitude;
    final bool? isDefault;
    final int? id;
    final int? userId;
    final DateTime? createdAt;
  LocationModel({
    this.name,
    this.address,
    this.city,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.id,
    this.userId,
    this.createdAt,
  });

   

  LocationModel copyWith({
    String? name,
    String? address,
    String? city,
    String? postalCode,
    int? latitude,
    int? longitude,
    bool? isDefault,
    int? id,
    int? userId,
    DateTime? createdAt,
  }) {
    return LocationModel(
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(address != null){
      result.addAll({'address': address});
    }
    if(city != null){
      result.addAll({'city': city});
    }
    if(postalCode != null){
      result.addAll({'postalCode': postalCode});
    }
    if(latitude != null){
      result.addAll({'latitude': latitude});
    }
    if(longitude != null){
      result.addAll({'longitude': longitude});
    }
    if(isDefault != null){
      result.addAll({'isDefault': isDefault});
    }
    if(id != null){
      result.addAll({'id': id});
    }
    if(userId != null){
      result.addAll({'userId': userId});
    }
    if(createdAt != null){
      result.addAll({'createdAt': createdAt!.millisecondsSinceEpoch});
    }
  
    return result;
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      name: map['name'],
      address: map['address'],
      city: map['city'],
      postalCode: map['postalCode'],
      latitude: map['latitude']?.toInt(),
      longitude: map['longitude']?.toInt(),
      isDefault: map['isDefault'],
      id: map['id']?.toInt(),
      userId: map['userId']?.toInt(),
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationModel(name: $name, address: $address, city: $city, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault, id: $id, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LocationModel &&
      other.name == name &&
      other.address == address &&
      other.city == city &&
      other.postalCode == postalCode &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.isDefault == isDefault &&
      other.id == id &&
      other.userId == userId &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      address.hashCode ^
      city.hashCode ^
      postalCode.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      isDefault.hashCode ^
      id.hashCode ^
      userId.hashCode ^
      createdAt.hashCode;
  }
}
