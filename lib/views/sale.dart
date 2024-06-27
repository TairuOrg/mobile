import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile/service/controller.dart';
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
      print("SCANNER" + barcodeScanRes);
      getItem(barcodeScanRes, context);
      setState(() {});
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Sale()),
      );
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

  Future<void> decreaseQuantity() async {
    try {
      if (quantityAdded > 1) {
        quantityAdded = quantityAdded - 1;

        setState(() {});
      } else {
        await showErrorDialog(
            context, "No se puede añadir menos de una unidad de un artículo.");
      }
    } on Exception {
      await showErrorDialog(
          context, "No se pudo disminuir la cantidad del artículo.");
    }
  }

  Future<void> increaseQuantity() async {
    try {
      if (quantityAdded < itemAvailableQuantity) {
        quantityAdded = quantityAdded + 1;

        setState(() {});
      } else {
        await showErrorDialog(context,
            "No se puede añadir más unidades de las que hay disponibles.");
      }
    } on Exception {
      await showErrorDialog(
          context, "No se pudo aumentar la cantidad del artículo.");
    }
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
                Expanded(
                    child: Text(
                  cashierName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                )),
              ]),
              Row(children: [
                const Text(
                  "Cliente:",
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                  customerName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                )),
              ]),
              const SizedBox(height: 16.0),
              const Divider(
                color: Color.fromARGB(255, 29, 64, 68),
                thickness: 1.0,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16.0),
              const Divider(
                color: Color.fromARGB(255, 29, 64, 68),
                thickness: 1.0,
              ),
              const SizedBox(height: 16),
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
                Expanded(
                    child: Text(
                  barcode,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                )),
              ]),
              const SizedBox(height: 16),
              Row(children: [
                const Text(
                  "Nombre:",
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                  itemName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                )),
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
                ElevatedButton(
                  onPressed: () => decreaseQuantity(),
                  style: TextButton.styleFrom(
                    backgroundColor: createMaterialColor(
                        const Color.fromARGB(255, 29, 64, 68)),
                    padding: const EdgeInsets.all(2.0),
                  ),
                  child: const Text("-",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Text(
                  quantityAdded.toString(),
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => increaseQuantity(),
                  style: TextButton.styleFrom(
                    backgroundColor: createMaterialColor(
                        const Color.fromARGB(255, 29, 64, 68)),
                    padding: const EdgeInsets.all(2.0),
                  ),
                  child: const Text("+",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                )
              ]),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  addItem(barcode, quantityAdded.toString(),
                      currentSaleId.toString(), context);
                  setState(() {});
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Sale()),
                  );
                },
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
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
