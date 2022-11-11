import 'package:galery_app/core/resources/consts/colors.dart';
import 'package:galery_app/core/resources/consts/sizes.dart';
import 'package:galery_app/core/resources/media_query/media_query_helpers.dart';
import 'package:flutter/material.dart';

Future myConfirmDialog(
  BuildContext context, {
  String? basicContentString,
  String? title,
  String? positiveButtonText,
  String? negativeButtonText,
  Function? positiveButton,
  Function? negativeButton,
  Widget? customContent,
  List<Widget>? customActions,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? "Confirm",
          ),
        ],
      ),
      content: customContent ??
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                basicContentString ?? ""
                // "$content",
                // style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
                ,
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
      actions: [
        Container(
          margin: EdgeInsets.all(sizeNormal),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: customActions ??
                [
                  Flexible(
                    child: Container(
                      height: 45,
                      width: widthScreen(context),
                      child: ElevatedButton(
                        onPressed: () {
                          print("above if in negative");
                          if (negativeButton != null) {
                            print("inside if in negative");

                            negativeButton();
                          } else {
                            print("inside else in negative");

                            Navigator.of(context).pop();
                            // navigatorPop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sizeNormal)),
                          backgroundColor: primaryGreen,
                          side: const BorderSide(color: primaryGreen),
                        ),
                        child: Text(negativeButtonText ?? "No"),
                      ),
                    ),
                  ),
                  const SizedBox(width: sizeMedium),
                  Flexible(
                    child: Container(
                      height: 45,
                      width: widthScreen(context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sizeNormal)),
                          backgroundColor: primaryGreen,
                          side: const BorderSide(color: primaryGreen),
                        ),
                        onPressed: () {
                          if (positiveButton != null) {
                            positiveButton();
                          } else {
                            Navigator.of(context).pop();

                          }
                          // Navigator.of(context).pop();
                        },
                        child: Text(positiveButtonText ?? "Yes"),
                      ),
                    ),
                  )
                ],
          ),
        ),
      ],
    ),
  );
}
