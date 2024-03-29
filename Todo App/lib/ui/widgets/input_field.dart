import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
        required this.tilte,
        required this.hint,
        this.controller,
        this.widget})
      : super(key: key);
      
  final String tilte;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(tilte, style: titleStyle),
          Container(
              padding: const EdgeInsets.only(left: 14),
              margin: const EdgeInsets.only(top: 8),
              width: SizeConfig.screenWidth,
              height: 52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                      controller: controller,
                      autofocus: false,
                      readOnly: widget != null ? true : false,
                      style: subTitleStyle,
                      cursorColor:
                      Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subTitleStyle,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: context.theme.backgroundColor,
                              width: 0,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: context.theme.colorScheme.background, width: 0)),
                      ),
                    )),
                widget ?? Container(),
              ]))
        ]));
  }
}
