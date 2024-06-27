import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/service/data.dart';
import 'package:mobile/utils/dialogs/error_dialog.dart';
import 'package:mobile/views/sale.dart';
import 'package:flutter/widgets.dart';

Future<void> getSale(String id, BuildContext context) async {
  final response = await http.post(
      Uri.parse('http://192.168.0.199:4000/cashier/verify-sale'),
      body: {"sale_id": id});

  final data = jsonDecode(response.body);
  print("jaja" + data.toString());
  if (response.statusCode == 200) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Sale()),
    );
    var cashier_name = data['body']['payload']['cashier_name'];
    var customer_name = data['body']['payload']['customer_name'];
    cashierName = cashier_name;
    customerName = customer_name;
  } else {
    await showErrorDialog(context, data['body']['payload'].toString());
    // If the server returns an error response, throw an exception.
  }
}
