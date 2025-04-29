import 'dart:convert';

import 'package:zamzam/features/company_feature/model/company_model.dart';

class OffersModel {


    final String? title;
    final String? description;
    final double? price;
    final int? quantity;
    final int? volume;
    final int? id;
    final int? companyId;
    final CompanyModel? company;
  OffersModel({
    this.title,
    this.description,
    this.price,
    this.quantity,
    this.volume,
    this.id,
    this.companyId,
    this.company,
  });

    


  OffersModel copyWith({
    String? title,
    String? description,
    double? price,
    int? quantity,
    int? volume,
    int? id,
    int? companyId,
    CompanyModel? company,
  }) {
    return OffersModel(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      volume: volume ?? this.volume,
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      company: company ?? this.company,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(title != null){
      result.addAll({'title': title});
    }
    if(description != null){
      result.addAll({'description': description});
    }
    if(price != null){
      result.addAll({'price': price});
    }
    if(quantity != null){
      result.addAll({'quantity': quantity});
    }
    if(volume != null){
      result.addAll({'volume': volume});
    }
    if(id != null){
      result.addAll({'id': id});
    }
    if(companyId != null){
      result.addAll({'companyId': companyId});
    }
    if(company != null){
      result.addAll({'company': company!.toMap()});
    }
  
    return result;
  }

  factory OffersModel.fromMap(Map<String, dynamic> map) {
    return OffersModel(
      title: map['title'],
      description: map['description'],
      price: map['price']?.toDouble(),
      quantity: map['quantity']?.toInt(),
      volume: map['volume']?.toInt(),
      id: map['id']?.toInt(),
      companyId: map['companyId']?.toInt(),
      company: map['company'] != null ? CompanyModel.fromMap(map['company']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OffersModel.fromJson(String source) => OffersModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OffersModel(title: $title, description: $description, price: $price, quantity: $quantity, volume: $volume, id: $id, companyId: $companyId, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OffersModel &&
      other.title == title &&
      other.description == description &&
      other.price == price &&
      other.quantity == quantity &&
      other.volume == volume &&
      other.id == id &&
      other.companyId == companyId &&
      other.company == company;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      volume.hashCode ^
      id.hashCode ^
      companyId.hashCode ^
      company.hashCode;
  }
}
