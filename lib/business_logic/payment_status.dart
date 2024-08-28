import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> checkPaymentStatus(String orderId) async {
  final String serverKey = 'SB-Mid-server-KEXEZM6ynCF5Ru5tLg6pBuzA'; // Replace with your actual Midtrans server key
  final String url = 'https://api.sandbox.midtrans.com/v2/$orderId/status';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Basic ' + base64Encode(utf8.encode(serverKey + ':')),
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to check payment status');
  }
}
