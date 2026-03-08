// ignore_for_file: unnecessary_this, prefer_collection_literals

class ModelAddressList {
  List<PostCodeAddress>? addressList;
  int? code;
  String? message;
  int? limit;
  int? page;
  int? total;

  ModelAddressList(
      {this.addressList,
      this.code,
      this.message,
      this.limit,
      this.page,
      this.total});

  ModelAddressList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      addressList = <PostCodeAddress>[];
      json['result'].forEach((v) {
        addressList!.add(PostCodeAddress.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
    limit = json['limit'];
    page = json['page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.addressList != null) {
      data['result'] = this.addressList!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['total'] = this.total;
    return data;
  }
}

class PostCodeAddress {
  String? postcode;
  String? postcodeInward;
  String? postcodeOutward;
  String? postTown;
  String? dependantLocality;
  String? doubleDependantLocality;
  String? thoroughfare;
  String? dependantThoroughfare;
  String? buildingNumber;
  String? buildingName;
  String? subBuildingName;
  String? poBox;
  String? departmentName;
  String? organisationName;
  int? udprn;
  String? postcodeType;
  String? suOrganisationIndicator;
  String? deliveryPointSuffix;
  String? line1;
  String? line2;
  String? line3;
  String? premise;
  double? longitude;
  double? latitude;
  int? eastings;
  int? northings;
  String? country;
  String? traditionalCounty;
  String? administrativeCounty;
  String? postalCounty;
  String? county;
  String? district;
  String? ward;
  String? uprn;
  String? id;
  String? countryIso;
  String? countryIso2;
  String? countyCode;
  String? language;
  String? umprn;
  String? dataset;

  PostCodeAddress(
      {this.postcode,
      this.postcodeInward,
      this.postcodeOutward,
      this.postTown,
      this.dependantLocality,
      this.doubleDependantLocality,
      this.thoroughfare,
      this.dependantThoroughfare,
      this.buildingNumber,
      this.buildingName,
      this.subBuildingName,
      this.poBox,
      this.departmentName,
      this.organisationName,
      this.udprn,
      this.postcodeType,
      this.suOrganisationIndicator,
      this.deliveryPointSuffix,
      this.line1,
      this.line2,
      this.line3,
      this.premise,
      this.longitude,
      this.latitude,
      this.eastings,
      this.northings,
      this.country,
      this.traditionalCounty,
      this.administrativeCounty,
      this.postalCounty,
      this.county,
      this.district,
      this.ward,
      this.uprn,
      this.id,
      this.countryIso,
      this.countryIso2,
      this.countyCode,
      this.language,
      this.umprn,
      this.dataset});

  PostCodeAddress.fromJson(Map<String, dynamic> json) {
    postcode = json['postcode'];
    postcodeInward = json['postcode_inward'];
    postcodeOutward = json['postcode_outward'];
    postTown = json['post_town'];
    dependantLocality = json['dependant_locality'];
    doubleDependantLocality = json['double_dependant_locality'];
    thoroughfare = json['thoroughfare'];
    dependantThoroughfare = json['dependant_thoroughfare'];
    buildingNumber = json['building_number'];
    buildingName = json['building_name'];
    subBuildingName = json['sub_building_name'];
    poBox = json['po_box'];
    departmentName = json['department_name'];
    organisationName = json['organisation_name'];
    udprn = json['udprn'];
    postcodeType = json['postcode_type'];
    suOrganisationIndicator = json['su_organisation_indicator'];
    deliveryPointSuffix = json['delivery_point_suffix'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    line3 = json['line_3'];
    premise = json['premise'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    eastings = json['eastings'];
    northings = json['northings'];
    country = json['country'];
    traditionalCounty = json['traditional_county'];
    administrativeCounty = json['administrative_county'];
    postalCounty = json['postal_county'];
    county = json['county'];
    district = json['district'];
    ward = json['ward'];
    uprn = json['uprn'];
    id = json['id'];
    countryIso = json['country_iso'];
    countryIso2 = json['country_iso_2'];
    countyCode = json['county_code'];
    language = json['language'];
    umprn = json['umprn'];
    dataset = json['dataset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['postcode'] = this.postcode;
    data['postcode_inward'] = this.postcodeInward;
    data['postcode_outward'] = this.postcodeOutward;
    data['post_town'] = this.postTown;
    data['dependant_locality'] = this.dependantLocality;
    data['double_dependant_locality'] = this.doubleDependantLocality;
    data['thoroughfare'] = this.thoroughfare;
    data['dependant_thoroughfare'] = this.dependantThoroughfare;
    data['building_number'] = this.buildingNumber;
    data['building_name'] = this.buildingName;
    data['sub_building_name'] = this.subBuildingName;
    data['po_box'] = this.poBox;
    data['department_name'] = this.departmentName;
    data['organisation_name'] = this.organisationName;
    data['udprn'] = this.udprn;
    data['postcode_type'] = this.postcodeType;
    data['su_organisation_indicator'] = this.suOrganisationIndicator;
    data['delivery_point_suffix'] = this.deliveryPointSuffix;
    data['line_1'] = this.line1;
    data['line_2'] = this.line2;
    data['line_3'] = this.line3;
    data['premise'] = this.premise;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['eastings'] = this.eastings;
    data['northings'] = this.northings;
    data['country'] = this.country;
    data['traditional_county'] = this.traditionalCounty;
    data['administrative_county'] = this.administrativeCounty;
    data['postal_county'] = this.postalCounty;
    data['county'] = this.county;
    data['district'] = this.district;
    data['ward'] = this.ward;
    data['uprn'] = this.uprn;
    data['id'] = this.id;
    data['country_iso'] = this.countryIso;
    data['country_iso_2'] = this.countryIso2;
    data['county_code'] = this.countyCode;
    data['language'] = this.language;
    data['umprn'] = this.umprn;
    data['dataset'] = this.dataset;
    return data;
  }
}
