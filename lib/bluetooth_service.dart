import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothService {
  late BluetoothConnection connection;

  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      connection = await BluetoothConnection.toAddress(device.address);
      return true;
    } catch (e) {
      print('Error connecting to device: $e');
      return false;
    }
  }

  void sendMessage(String message) {
    connection.output.add(utf8.encode(message + "\r\n"));
    connection.output.allSent.then((_) {
      print('Sent: $message');
    });
  }

  void disconnect() {
    connection.close();
  }
}
