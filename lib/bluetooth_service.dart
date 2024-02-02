import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class fan extends GetxController{
  FlutterBlue control = FlutterBlue.instance;

  Future scanDevices() async{
    if(await Permission.bluetoothScan.request().isGranted){
      if (await Permission.bluetoothConnect.request().isGranted){
        control.startScan(timeout: Duration(seconds: 7));

        control.stopScan();
      }
    }
  }
  Stream<List<ScanResult>> get scanResults => control.scanResults;
}
