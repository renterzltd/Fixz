// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, prefer_const_constructors, unnecessary_this, prefer_final_fields, unused_field, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:fixz/screens/contractorLocationTracking/controller/mapController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

class OrderTrackingPage extends StatelessWidget {
  final latitude;
  final longitude;
  final driverId;
  final driverNumber;
  final contractorName;
  final LatLng? driverLocation;

  const OrderTrackingPage(
      {required this.latitude,
      required this.longitude,
      required this.driverId,
      required this.driverNumber,
      required this.contractorName,
      required this.driverLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapSample(latitude, longitude, driverId, this.driverLocation!,
          this.contractorName),
    );
  }
}

class MapSample extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String driverId;
  final LatLng driverLocation;
  final String contractorName;
  MapSample(
    this.latitude,
    this.longitude,
    this.driverId,
    this.driverLocation,
    this.contractorName,
  );

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng = LatLng(0.0, 0.0);
  // LocationData? currentLocation;
  CameraPosition? _currentPosition;
  BitmapDescriptor? pinLocationIcon;
  BitmapDescriptor? destinationLocationIcon;
  Timer? timer;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var count = 0;
  //this is restaurant address
  // double lat = 23.031581;
  // double lng = 72.510317;
  var time = "12kms";
  var distance = "19min";

  final controller = Get.put(MapController());

  @override
  void initState() {
    super.initState();
    // controller.fillTestLocation();

    latLng = LatLng(double.parse(this.widget.latitude),
        double.parse(this.widget.longitude));
    _currentPosition =
        CameraPosition(target: this.widget.driverLocation, zoom: 14.0);

    // this.lat = this.widget.driverLocation.latitude;
    // this.lng = this.widget.driverLocation.longitude;
    // _onAddMarkerButtonPressed();
    controller.updateDriverLocation(
        widget.driverId, true, widget.latitude, widget.longitude,
        contractorName: widget.contractorName);
    _setupTimer();
  }

  @override
  void dispose() {
    try {
      this.timer!.cancel();
    } catch (error) {
      debugPrint('error:$error');
    }
    super.dispose();
  }

  _setupTimer() {
    this.timer = Timer.periodic(
        Duration(seconds: SharedManager.shared.updateDriver), (timer) async {
      controller.updateDriverLocation(
          widget.driverId, true, widget.latitude, widget.longitude,
          contractorName: widget.contractorName);
    });
  }

  void _onAddMarkerButtonPressed() async {
    // setCustomMapPin();
    // setDriverMapPin();
    // _modalBottomSheetMenu();
    _markers.clear();
    List<Marker> list = [
      Marker(
        markerId: MarkerId('Marker1'),
        position: LatLng(double.parse(this.widget.latitude),
            double.parse(this.widget.longitude)),
        infoWindow: InfoWindow(title: 'Delivery Location'),
      ),
    ];

    _markers.add(Marker(
        markerId: MarkerId(widget.driverId),
        position: widget.driverLocation,
        infoWindow: InfoWindow(title: 'Driver')));
    _markers.addAll(list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
//    debugPrint("getLocation111:$latLng");
    return GetBuilder<MapController>(
      builder: (con) {
        return Scaffold(
            appBar: AppBar(
              title: setCommonText('Track Contractor'.tr,
                  color: Colors.white, fontSize: 20),
              backgroundColor: AppColors.colorPrimaryDark.lightColorHex(),
              elevation: 0.0,
              actions: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 25,
                      ),
                      setHeight(3),
                      setCommonText(
                        '${con.distance} km  ',
                        color: AppColors.white.lightColorHex(),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: Container(
              child: GoogleMap(
                padding: EdgeInsets.all(20),
                minMaxZoomPreference: MinMaxZoomPreference(0, 15),
                initialCameraPosition: con.kLake,
                zoomControlsEnabled: true,
                onMapCreated: (value) {
                  con.onMapCreated(value,
                      contractorName: widget.contractorName);
                },
                markers: Set.from(
                  controller.markers,
                ),
              ),
            ));
      },
    );
  }
}
