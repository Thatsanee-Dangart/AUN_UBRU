import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
//Explicit
  static const ubruLatLng =
      const LatLng(15.245895, 104.847643); //ประกาศตัวแปรแก้ไขไม่ได้
  CameraPosition cameraPosition = CameraPosition(
    target: ubruLatLng,
    zoom: 16.0,
  );

//Method

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        position: ubruLatLng,
        markerId: MarkerId('UBRU'),
        infoWindow: InfoWindow(
          title: 'ม.ราชภัฏอุบล',
          snippet: 'มหาวิทยาลัยที่ยอดเยี่ยม',
        ),icon: BitmapDescriptor.defaultMarkerWithHue(100.0)
      ),
    ].toSet();
  }



  Widget myMap() {
    return GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
      markers: myMarker(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return myMap();
  }
}
