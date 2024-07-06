import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile/main.dart';
import 'package:mobile/service/controller.dart';
import 'package:mobile/utils/dialogs/error_dialog.dart';
import 'package:mobile/utils/palette.dart';
import 'package:mobile/service/data.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  _AddressState createState() => _AddressState();
}

final _addressController = TextEditingController();

class _AddressState extends State<Address> {
  @override
  void initState() {
    super.initState();
  }

  setAddress(String address, BuildContext context) async {
    baseUrl = address;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
    await showErrorDialog(
        context, "La dirección IP ha sido actualizada a: $address");
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
                "Ingresa la dirección IP para conectarse con la base de datos",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  focusColor: Color.fromARGB(255, 29, 64, 68),
                  border: OutlineInputBorder(),
                  labelText: 'Dirección IP',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 29, 64, 68),
                    fontSize: 24.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 29, 64, 68), width: 2.0)),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String address = _addressController.text;
                  setAddress(address, context);
                  setState(() {});
                },
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
