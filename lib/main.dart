import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile/utils/dialogs/error_dialog.dart';
import 'utils/palette.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: createMaterialColor(const Color.fromARGB(255, 29, 64, 68)),
      canvasColor:
          createMaterialColor(const Color.fromARGB(255, 230, 255, 250)),
    ),
    home: const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar escaneo de QR', true, ScanMode.QR);
      int barcodeInt = int.parse(barcodeScanRes);
    } on Exception {
      barcodeScanRes = 'Failed to get platform version.';
      String errorMessage =
          "Error al escanear el código QR de la venta. Por favor, inténtelo de nuevo.";
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
        title: const Text("Tairu Escáner",
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
              Image.asset("assets/logo.png"),
              const SizedBox(height: 32.0),
              const Text(
                "Escanea el código QR de la venta para agregar artículos por su código de barras",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => scanQR(),
                style: TextButton.styleFrom(
                  backgroundColor: createMaterialColor(const Color.fromARGB(
                      255, 29, 64, 68)), // Set the background color here
                  // Set the text color (optional)
                  padding: const EdgeInsets.all(16.0),
                ),
                child: const Text("Escanear código QR de venta",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 48.0),
              const Text(
                "Alternativamente, puede ingresar el identificador de la venta manualmente:",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              const TextField(
                  decoration: InputDecoration(
                    focusColor: Color.fromARGB(255, 29, 64, 68),
                    border: OutlineInputBorder(),
                    labelText: 'Identificador de la venta',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 29, 64, 68),
                      fontSize: 24.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 29, 64, 68),
                            width: 2.0)),
                  ),
                  maxLength: 6,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => scanQR(),
                style: TextButton.styleFrom(
                  backgroundColor: createMaterialColor(const Color.fromARGB(
                      255, 29, 64, 68)), // Set the background color here
                  // Set the text color (optional)
                  padding: const EdgeInsets.all(16.0),
                ),
                child: const Text("Ingresar ID de venta",
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
