import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_face_identification/flutter_face_identification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _result;

  @override
  void initState() {
    FlutterFaceIdentification.initSdk(
      iosClientId: '22333af7a4f841e088c831ad79c4cb5c04f0',
      androidClientId: '22333af7a4f841e088c831ad79c4cb5c04f0',
      iosAppUrlScheme: 'caminhang',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('人脸识别测试'),
              ElevatedButton(
                onPressed: () async {
                  await FlutterFaceIdentification.faceIdentify(
                          mobile: '15851323272')
                      .then((value) {
                    print('认证成功！ result = $value');
                    setState(() {
                      _result = '认证成功！！！！';
                    });
                  }).onError((error, stackTrace) {
                    print('认证失败 error= $error');
                    setState(() {
                      _result = '认证失败 error= ${error.toString()}';
                    });
                  });
                },
                child: const Text('跳转实名认证'),
              ),
              Text(
                _result ?? '待认证...',
                style: const TextStyle(color: Colors.red, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
