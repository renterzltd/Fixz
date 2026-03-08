// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/util/mapUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  bool isPickedUp = false;
  bool isStartRide = false;
  String distance = '';

  //calculateDistance
  LatLng? driverCoordinate;
  LatLng? customerCoordinate;

  Completer<GoogleMapController> myController = Completer();
  List<TestLocation> testLocation = [];
  List<Marker> markers = <Marker>[];
  late GoogleMapController googleMapController;
  final CameraPosition kLake = CameraPosition(
      target:
          LatLng(SharedManager.shared.latitude, SharedManager.shared.latitude),
      zoom: 9);
  @override
  void onInit() {
    super.onInit();
    // fillTestLocation();
  }

  fillTestLocation() {
    testLocation = [
      TestLocation(lat: 22.24298551646112, lng: 70.79960893931676),
      TestLocation(lat: 22.244892153614668, lng: 70.79793524085883),
      TestLocation(lat: 22.246044067653195, lng: 70.79677652654182),
      TestLocation(lat: 22.24737471518206, lng: 70.79559635455226),
      TestLocation(lat: 22.246898066774005, lng: 70.79420160583732),
      TestLocation(lat: 22.24576602030427, lng: 70.79368662169642),
      TestLocation(lat: 22.24411758540064, lng: 70.79327892591822),
      TestLocation(lat: 22.24320398661793, lng: 70.79276394177731),
      TestLocation(lat: 22.239606815836673, lng: 70.7922232838626),
      TestLocation(lat: 22.237860098933407, lng: 70.7922232838626),
      TestLocation(lat: 22.23715128006669, lng: 70.79216858565594),
      TestLocation(lat: 22.23555642450838, lng: 70.79227798206925),
      TestLocation(lat: 22.2340881287424, lng: 70.79156690538274),
      TestLocation(lat: 22.23440877046097, lng: 70.79147297639359),
      TestLocation(
          lat: SharedManager.shared.latitude,
          lng: SharedManager.shared.longitude),
    ];
  }

  updateDriverLocation(String id, bool isHideLoader, String lat, String long,
      {required String contractorName}) async {
    // Requestmanager manager = Requestmanager();
    // await manager
    //     .fetchDriverCurrentLocation(id, isHideLoader)
    //     .then((value) async {
    //   if (value.code == 1) {
    // if (testLocation.isNotEmpty) {
    ApiProvider _apiProvider = ApiProvider();
    await _apiProvider
        .getContractorLocation(id, isLoader: false)
        .then((value) async {
      if (value.contractorData != null) {
        if (value.contractorData?.latitude == '0.0' &&
            value.contractorData?.longitude == '0.0') return;
        //Driver Coordinates
        driverCoordinate = LatLng(
            double.parse(value.contractorData?.latitude ?? '0.00'),
            double.parse(value.contractorData?.longitude ?? '0.00'));

        customerCoordinate = LatLng(double.parse(lat), double.parse(long));

        await addMarker(contractorName: contractorName);
        await showAnimations();
        await calculDistance(driverCoordinate!);
        update();
      }
    });

    //************************Driver Traking Test************************//
    // final latLng = LatLng(testLocation.first.lat!, testLocation.first.lng!);
    // testLocation.removeAt(0);

    //************************ACTUAL DRIVER TRACKING****************************//
    //NOTE: If you want to test the track your driver functionality update above array with your near by location's lat long.
    // final latLng = LatLng(double.parse(value.result!.latitude!),
    //     double.parse(value.result!.longitude!));
    // driverCoordinate = latLng;
    // await addMarker();
    // await showAnimations();
    // await calculDistance(driverCoordinate);
    // update();
    // }
    //   }
    // });
  }

  addMarker({required String contractorName}) async {
    final deliveryBoyIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)),
        'assets/TrackOrder/deliveryBoyIcon.png');
    markers = [];
    markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: driverCoordinate!,
        icon: deliveryBoyIcon,
        infoWindow: InfoWindow(title: contractorName),
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId('2'),
        position: customerCoordinate!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: 'Your Location'.tr),
      ),
    );
    update();
  }

  showAnimations() {
    Future.delayed(
        Duration(milliseconds: 200),
        () => googleMapController.animateCamera(CameraUpdate.newLatLngBounds(
            MapUtils.boundsFromLatLngList(
                markers.map((loc) => loc.position).toList()),
            1)));
  }

  calculDistance(LatLng coordinate) {
    distance = MapUtils()
        .calculateDistance(
            customerCoordinate!.latitude,
            customerCoordinate!.longitude,
            driverCoordinate!.latitude,
            driverCoordinate!.longitude)
        .toStringAsFixed(2);
    update();
  }

  onMapCreated(GoogleMapController controller,
      {required String contractorName}) async {
    googleMapController = controller;
    await addMarker(contractorName: contractorName);
    showAnimations();
    calculDistance(driverCoordinate!);
    update();
  }
}

//22.23440877046097, 70.79147297639359
class TestLocation {
  double? lat;
  double? lng;
  TestLocation({this.lat, this.lng});
}
