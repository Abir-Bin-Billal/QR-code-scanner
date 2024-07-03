import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/generate_qr_code.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "QR code scanner",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GenerateQrCode()));
              },
              icon: Icon(Icons.qr_code))
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                children: [
                  Text(
                    "Place the QR code in the areas",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning will be started automaticallly",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  )
                ],
              ),
            )),
            Expanded(
                flex: 4,
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                  ),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;
                    for (final barcode in barcodes) {
                      print("Barcode not found: ${barcode.rawValue}");
                    }
                    if (image != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  barcodes.first.rawValue ?? "No data found"),
                              content: Image(image: MemoryImage(image)),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Close"),
                                )
                              ],
                            );
                          });
                    }
                  },
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                "Developed by Abir Bin Billal",
                style: TextStyle(
                    fontSize: 14, color: Colors.black87, letterSpacing: 1),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
