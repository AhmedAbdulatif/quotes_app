import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_app/core/utils/app_colors.dart';
import 'package:quotes_app/core/utils/app_strings.dart';

void showErrorDialogue(
    {required BuildContext context, required String message}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  primary: Colors.black,
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              child: const Text(AppStrings.ok),
            ),
          ],
        );
      });
}

void showToast({required String message, Color? color, ToastGravity? gravity}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: color ?? AppColors.primaryColor,
    gravity: gravity ?? ToastGravity.BOTTOM,
  );
}
