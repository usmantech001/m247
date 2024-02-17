import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController showSnackBar({required title, required String text}) {
  return Get.snackbar(
    title,
    text,
    snackPosition: SnackPosition.TOP,
    colorText: Colors.black,
    backgroundColor: Colors.white,
  );
}
