import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QR Scanner",
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: const QRCodeWidget(),
    );
  }
}

class QRCodeWidget extends StatefulWidget {
  const QRCodeWidget({super.key});

  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  String result = "";
  double scanLinePosition = 0.0;
  late Timer _scanTimer;

  @override
  void initState() {
    super.initState();
    // Configura el temporizador para animar la línea de escaneo
    _scanTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        scanLinePosition += 2.0;
        if (scanLinePosition > 200.0) {
          scanLinePosition = 0.0;
        }
      });
    });
  }

  @override
  void dispose() {
    _scanTimer.cancel();
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Scanner"),
      ),
      body: Stack(
        children: [
          // Cámara QR en la parte superior
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          // Marco centrado para escanear
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Stack(
                children: [
                  // Línea de escaneo animada
                  Positioned(
                    top: scanLinePosition,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Texto del resultado en la parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Scan result: $result",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: result.isNotEmpty
                            ? () {
                                Clipboard.setData(ClipboardData(text: result));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Copied to clipboard"),
                                  ),
                                );
                              }
                            : null,
                        child: const Text("Copy"),
                      ),
                      ElevatedButton(
                        onPressed: result.isNotEmpty
                            ? () async {
                                final Uri url = Uri.parse(result);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Could not open URL"),
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: const Text("Open"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
