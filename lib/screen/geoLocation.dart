import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import 'SeleccionaPrincipal.dart';

class GeoListenPage extends StatefulWidget {
  @override
  _GeoListenPageState createState() => _GeoListenPageState();
}

class _GeoListenPageState extends State<GeoListenPage> {
  Geolocator geolocator = Geolocator();

  Position userLocation;
  String url="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text("Location:" +
                userLocation.latitude.toString() +
                " " +
                userLocation.longitude.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;

                    });
                  });
                },
                color: Colors.blue,
                child: Text(
                  "Buscar Ubicación",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
            ,userLocation != null?RaisedButton(
              onPressed: () {

              },
              color: Colors.blue,
              child: Text(
                "Enviar Ubicación",
                style: TextStyle(color: Colors.white),
              ),
            ):null
            ,userLocation == null
             ? CircularProgressIndicator()
             : Expanded( child: WebView(
              initialUrl: 'http://sd-1578096-h00001.ferozo.net/xubicacion/index.php?lat='+ userLocation.latitude.toString() + '&lng='+userLocation.longitude.toString(),
              javascriptMode: JavascriptMode.unrestricted,
            ))
          ],
        ),
      ),
    );
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}