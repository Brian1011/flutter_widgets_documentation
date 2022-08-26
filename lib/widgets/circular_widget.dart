import 'package:flutter/material.dart';

class CircularWidget extends StatefulWidget {
  const CircularWidget({Key? key}) : super(key: key);

  @override
  State<CircularWidget> createState() => _CircularWidgetState();
}

class _CircularWidgetState extends State<CircularWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: const Center(
        child: CircleAvatar(
          child: Text("FLUTTER"),
        ),
      ),
    );
  }
}
