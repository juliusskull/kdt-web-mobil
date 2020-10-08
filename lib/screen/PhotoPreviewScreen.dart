
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_web/models/productos.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class PhotoPreviewScreen extends StatefulWidget {
  @override
  _PhotoPreviewScreenState createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
   File imageFile;
  String precio = "";
  String descripcion = "";
  String imagenPRoducto="";
  bool _validate= false;
  String hintTextPrecio= "Precio del producto";
  String hintTextDescripcion= "Descripcion del producto";
  Container contendorVacio=Container(width:0,height:0);
  int idNegocio=1;
  //String urlEndPoint="http://sd-1578096-h00001.ferozo.net:3005/upload";
  String urlEndPointBase="http://sd-1578096-h00001.ferozo.net";
  String urlEndPoint=  "/imagenes/image.php";
  String urlEndPointProductos=  ":3005/productos";


  bool envio= true;
  bool fin= false;

  String  alertTxt = "Debe agregar una foto";
  String  alertTxtPaso2 = "Agregar Producto";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:(fin==true)?_finalizacionCorrecta(): Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (envio==true)?CircularProgressIndicator():contendorVacio
            ,_setImageView()
            ,(imageFile!=null)?TextField(
              cursorColor: Colors.red,
              cursorRadius: Radius.circular(16.0),
              cursorWidth: 16.0,

              decoration: InputDecoration(
                  hintText: hintTextPrecio,
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
                  helperText: hintTextPrecio,
                  border: OutlineInputBorder(),
                  errorText: _validate ? 'Campo obligatorio' : null,
                  icon: Icon(Icons.attach_money)

              ),
              keyboardType: TextInputType.number,
             // textInputAction: TextInputAction.continueAction,
              onChanged: (texto) {
                precio = texto;
              },
            ):contendorVacio
            ,(imageFile!=null)?TextField(
              cursorColor: Colors.red,
              cursorRadius: Radius.circular(16.0),
              cursorWidth: 16.0,

              decoration: InputDecoration(
                  hintText: hintTextDescripcion,
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
                  helperText: hintTextDescripcion,
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.assignment)

              ),
              keyboardType: TextInputType.multiline,
              //textInputAction: TextInputAction.continueAction,
              onChanged: (texto) {
                descripcion = texto;
              },
            ):contendorVacio
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(!fin)? () {
          print("=> entro open camera");
          _showSelectionDialog(context);
        }:null,
        child: Icon((imageFile==null)?Icons.camera_alt:Icons.backup),
      ),
    );
  }
  void _upload() async  {
   // if (file == null) return;
    if(precio.length == 0 || descripcion.length == 0 ){
      envio = false;
      print("precio=>" + precio);
      Navigator.of(context).pop();
      _showErrorDialog(context);
    }else {
      envio = true;
      String base64Image = base64Encode(imageFile.readAsBytesSync());
      String fileName = imageFile.path.split("/").last;

      Map<String, String> _body = {
        "file": base64Image,
        "name": fileName,
      };

      http.Response response = await http.post(urlEndPointBase + urlEndPoint  , body: _body).then((res) {
        envio= false;
        fin=true;
        Navigator.of(context).pop();


       /*

        setState(() {
          fin = true;
          print("fin=>" + fin.toString());
        });*/
        print("=>ok:" + res.statusCode.toString());
        print("response=>" + res.body);
        imagenPRoducto = res.body;
        _enviarProducto();


      }).catchError((err) {
        envio= false;
        Navigator.of(context).pop();
        _showErrorDialogEnvio(context);
        print("=>erro:" +err.toString());
      });


    }



  }
   void _enviarProducto() async {
    print("=>envio  de producto");
    DateTime now = DateTime.now();
    String formattedDate = "01/10/2020";        //DateFormat("dd.MM.yyyy").format(DateTime.now());
    String newImage= urlEndPointBase + "/imagenes/"+ imagenPRoducto;

    Productos producto = new Productos(id: 0,idNegocio:idNegocio,descripcion: descripcion,precio: precio,foto:newImage,fchalta: formattedDate );
    print("url=>"+urlEndPointBase+urlEndPointProductos);
    print("producto=>" + producto.toMap().toString());
    Map data = {
      "id_negocio":idNegocio.toString(),
      "descripcion":descripcion,
      "precio":precio,
      "foto":newImage

    };
    http.Response response =  await http.post(urlEndPointBase+urlEndPointProductos  , body: data).then((res){
    print("response=>" + res.body);

      setState(() {
        fin = true;
        //print("fin=>" + fin.toString());
    });
    }).catchError((err) {
     envio= false;
     Navigator.of(context).pop();
     _showErrorDialogEnvio(context);
     print("=>erro:" +err.toString());
     });

    }
  Future<void> _showErrorDialog(BuildContext context) {
    return showDialog(context: context, child:
    new AlertDialog(
      title: new Text("Error"),
      content: new Text("Todos los campos son obligatorios"),
    )
    );
  }
  Future<void> _showErrorDialogEnvio(BuildContext context) {
    return showDialog(context: context, child:
    new AlertDialog(
      title: new Text("Error"),
      content: new Text("Todos los campos son obligatorios"),
    )
    );
  }
  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text((imageFile==null)?alertTxt:alertTxtPaso2),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    (imageFile==null)? GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ): Container(width:0,height:0),
                    Padding(padding: EdgeInsets.all(8.0)),
                    (imageFile==null)?GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    ): Container(width:0,height:0)
                    ,(imageFile!=null)?GestureDetector(
                      child: Text("Subir"),
                      onTap: () {
                        _upload();
                      },
                    ): Container(width:0,height:0)
                  ],
                ),
              ));
        });
  }
  void _openGallery(BuildContext context) async {

    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(imageFile, width: 100, height: 100);
    } else {
      return Text("Please select an image");
    }
  }
  Widget _finalizacionCorrecta() {
    return       new Scaffold(
      appBar: new AppBar(
        title: new Text('OK'),
      ),
      body:
      new Center(
        child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[


              new Icon(
                  Icons.offline_pin,
                  color: const Color(0xFF000000),
                  size: 80.0)
              ,new Text(
                "Se Agrego el nuevo producto",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize:45.0,
                    color: const Color(0xFF000000),

                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              )
            ]

        ),

      ),

    );
  }
}