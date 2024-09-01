import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiServices {
  ApiServices._();

  static final ApiServices apiServices = ApiServices._();

  static const String baseUrl = "";
  static const String serverKey = "";
  static const String senderId = "";

  Future<void> pushNotification({required String title, body, token}) async {
    Map payLoad = {
      'to': token,
      'notification': {
        'priority': 'high',
        'body': body,
        'title': title,
        'sound': 'default',
      },
    };
    String dataNotification = jsonEncode(payLoad);
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: dataNotification,
    );
    log(response.body);
  }
}
