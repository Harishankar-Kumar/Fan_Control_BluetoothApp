import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'bluetooth_service.dart';

class FanController extends StatefulWidget {
  final BluetoothDevice device;

  FanController({Key? key, required this.device}) : super(key: key);

  @override
  _FanControllerState createState() => _FanControllerState();
}

class _FanControllerState extends State<FanController> {
  BluetoothService _bluetoothService = BluetoothService();
  bool isFanOn = false;

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  void _connectToDevice() async {
    bool connected = await _bluetoothService.connectToDevice(widget.device);
    if (connected) {
      print('Connected to ${widget.device.name}');
    } else {
      print('Failed to connect to ${widget.device.name}');
    }
  }

  void _sendMessage(String message) {
    _bluetoothService.sendMessage(message);
  }

  void _toggleFan() {
    setState(() {
      isFanOn = !isFanOn;
      String message = isFanOn ? "Turn On" : "Turn Off";
      _sendMessage(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fan Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _toggleFan,
              child: Text(isFanOn ? 'Turn Off' : 'Turn On'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bluetoothService.disconnect();
    super.dispose();
  }
}
