import 'package:flutter/material.dart';
import 'package:flutter_app_web/screen/seleccionaUbicacionOne.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class SeleccionScreen extends StatefulWidget {
 //final _links = ['https://camellabs.com'];
  final String lat;
  final String lng;



    const SeleccionScreen(this.lat, this.lng);
  @override
  _MyHomePageState createState() => new _MyHomePageState(this.lat, this.lng);
}
  class _MyHomePageState extends State<SeleccionScreen> {
    final _webViewPlugin = FlutterWebviewPlugin();
    final String lat;
    final String lng;
    _MyHomePageState(this.lat, this.lng);
  @override
  Widget build(BuildContext context) {
      var title = 'Donde envio';
      return MaterialApp(
      title: title,
      home: WebviewScaffold(
      url: "http://sd-1578096-h00001.ferozo.net/xubicacion/index.php?lat="+lat+"&lng="+lng,
      withZoom: false,
      withLocalStorage: true,
      ));
    }
  }
/*

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: "https://flutter.dev/",
        withJavascript: true,
        withZoom: false,
        hidden: true ,
        appBar: AppBar(
            title: Text("Flutter"),
            elevation: 1
        ),
        initialChild: Container(
          color: Colors.white,
          child: const Center(
            child: Text('waiting...'),
          ),)  );
  }
  */
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _links.map((link) => _urlButton(context, link)).toList(),
                ))));
  }
  Widget _urlButton(BuildContext context, String url) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: FlatButton(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          child: Text(url),
          onPressed: () => _handleURLButtonPress(context, url),
        ));
  }
  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
  */
//}