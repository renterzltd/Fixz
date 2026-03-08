// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import 'package:fixz/hdHelper/sharedManager.dart';

class Property {
  Property(
      {this.id,
      this.postCode,
      this.address,
      this.flatNumber,
      this.town,
      this.city,
      this.address2,
      this.bedroomNumber,
      this.bathroomNumber,
      this.livingRoom,
      this.furnishingOptions,
      this.epcRating,
      this.propertyDescription,
      this.monthRent,
      this.weeklyRent,
      this.depositAmount,
      this.minimumTenancyLength,
      this.maximumNumberTenants,
      this.earliestMove,
      this.billsInclude,
      this.garden,
      this.parking,
      this.fireplace,
      this.student,
      this.families,
      this.dss,
      this.pets,
      this.smokers,
      this.studentOnly,
      this.status,
      this.type,
      this.isFree,
      this.addedByType,
      this.addedById,
      this.addressId,
      this.landloardId,
      this.createdAt,
      this.updatedAt,
      this.pictures = const [],
      this.favorite,
      this.price});

  int? id;
  String? postCode;
  Address? address;
  String? flatNumber;
  String? town;
  String? city;
  String? address2;
  int? bedroomNumber;
  int? bathroomNumber;
  int? livingRoom;
  String? furnishingOptions;
  String? epcRating;
  String? propertyDescription;
  int? monthRent;
  int? weeklyRent;
  int? depositAmount;
  int? price;
  int? minimumTenancyLength;
  int? maximumNumberTenants;
  DateTime? earliestMove;
  int? billsInclude;
  int? garden;
  int? parking;
  int? fireplace;
  int? student;
  int? families;
  int? dss;
  int? pets;
  int? smokers;
  int? studentOnly;
  int? status;
  String? type;
  String? isFree;
  String? addedByType;
  int? addedById;
  int? addressId;
  int? landloardId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String> pictures = [];
  bool? favorite;

  String getImage() {
    if (this.pictures != null) if (this.pictures.isNotEmpty) return pictures[0];
    return "";
  }

  List<String> getFeaturesList() {
    List<String> list = [];

    if (billsInclude != null && billsInclude == 1) {
      list.add("Bills Include");
    }

    if (garden != null && garden == 1) {
      list.add("Garden");
    }

    if (parking != null && parking == 1) {
      list.add("Parking");
    }

    if (fireplace != null && fireplace == 1) {
      list.add("Fireplace");
    }

    if (student != null && student == 1) {
      list.add("Student");
    }

    if (families != null && families == 1) {
      list.add("Families");
    }

    if (dss != null && dss == 1) {
      list.add("DSS");
    }

    if (pets != null && pets == 1) {
      list.add("Pets");
    }

    if (smokers != null && smokers == 1) {
      list.add("Smokers");
    }

    if (studentOnly != null && studentOnly == 1) {
      list.add("Student Only");
    }

    return list;
  }

  List<String> getInfoList() {
    List<String> list = [];

    if (city != null && city!.isNotEmpty) {
      list.add("City");
      list.add(city!);
    }

    if (address2 != null && address2!.isNotEmpty) {
      list.add("Address Line 2");
      list.add(address2!);
    }

    if (depositAmount != null) {
      list.add("Deposit Amount");
      list.add('${SharedManager.shared.getCurrency}$depositAmount');
    }

    if (furnishingOptions != null && furnishingOptions!.isNotEmpty) {
      list.add("Furnishing Options");
      list.add(furnishingOptions!);
    }

    if (epcRating != null && epcRating!.isNotEmpty) {
      list.add("EPC Rating");
      list.add(epcRating!);
    }

    return list;
  }

