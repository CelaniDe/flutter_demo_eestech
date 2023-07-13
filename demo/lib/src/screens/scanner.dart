import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

Future<void> scanBarcode() async {
  try {
    String barcode = await BarcodeScanner.scan(); // Scan the barcode

    // Do something with the barcode value (e.g., display it)
    print('Scanned barcode: $barcode');
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      // Handle camera access denied error
      print('Camera permission denied');
    } else {
      // Handle other exceptions
      print('Error: $e');
    }
  } on FormatException {
    // User pressed the back button or cancelled the scan
    print('Scan cancelled');
  } catch (e) {
    // Handle other exceptions
    print('Error: $e');
  }
}
