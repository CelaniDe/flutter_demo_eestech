import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart' as scanner;
import 'package:flutter/services.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Future<void> scanBarcode() async {
    try {
      final barcodeScanRes = await scanner.BarcodeScanner.scan();

      // Do something with the scanned barcode value
      print('Scanned barcode: ${barcodeScanRes.rawContent}');
    } on PlatformException catch (e) {
      if (e.code == scanner.BarcodeScanner.cameraAccessDenied) {
        print('Camera permission denied');
      } else {
        print('Error: $e');
      }
    } on FormatException {
      print('Scan cancelled');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Scan Barcode'),
            ),
          ],
        ),
      ),
    );
  }
}
