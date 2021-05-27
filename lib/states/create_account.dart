import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:bigcproj/utilities/style/style_button.dart';
import 'package:bigcproj/widgets/show_progress.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateAccout extends StatefulWidget {
  @override
  _CreateAccoutState createState() => _CreateAccoutState();
}

class _CreateAccoutState extends State<CreateAccout> {
  double? lat, lng;
  bool loading = true;
  final formField = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    findLatLon();
  }

  Future<Null> findLatLon() async {
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      loading = false;
    });
  }

  Future<Position?> findPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConColors.primary,
        title: Text('Create Accout'),
      ),
      body: loading ? ShowProgress() : buildCenter(size),
    );
  }

  Center buildCenter(double size) {
    return Center(
      child: Form(
        key: formField,
        child: SingleChildScrollView (
                  child: Column(
            children: [
              buildName(size),
              buildUser(size),
              buildPassword(size),
              buildMap(size),
              buildCreateAccout(size)
            ],
          ),
        ),
      ),
    );
  }

  Container buildCreateAccout(double size) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: size * 0.6,
      child: ElevatedButton.icon(
        style: StyleButton().myButtonStyle(),
        onPressed: () {
          if (formField.currentState!.validate()) {}
        },
        icon: Icon(Icons.cloud_upload_rounded),
        label: Text('Create Accout'),
      ),
    );
  }

  Set<Marker> setMarkers() {
    return [
      Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow: InfoWindow(
              title: 'You are here',
              snippet: 'Latitude = $lat, longitude = $lng')),
    ].toSet();
  }

  Container buildMap(double size) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 16),
      width: size * 0.8,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat!, lng!),
          zoom: 16,
        ),
        onMapCreated: (controller) {},
        markers: setMarkers(),
      ),
    );
  }

  Container buildName(double size) {
    final String filename = 'Name';
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill $filename';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: '$filename :',
            prefixIcon:
                Icon(Icons.fingerprint_outlined, color: ConColors.primary),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ConColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }

  Container buildUser(double size) {
    final String filename = 'User';
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill $filename';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: '$filename :',
            prefixIcon:
                Icon(Icons.fingerprint_outlined, color: ConColors.primary),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ConColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }

  Container buildPassword(double size) {
    final String filename = 'Password';
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill $filename';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: '$filename :',
            prefixIcon:
                Icon(Icons.fingerprint_outlined, color: ConColors.primary),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ConColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }

  
}
