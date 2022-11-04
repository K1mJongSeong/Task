import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/services/notification_services.dart';

import '../services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifiHelper;
  @override
  void initState() {
    super.initState();
    notifiHelper=NotifyHelper();
    notifiHelper.initializeNotification();
    notifiHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
      body: Column(
    children: const [
      Text('Theme Datazzzz',
    style: TextStyle(fontSize: 30),)
      ],),
    );
  }

  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifiHelper.displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode?"Activated Dark Theme":"Activated Light Theme"
          );

          notifiHelper.scheduledNotification();
        },
        child: Icon(Icons.nightlight_round,size: 20,),
      ),
      actions: [
        Icon(Icons.person,size: 20,),
        SizedBox(width: 20,)
      ],
    );
  }
}
