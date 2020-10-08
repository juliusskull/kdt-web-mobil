import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_web/models/productos.dart';
import 'package:flutter_app_web/screen/productoOne.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
const baseUrl = "http://sd-1578096-h00001.ferozo.net:3005/productos";
class ProductoListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();

}

class API {
  static Future getUsers() {
    var url = baseUrl;
    return http.get(url);
  }
}
Widget  _boton(BuildContext context, String descripcion,String precio, String foto ){
  return RaisedButton(
      padding: const EdgeInsets.all(8.0),
      elevation: 4.0,
      color: Colors.blue,
      splashColor: Colors.black,
      child:
      Container(
          color: Colors.black,
          child:
          Row(
              crossAxisAlignment: CrossAxisAlignment.center ,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const  Text("Comprar",style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white

                )),
                Icon(Icons.play_arrow, color: Colors.white,),
              ])),
      onPressed: (){
        //Navigator.of(context).pop();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  ProductoOneSreen(descripcion,precio,foto)),
        );

      }
  );
}
Widget _dinero(String moneda,String compra, String venta) {
  return

    Container(
        margin: EdgeInsets.symmetric(vertical: 40.0),
        child:
        Padding(
          padding: const EdgeInsets.all(0.0),
          child:  Column(
            children: <Widget>[
              Text(moneda ,
                  style: TextStyle(fontSize: 18))
              ,new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Compra',
                    style: TextStyle(fontSize: 15 , height: 3),),
                  VerticalDivider(),
                  Text(compra,
                    style: TextStyle(fontSize: 15, height: 3),),
                  VerticalDivider(),
                  Text('Venta',
                    style: TextStyle(fontSize: 15, height: 3),),
                  VerticalDivider(),
                  Text(venta,
                    style: TextStyle(fontSize: 15, height: 3),),
                ],
              ),
            ],
          ),
        )

    );
}
class _MyListScreenState extends State {
  var users = new List<Productos>();
  String imageDefault='https://sevilla.abc.es/gurme/wp-content/uploads/sites/24/2010/08/hamburguesa-huevo-960x540.jpg';
  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => Productos.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Productos Ofrecidos"),
        ),
        body:Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          ListView.builder(
            itemCount: users.length,
            padding: const EdgeInsets.all(30.0),
            itemBuilder: (context, index) {
              // if( users[index].sucursal_id.toString().ec == '1')
              return Card(
                child: Column(
                    children: [ ListTile(
                    title: Text(users[index].descripcion)
                    , subtitle:Text('Precio:\$'+users[index].precio),

                  ),
              CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl:
              users[index].foto.replaceAll("images", "imagenes"),
              )
              /*
              FadeInImage.memoryNetwork(
              placeholder:  "assets/images/loading.gif",
              image: users[index].foto,
              ),*/
    /*),Image.network( (users[index].foto!=null)?users[index].foto.replaceAll("images", "imagenes"): imageDefault,placeholder: (context,url) => CircularProgressIndicator() )*/
                  ,_boton(context,users[index].descripcion,users[index].precio,users[index].foto )
              ])

              );
              // else return null;
            },

          ) ]
        )
    );

  }
}