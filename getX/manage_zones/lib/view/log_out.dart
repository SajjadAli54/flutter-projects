import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manage_zones/data/constants.dart';
import 'package:manage_zones/view/login.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          const storage = FlutterSecureStorage();
          storage.write(key: MyJwtToken.token, value: "");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
        },
        child: const Icon(Icons.logout));
  }
}
