
import 'package:flutter/material.dart';
import 'package:fan_control/bluetooth_service.dart';
import 'package:get/get.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState()=>_MyHomePageState();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('scanner'),
      ),
    body: GetBuilder<fan>(
    init: fan(),
    builder: (fan controller)
    {
      return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
    children: [
      StreamBuilder<List<ScanResult>(stream: controller.scanResults, builder:(context.snapshot){
        if(snapshot.hasData){
          return ListView.builder(itemBuilder: (context,index){
            final data = snapshot.data(index);
            return Card(elevation: 2, child: ListTile(title: Text(data.device.name),
    subtitle: Text(data.device.id.id),
    trailing: Text(data.rssi.toString())
    ,)
    ,)
    })
    }
        else{
          return Center(child: Text ("No Device Found"),);
    }
    })
      SizedBox(height: 10,),
      ElevatedButton(onPressed:()=>controller.scanDevices(), child: Text("SCAN"))
    ],
      ),
      )
    },
    ),
  }
}
