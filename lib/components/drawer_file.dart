import 'package:flutter/material.dart';
import 'package:music_player/pages/Settings_page.dart';

class DrawerFile extends StatefulWidget {
  const DrawerFile({super.key});

  @override
  State<DrawerFile> createState() => _DrawerFileState();
}

class _DrawerFileState extends State<DrawerFile> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        DrawerHeader(child: Icon(
          Icons.music_note,
          size: 40,
          color: Colors.black,
          )
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text("H O M E"),
            onTap:() => Navigator.pop(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 20),
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text("S E T T I N G S"),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
              
            },
          ),
        ),
      ],
    );
  }
}
