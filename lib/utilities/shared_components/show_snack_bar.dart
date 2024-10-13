import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
      required String message,
      required String title,
      VoidCallback? onClick,
      bool? isOkayButton,
      bool? isCancelButton,
    }) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message, style: const TextStyle(color: Colors.grey, fontSize: 13),),
        actions: [
          if (isOkayButton != null && isOkayButton)
            CupertinoDialogAction(onPressed: onClick ?? (){},child: const Text("Okay", style: TextStyle(color: Colors.blue),),),
          CupertinoDialogAction(child: const Text("Cancel", style: TextStyle(color: Colors.blue),), onPressed: (){
            Navigator.pop(context);
          },)
        ],
      );
    },
  );
}
