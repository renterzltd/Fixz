// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:async';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContractorTrackingPage extends StatefulWidget {
  const ContractorTrackingPage({Key? key}) : super(key: key);

  @override
  State<ContractorTrackingPage> createState() => _ContractorTrackingPageState();
}

class _ContractorTrackingPageState extends State<ContractorTrackingPage>
    with AppbarMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Controller method to call contractor location every 5 to 6 seconds
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> mapController = Completer();

    final CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    final CameraPosition kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    return Scaffold(
      appBar: setAppbar('Track Contractor'.tr,
          bgColor: AppColors.white.lightColorHex(),
          elivation: 1.0,
          onBackClick: () {}),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
      ),
    );
  }
}
