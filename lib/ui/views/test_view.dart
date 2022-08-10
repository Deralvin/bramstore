// import 'package:bramstore/constants/const.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';

// import 'package:image_picker/image_picker.dart';

// class TestView extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Base64 String',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State createState() => new MyHomePageState();
// }

// class MyHomePageState extends State {
//   late String _base64 = "";
//   final ImagePicker _picker = ImagePicker();
//   Uint8List? convertTxt;
//   // Pick an image
//   TextEditingController stringctrl = new TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     (() async {
//       http.Response response = await http.get(
//         Uri.parse(
//             "https://wallpaper-house.com/data/out/9/wallpaper2you_366962.jpg"),
//       );
//       if (mounted) {
//         setState(() {
//           _base64 = Base64Encoder().convert(response.bodyBytes);
//           print(_base64);
//         });
//       }
//     })();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_base64 == null || _base64.isEmpty) return new Container();
//     Uint8List bytes = Base64Codec().decode(_base64);
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Flutter Base64 String'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Column(
//         children: [
//           Container(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: Image.memory(
//                     bytes,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final XFile? image =
//                   await _picker.pickImage(source: ImageSource.gallery);
//               final bytes = image!.readAsBytes();
//               bytes.then((value) {
//                 print(value);
//                 String _img64 = base64Encode(value);
//                 print(_img64);
//                 setState(() {
//                   stringctrl.text = _img64;
//                   convertTxt = Base64Codec().decode(_img64);
//                 });
//               });
//               // String _img64 = base64Encode(bytes);
//             },
//             child: Text("OPen Image"),
//           ),
//           TextField(
//             controller: stringctrl,
//           ),
//           Container(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: convertTxt == null
//                       ? Container()
//                       : Image.memory(
//                           convertTxt!,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
