class ModeGetIP {
  int? ipVersion;
  String? ipAddress;
  double? latitude;
  double? longitude;
  String? countryName;
  String? countryCode;
  String? timeZone;
  String? zipCode;
  String? cityName;
  String? regionName;

  ModeGetIP(
      {this.ipVersion,
      this.ipAddress,
      this.latitude,
      this.longitude,
      this.countryName,
      this.countryCode,
      this.timeZone,
      this.zipCode,
      this.cityName,
      this.regionName});

  ModeGetIP.fromJson(Map<String, dynamic> json) {
    ipVersion = json['ipVersion'];
    ipAddress = json['ipAddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    timeZone = json['timeZone'];
    zipCode = json['zipCode'];
    cityName = json['cityName'];
    regionName = json['regionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ipVersion'] = this.ipVersion;
    data['ipAddress'] = this.ipAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['countryName'] = this.countryName;
    data['countryCode'] = this.countryCode;
    data['timeZone'] = this.timeZone;
    data['zipCode'] = this.zipCode;
    data['cityName'] = this.cityName;
    data['regionName'] = this.regionName;
    return data;
  }
}
