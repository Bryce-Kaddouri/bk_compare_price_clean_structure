import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogWidget{
  static void showSuccessDialog(String message){
    Get.snackbar(
        'Success',
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
    );
  }

  static void showErrorDialog(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
    );
  }
}