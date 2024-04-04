import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PermissionOfPhotos {
  Future<bool> getFromGallery(BuildContext context) async {
    var platform = Platform.isIOS ? Permission.photos : Permission.storage;
    var stauts = await platform.status;
    await platform.request();
    Get.log("status  $stauts ");
    if (await platform.status.isDenied) {
      // Permission.systemAlertWindow.isPermanentlyDenied;
      if (Platform.isIOS) {
        await platform.request();
      } else {
        showDeleteDialog(context,"Enfil Libra app requires access to the gallery to upload pictures");
      }
      
      return false;
    } else if (await platform.status.isPermanentlyDenied) {
      if (Platform.isIOS) {
        showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text("Settings"),
                  content: Text(
                      "Enfil Libra want to access camera open settings and give permission"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Not now"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => openAppSettings(),
                      child: Text("iOS Settings"),
                    )
                  ],
                ));
      } else {
        showDeleteDialog(context,"Enfil Libra  app requires access to the gallery to upload pictures");
      }
  
      return false;
    } else if (await platform.isGranted) {
      return true;
    } else if (await platform.isLimited) {
 
      return true;
    }
  
    return false;
  }
  Future<bool> getFromCamera(BuildContext context) async {
    //var status = await Permission.camera.status;
    var status = await Permission.camera.status; //
    await Permission.camera.request();
    if (await Permission.camera.status.isDenied) {
      if (Platform.isIOS) {
        await Permission.camera.request();
      } else {
        showDeleteDialog(context,"Enfil Libra  app requires access to the camera to upload pictures");
        return false;
      }
    }
    if (await Permission.camera.status.isPermanentlyDenied) {
      if (Platform.isIOS) {
        showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text("Settings"),
              content: Text(
                  "Enfil Libra want to access camera open settings and give permission"),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Not now"),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  child: Text("iOS Settings"),
                  onPressed: openAppSettings,
                )
              ],
            ));
      } else {
        showDeleteDialog(context,"Enfil Libra  app requires access to the camera to capture pictures");
      }
      
      return false;
    } else if (await Permission.camera.isGranted ||
        await Permission.camera.isLimited) {
      return true;
    }

    return false;
  }
}



showDeleteDialog(BuildContext context,String text) {
  // set up the buttons
  Widget cancelButton = GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Text(
      "Not now",
      style: TextStyle(fontSize: 12),
    ),
  );
  Widget continueButton = GestureDetector(
    onTap: () async {
      openAppSettings();
    },
    child: Text("Open settings".tr,
        style: TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    actionsPadding: EdgeInsets.only(right: 15, bottom: 15),
    // shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(36.0))),
    title: Text(
      "Settings".tr,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    ),
    content: Text(
      text
          .tr,
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
