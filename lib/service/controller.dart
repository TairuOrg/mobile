import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/service/data.dart';
import 'package:mobile/utils/dialogs/error_dialog.dart';
import 'package:mobile/views/sale.dart';
import 'package:flutter/widgets.dart';

Future<void> getSale(String id, BuildContext context) async {
  final response = await http
      .post(Uri.parse('$baseUrl/cashier/verify-sale'), body: {"sale_id": id});

  final data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Sale()),
    );
    var cashier_name = data['body']['payload']['cashier_name'];
    var customer_name = data['body']['payload']['customer_name'];
    var sale_id = data['body']['payload']['sale_id'];
    cashierName = cashier_name;
    customerName = customer_name;
    currentSaleId = sale_id;
    itemName = "";
    itemAvailableQuantity = 0;
    barcode = "";
    quantityAdded = 0;
  } else {
    await showErrorDialog(context, data['body']['payload'].toString());
    // If the server returns an error response, throw an exception.
  }
}

Future<void> getItem(String item_barcode, BuildContext context) async {
  final response = await http.post(Uri.parse('$baseUrl/cashier/get-item'),
      body: {"barcode_id": item_barcode});
  final data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    var item_name = data['body']['payload']['name'];
    var item_available_quantity = data['body']['payload']['quantity'];
    var item_barcode = data['body']['payload']['barcode_id'];
    itemName = item_name;
    itemAvailableQuantity = item_available_quantity;
    barcode = item_barcode;
    quantityAdded = 1;
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Sale()),
    );
  } else {
    await showErrorDialog(context, data['body']['payload'].toString());
    // If the server returns an error response, throw an exception.
  }
  print("ayuda" + data);
}

Future<void> addItem(String item_barcode, String quantity, String saleId,
    BuildContext context) async {
  final response =
      await http.post(Uri.parse('$baseUrl/cashier/add-item'), body: {
    "sale_id": saleId,
    "item_barcode_id": item_barcode,
    "quantity": quantity,
  });
  final data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    await showErrorDialog(context,
        "Item añadido correctamente, recuerda actualizar la lista de items desde la web");
  } else {
    await showErrorDialog(context, data['body']['payload'].toString());
    // If the server returns an error response, throw an exception.
  }
  barcode = "";
  itemName = "";
  itemAvailableQuantity = 0;
  quantityAdded = 0;
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Sale()),
  );
}
