import 'dart:convert';
import 'dart:developer';
import 'package:firebase_chat_app/services/get_servert_token.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  ApiServices._();

  static final ApiServices apiServices = ApiServices._();

  static const String baseUrl =
      "https://fcm.googleapis.com/v1/projects/chat-app-f34d5/messages:send";
  static String serverKey = generatedToken;
  static const String senderId = "";

  Future<void> pushNotification({required String title, body, token}) async {
    Map payLoad = {
      "message": {
        "token": token,
        // "eKSe_HOBTDeGyTk3QCeE6P:APA91bGDaqM5KslxVS6xhcEd57XKq6G5JeKA-dZXodLrbObfXfOK-YvHgQuSk3U_m__p8mKwZKES9UBXat6j8R9W7y8LXINwPP6iKXx9vI8z2cwqzBlJ26ZklgBE8-nzmiG0oI8cwkAC",
        "notification": {"title": title, "body": body},
        "data": {"response": "Message Done !"}
      }
    };
    String dataNotification = jsonEncode(payLoad);
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $generatedToken',
      },
      body: dataNotification,
    );
    if (response.statusCode == 200) {
      print('Successfully sent message: ${response.body}');
    } else {
      print('Error sending message: ${response.body}');
    }
    log(response.body);
  }
}

String generatedToken = "ya29.a0AcM612zUrUHdDzFQKoXBOVywkdPysYG1imMhiLTnYQ-ajfBkIlLDcL_SroI991J_6Po_Dohlc1l4CJ6wl8KCJrsBbnEKrbAP3SgK8lNkQY5AqI8LY__TBsHBGuCmUkSO6AV9EFz7WOwDUPOTDXeP8EMmEIGrBbtmVVpS1WRXaCgYKATUSARESFQHGX2MiP8IEw2pqXNMtVrgSqeP_Kw0175";