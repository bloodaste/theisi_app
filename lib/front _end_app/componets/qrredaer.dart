import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:theisi_app/service/qrdatabase.dart';

class QrReader extends StatefulWidget {
  const QrReader({super.key});

  @override
  State<QrReader> createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  Barcode? barcodescanner;
  Qrdatabase rfid = Qrdatabase();
  bool _isProcessing = false; // Prevents multiple detections

  Future<void> savingqr(String nameoftheqr) async {
    if (!context.mounted) return;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New RFID found'),
          content: Text('RFID: $nameoftheqr'),
          actions: [
            TextButton(
              onPressed: () {
                rfid.addqr(nameoftheqr); // Save the QR in Firestore
                Navigator.pop(context);
                setState(() {
                  _isProcessing = false; // Reset flag to allow new scans
                });
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _isProcessing = false; // Reset flag when canceled
                });
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (capture) {
                if (_isProcessing) return;

                final barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    setState(() {
                      _isProcessing = true; // Prevent further detections
                      barcodescanner = barcode;
                    });

                    print('Barcode found: ${barcode.rawValue}');

                    // Show dialog AFTER scanning
                    savingqr(barcode.rawValue ?? 'Unknown');
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
