import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class DialogsComponent {
  static Future<DialogAction> defaultDialog(BuildContext context, String? title,
      String? body, Color colorTitle) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (title == null) {
          Navigator.pop(context);
          return Container(
            height: 0,
          );
        }
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(
            title,
          ),
          content: Text(
            body ?? "",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: Text(
                'Ok',
                style: TextStyle(color: colorTitle),
              ),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
