import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
/*
void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new ProductoOneSreen(),
    );
  }
}
*/
class ProductoOneSreen extends StatefulWidget {
   final String precio;
   final String descripcion;
   final String foto;
  // ProductoOneSreen({Key key}) : super(key: key);
   const ProductoOneSreen(this.precio, this.descripcion, this.foto);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<ProductoOneSreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ProductoOneScreen'),
      ),
      body:
      new Card(key: null,
        child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Image.network(
                'https://sevilla.abc.es/gurme/wp-content/uploads/sites/24/2010/08/hamburguesa-huevo-960x540.jpg',
                //widget.foto,
                fit:BoxFit.fill,
              ),

              new Text(
                "Precio:"+ widget.precio,
                style: new TextStyle(fontSize:12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              new Text(
                "Descripcion:"+widget.descripcion,
                style: new TextStyle(fontSize:12.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              new RaisedButton(key:null, onPressed:buttonPressed,
                  color: const Color(0xFFe0e0e0),
                  child:
                  new Text(
                    "Confirmar Compra",
                    style: new TextStyle(fontSize:12.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  )
              )
            ]

        ),

      ),

    );
  }
  void buttonPressed(){}

}