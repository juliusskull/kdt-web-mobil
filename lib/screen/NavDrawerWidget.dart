import 'package:flutter/material.dart';
import 'package:flutter_app_web/screen/PhotoPreviewScreen.dart';
import 'package:flutter_app_web/screen/productoList.dart';

import 'NegocioOne.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Kdt',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Comprar'),
            onTap: () => {
              Navigator.of(context).push(
               MaterialPageRoute(builder: (context) => ProductoListScreen()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Vender'),
            onTap: () => {
            Navigator.of(context).push(
                 MaterialPageRoute(builder: (context) => PhotoPreviewScreen()),
             )
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Tu Negocio'),
            onTap: () => {   Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NegocioOne()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}