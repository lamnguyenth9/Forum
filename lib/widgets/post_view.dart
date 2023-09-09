import 'package:flutter/material.dart';

class PostView extends StatelessWidget {
  const PostView({super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:  Colors.white
              ),
              child: TextField(
                controller: controller,
                  textAlign: TextAlign.center, // Căn giữa nội dung trong TextField

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText
                ),
              ),
            ),
          );
  }
}