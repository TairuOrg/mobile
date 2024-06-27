import 'package:flutter/cupertino.dart';
import 'package:mobile/utils/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog<void>(
    context: context,
    title: "Aviso",
    content: text,
    optionsBuilder: () => {"OK": null},
  );
}
