import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:flutter/material.dart';

class ServiceAdmin extends StatefulWidget {
  @override
  _ServiceAdminState createState() => _ServiceAdminState();
}

class _ServiceAdminState extends State<ServiceAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConColors.primary,
        title: Text('Service Admin'),
      ),
    );
  }
}