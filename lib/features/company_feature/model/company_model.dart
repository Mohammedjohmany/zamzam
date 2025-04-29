import 'dart:convert';

class CompanyModel {
  String name;
   String description;
    String contact_info;
    double rating;
    int price_per_liter;
    int id; 
  CompanyModel({
    required this.name,
    required this.description,
    required this.contact_info,
    required this.rating,
    required this.price_per_liter,
    required this.id,
  });



  CompanyModel copyWith({
    String? name,
    String? description,
    String? contact_info,
    double? rating,
    int? price_per_liter,
    int? id,
  }) {
    return CompanyModel(
      name: name ?? this.name,
      description: description ?? this.description,
      contact_info: contact_info ?? this.contact_info,
      rating: rating ?? this.rating,
      price_per_liter: price_per_liter ?? this.price_per_liter,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'contact_info': contact_info});
    result.addAll({'rating': rating});
    result.addAll({'price_per_liter': price_per_liter});
    result.addAll({'id': id});
  
    return result;
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      contact_info: map['contact_info'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      price_per_liter: map['price_per_liter']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) => CompanyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyModel(name: $name, description: $description, contact_info: $contact_info, rating: $rating, price_per_liter: $price_per_liter, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CompanyModel &&
      other.name == name &&
      other.description == description &&
      other.contact_info == contact_info &&
      other.rating == rating &&
      other.price_per_liter == price_per_liter &&
      other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      description.hashCode ^
      contact_info.hashCode ^
      rating.hashCode ^
      price_per_liter.hashCode ^
      id.hashCode;
  }
}