  factory Property.fromRawJson(String str) =>
      Property.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        price: json["price"] == null ? null : json["price"],
        id: json["id"] == null ? null : json["id"],
        postCode: json["post_code"] == null ? null : json["post_code"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        flatNumber: json["flat_number"] == null ? null : json["flat_number"],
        town: json["town"] == null ? null : json["town"],
        city: json["city"] == null ? null : json["city"],
        address2: json["address2"] == null ? null : json["address2"],
        bedroomNumber:
            json["bedroom_number"] == null ? null : json["bedroom_number"],
        livingRoom: json["living_room"] == null ? null : json["living_room"],
        bathroomNumber:
            json["bathroom_number"] == null ? null : json["bathroom_number"],
        furnishingOptions: json["furnishing_options"] == null
            ? null
            : json["furnishing_options"],
        epcRating: json["epc_rating"] == null ? null : json["epc_rating"],
        propertyDescription: json["property_description"] == null
            ? null
            : json["property_description"],
        monthRent: json["month_rent"] == null ? null : json["month_rent"],
        weeklyRent: json["weekly_rent"] == null ? null : json["weekly_rent"],
        depositAmount:
            json["deposit_amount"] == null ? null : json["deposit_amount"],
        minimumTenancyLength: json["minimum_tenancy_length"] == null
            ? null
            : json["minimum_tenancy_length"],
        maximumNumberTenants: json["maximum_number_tenants"] == null
            ? null
            : json["maximum_number_tenants"],
        earliestMove: json["earliest_move"] == null
            ? null
            : DateTime.parse(json["earliest_move"]),
        billsInclude:
            json["bills_include"] == null ? null : json["bills_include"],
        garden: json["garden"] == null ? null : json["garden"],
        parking: json["parking"] == null ? null : json["parking"],
        fireplace: json["fireplace"] == null ? null : json["fireplace"],
        student: json["student"] == null ? null : json["student"],
        families: json["families"] == null ? null : json["families"],
        dss: json["dss"] == null ? null : json["dss"],
        pets: json["pets"] == null ? null : json["pets"],
        smokers: json["smokers"] == null ? null : json["smokers"],
        studentOnly: json["student_only"] == null ? null : json["student_only"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        isFree: json["is_free"] == null ? null : json["is_free"],
        addedByType:
            json["added_by_type"] == null ? null : json["added_by_type"],
        addedById: json["added_by_id"] == null ? null : json["added_by_id"],
        addressId: json["address_id"] == null ? null : json["address_id"],
        landloardId: json["landloard_id"] == null ? null : json["landloard_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pictures: json["pictures"] == null
            ? []
            : List<String>.from(json["pictures"].map((x) => x)),
        favorite: json["favorite"] == null ? false : json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "post_code": postCode == null ? null : postCode,
        "address": address == null ? null : address!.toJson(),
        "flat_number": flatNumber == null ? null : flatNumber,
        "town": town == null ? null : town,
        "city": city == null ? null : city,
        "address2": address2 == null ? null : address2,
        "bedroom_number": bedroomNumber == null ? null : bedroomNumber,
        "bathroom_number": bathroomNumber == null ? null : bathroomNumber,
        "living_room": livingRoom == null ? null : livingRoom,
        "furnishing_options":
            furnishingOptions == null ? null : furnishingOptions,
        "epc_rating": epcRating == null ? null : epcRating,
        "property_description":
            propertyDescription == null ? null : propertyDescription,
        "month_rent": monthRent == null ? null : monthRent,
        "weekly_rent": weeklyRent == null ? null : weeklyRent,
        "deposit_amount": depositAmount == null ? null : depositAmount,
        "minimum_tenancy_length":
            minimumTenancyLength == null ? null : minimumTenancyLength,
        "maximum_number_tenants":
            maximumNumberTenants == null ? null : maximumNumberTenants,
        "earliest_move": earliestMove == null
            ? null
            : "${earliestMove!.year.toString().padLeft(4, '0')}-${earliestMove!.month.toString().padLeft(2, '0')}-${earliestMove!.day.toString().padLeft(2, '0')}",
        "bills_include": billsInclude == null ? null : billsInclude,
        "garden": garden == null ? null : garden,
        "parking": parking == null ? null : parking,
        "fireplace": fireplace == null ? null : fireplace,
        "student": student == null ? null : student,
        "families": families == null ? null : families,
        "dss": dss == null ? null : dss,
        "pets": pets == null ? null : pets,
        "smokers": smokers == null ? null : smokers,
        "student_only": studentOnly == null ? null : studentOnly,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "is_free": isFree == null ? null : isFree,
        "added_by_type": addedByType == null ? null : addedByType,
        "added_by_id": addedById == null ? null : addedById,
        "address_id": addressId == null ? null : addressId,
        "landloard_id": landloardId == null ? null : landloardId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "pictures": pictures == null
            ? null
            : List<dynamic>.from(pictures.map((x) => x)),
        "favorite": favorite == null ? null : favorite,
      };
}

class Address {
  Address({
    this.id,
    this.longitude,
    this.latitude,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? longitude;
  String? latitude;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        address: json["address"] == null ? null : json["address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "address": address == null ? null : address,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
