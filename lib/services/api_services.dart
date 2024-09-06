import 'dart:convert';
import 'dart:developer';
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
        'Authorization': 'Bearer $serverKey',
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

String generatedToken =
    "ya29.c.c0ASRK0GZ3iV3e2NFCv3pFEB-mWYh35sdVNG-K0luZN6AWInLUUQHNZR79e_l6xIMwFl4iyx7VL9bBEnyJBN2-NWNVWFFo6tNuN3QJ-UknpxYz_IFsBYBdwfhEzeZiFXRnJ_NI-3RuDQXrBwd_w7Z5oAwXQktY4boKYWxcZ7NsJ1MEiygn7kAaHh2MXzM-tuuUMBrAm5H1EONGBItlN4biWf3R4ij11FxB3UZdfs0DFReBo-JATIaQt3lAN1FpsgPissw7LslRFR6RyVaxN5lrSfvEuHC1Nowa7P-0Ud2bBqEVahfyf5YfgXhZmggBpl7M2iPkW-CwD8T2zpnfb0zhZWWkm0YDPq0qhjJVHNhluUixN1XjNsBrYeExN385Pw5bV7346OSlB4yoQbRXduB1aSxQ_Y8nudR4YWdFBz-xlwvB9XI4JV9h4vxhovuhOexpaw73UrxUu2XpgmdMx0O-xohxZtvSaFmwk5qxrvYlZi9VO-b44Bpz5_leBQt32Q7pMbOZuxddyvqOn_s-u55XvOXYwpVZdy_ZuIpBd2tU5_shi4JVh-u0nSf0lftrBhWcjlaFs-94yWOR5OqlsX-mJ5ltqbIaxySRBhmidUY-7bjM95ssjnb_4ivqM662latUydMzOQqyfmxQwFId9dZ4u0lMe0VM17mm1ns_S1nu62u6uXbZjRhwzYw5bJRkqlVBclviJhbz8jnl_Z21OpWob21OoikbX9RzUauQFwB0nBMdut0qSQ75msjSbmSMWY_687lcsoOcl3jyznWQect9156Z8JRZFZe-oOJJhlpS9lMQaj7XvqIYgViy-btYh6vUuRIJh_dY_OfhnqB3qX-vclhovlMxSW5dVQUrs0X8qoegmbtk_ZZqbUk0hl50JhZW2aJ7u4kfgIs5V1zFyIolBjVyxYJQ0bgi3QoWxJmnzaqd5e1VaRRiqsIvZQ6afdx0BWqF4zq3-JY7tsY4abkBVZj9Q6iSe5iqJ2FbR1RROyns4a9OM-uii0M";
