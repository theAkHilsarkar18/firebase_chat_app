import 'dart:convert';
import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class GetServerToken {
  GetServerToken._();
  static final GetServerToken instance = GetServerToken._();

  Future<void> getServerToken() async {
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final json = jsonEncode(privateKey);
    final clientCredentials = ServiceAccountCredentials.fromJson(json);
    final client = await clientViaServiceAccount(clientCredentials, scopes);
    try {
      final serverToken = client.credentials.accessToken.data;
      log("Server token: \n\n$serverToken  \n\n|");
    } catch (e) {
      log("Server token error: $e");
    }
  }
}

////////////////////////
final privateKey = {
  "type": "service_account",
  "project_id": "chat-app-f34d5",
  "private_key_id": "4c1ca53ef5e773463c4df82a94b8c0a6e16650fc",
  "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCycCiAQCVjvZLZ\nocbmkN1m9fywQy11Sly5ODS7zWENXTrTsggIuC2G7K905tOgfkvHoaj4Aiam8QTB\nGyFf3xusTTdJxv7H7YlzFpsC2skI/Y7mUBcOjcR0YRiAztl+UkR2l3c49iivh1ya\n85SYJNZqvR/vjrhEjitFkB0xsZfaCnPgS9L0trfcikr/kZDCY0+lGG7bWDpQ8PLJ\nk09ajjaUKCUnXOrbkDQVIrzoThstxrd/vVXPUmwIsjU8+gq7+uJASrVjoz+x56fr\nDQJp2wuGPujc80O44S7P/vltfA8Av3UjBP3LAmXKxvymXQoaaknn5GBmk/riJTUg\n4JJUX315AgMBAAECggEAD3e7ewqUcyXuweDNLhVmq9Ms+VaJbT5p9UBTCeiOvirT\nu6AWJDNa9vQzbW3I8IOiLAbub7k4AoaoA9lHNllPu8rhvQp78Xa80HYoL8IpZRcd\nuQc+SGuvmOsFxbyoi9OzzZfppM1pz3VraJ8uxVWEJLKKPyje/kpYo+oPLcyYPjU+\np5O3MRS/11Z6DZsv4v8MSOJ5Tvu6HUGSXtEQeUnOic7YuSOBQLifPaHSKW4EK2zI\n9DKUl4hUSGBFB8Y6gtcLLuYbnzt7+zUQ22V2YuFiiTzOszpD3JmvqGs7nd3yaFzI\nkdI8NQd2YtyTjrS/1CJhtAvGSXJGDG1CrsYq1GMGNQKBgQDgI+g23gnm7hOLNCMU\nDijh7ZfjsvHIy7Yil6yrWjsl+Tq9RBIj+ubZ1pLltbUWUB7QjZXswstmI20y7VCd\nCYeR+WeDS2LHDHieZ+Il8tKx9wtYAiVCJ+IKfXO5vDvu/OmxJDfhIK4n+eCE/miM\ndkYZgmvY/Mahc5sLn+jNlFDwbwKBgQDLzTnNWd2q2Ypg+ryDXXDZ9b6KdhYXti6H\nLRrPVeKv1AycNME6f2wdQ20EP7PwekuNUUG8f+QV3GmU2jeiAvO9meEk91n3jlwQ\nHaCS/2bq0BNwaHuVMnnV3Sk8fQrwXrequ6q6X0UU7gMnQHpNYm5HcvfQw9tXauAu\ndYdbAjcUlwKBgFrHUDKApUQJYpL7j8V8oqQ2ZVEMVY68qszB32YbCl+r3FVxb2Nx\nJ/RMSnyMpoYd9w0CexlEH7sDWCPLJ94iUO0XNQxhCOWTMHr/mgFCooD/jHGdlNeB\nbbRP8QHlseRuPHvJLnSYltCMDJnwrAlPkb6dKu7cGdqkBsSjhFdW3Z0zAoGAAU/y\n/VWEzeLUt0cmC5qAbYbdkTqtbb2okwpBT/B3ozY0VpUoYV4MriuO+iYG3JeNAP3y\n9GnGaDWhIGo/TXXDaAcjof9NvwBVq2zlacznNr/cQC8MDKvkiPIBn/gWJ/IUMK9A\nrC6M3VOjBY+uuezWVPNykQ+RzABOLT5ofreG70UCgYBXXXEAWrDuSq97lJ1dferu\n6VNt+FM+F478Rr8qugkwN6Y0MXnkOKrAtR73wqwX75MQ57Q0aUoKAN1db+j/tXJ7\nPpOsRV9CzBMyI6VeWWL+uaklR/CfvgGGDIMpVWkUj1/VFxYb7vshQYHxGOdCp+0i\nugK/r45tYYA4xWsHpzqnGA==\n-----END PRIVATE KEY-----\n",
  "client_email":
      "firebase-adminsdk-tu4es@chat-app-f34d5.iam.gserviceaccount.com",
  "client_id": "107242785258570795393",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-tu4es%40chat-app-f34d5.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
};
