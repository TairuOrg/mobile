import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile/utils/dialogs/error_dialog.dart';
import 'package:mobile/utils/palette.dart';
import 'package:mobile/service/data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Sale extends StatefulWidget {
  const Sale({super.key});

  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  String _scanBarcode = 'Unknown';
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          createMaterialColor(const Color.fromARGB(255, 230, 255, 250)),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Añadir artículos a una venta",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        backgroundColor:
            createMaterialColor(const Color.fromARGB(255, 29, 64, 68)),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Venta en curso:",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Row(children: [
                const Text(
                  "Cajero:",
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                Text(
                  cashierName,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ]),
              Row(children: [
                const Text(
                  "Cliente:",
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                Text(
                  customerName,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ]),
              const SizedBox(height: 48),
              const Text(
                "Añadir Artículo",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => scanBarcode(),
                style: TextButton.styleFrom(
                  backgroundColor: createMaterialColor(const Color.fromARGB(
                      255, 29, 64, 68)), // Set the background color here
                  // Set the text color (optional)
                  padding: const EdgeInsets.all(16.0),
                ),
                child: const Text("Escanear código de barras",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold)),
              ),
              const Divider(),
              const SizedBox(height: 32),
              const Text(
                "Datos del artículo:",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              Row(children: [
                const Text(
                  "Código de barras:",
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                Text(
                  barcode,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ]),
              const SizedBox(height: 16),
              Row(children: [
                const Text(
                  "Nombre:",
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                Text(
                  barcode,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ]),
              const SizedBox(height: 16),
              Row(children: [
                const Text(
                  "Cant. Disponible:",
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                Text(
                  itemAvailableQuantity.toString(),
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ]),
              const SizedBox(height: 16),
              Row(children: [
                const Text(
                  "Cantidad a añadir:",
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                Text(
                  "5",
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ]),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => scanBarcode(),
                style: TextButton.styleFrom(
                  backgroundColor: createMaterialColor(const Color.fromARGB(
                      255, 29, 64, 68)), // Set the background color here
                  // Set the text color (optional)
                  padding: const EdgeInsets.all(16.0),
                ),
                child: const Text("Agregar Artículo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
