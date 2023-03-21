import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_ease/constants.dart';

class InputWidget extends StatefulWidget {
  InputWidget(
      {Key? key,
      required this.constants,
      required this.title,
      required this.hintText,
      required this.controller,
      required this.isObscrue})
      : super(key: key);

  final Constants constants;
  String title;
  String hintText;
  TextEditingController controller;
  bool isObscrue;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 11),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: widget.constants.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: Get.height / 60),
            Container(
              width: double.infinity,
              height: Get.height / 17,
              decoration: BoxDecoration(
                  color: widget.constants.inputBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: widget.constants.inputStrokeColor)),
              child: TextFormField(
                controller: widget.controller,
                obscureText: widget.isObscrue,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: widget.constants.inputHintTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                  contentPadding: const EdgeInsets.all(14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
