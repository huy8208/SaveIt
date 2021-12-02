import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successSnackBar(String textSuccess) {
  Get.snackbar(
    'Success!',
    textSuccess,
    colorText: Colors.white,
    isDismissible: true,
    duration: const Duration(seconds: 4),
    maxWidth: 400,
    icon: const Icon(Icons.done, size: 30),
    backgroundColor: Colors.green[800],
    padding: const EdgeInsets.all(10),
  );
}
