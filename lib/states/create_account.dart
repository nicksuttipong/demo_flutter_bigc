import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CreateAccout extends StatefulWidget {
  @override
  _CreateAccoutState createState() => _CreateAccoutState();
}

class _CreateAccoutState extends State<CreateAccout> {

  double? lat, lng;

  @override
  void initState() {
    super.initState();
    findLatLon();
  }

  Future<Null> findLatLon()async{
    Position? position = await findPosition();
    lat = position!.latitude;
    lng = position.longitude;
  }

  Future<Position?> findPosition()async{
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
          backgroundColor: ConColors.primary, title: Text('Create Accout')),
          body: Center(
            child: Column(
              children: [
                buildName(size),
                buildUser(size),
                buildPassword(size),
              ],
            ),
          ),
    );
  }

  Container buildName(double size) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Name :',
              prefixIcon: Icon(Icons.fingerprint_outlined, color: ConColors.primary),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: ConColors.primary))),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }

  Container buildUser(double size) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'User :',
              prefixIcon: Icon(Icons.account_circle, color: ConColors.primary),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: ConColors.primary))),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }

  Container buildPassword(double size) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Password :',
              prefixIcon: Icon(Icons.lock_clock_outlined, color: ConColors.primary),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: ConColors.primary))),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }
}
