import 'package:flutter/material.dart';
import 'package:password_manager/app/core/custom_widgets/custom_text_widget.dart';



// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  String imageUrl;

  CustomTextWidget text;

  CustomAppBar({
    required this.imageUrl,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent, width: 1),
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color(0xFFFF008B),
                Color(0xFF00FFD3),
              ]),
              boxShadow: [
                BoxShadow(color: Color.fromARGB(50, 255, 0, 140), blurRadius: 10, spreadRadius: 4, offset: Offset(-2, -2)),
                BoxShadow(
                  color: Color.fromARGB(50, 0, 255, 213),
                  blurRadius: 7,
                  spreadRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
              radius: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          text,
        ],
      ),
    );
  }
}