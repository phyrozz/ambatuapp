import 'package:flutter/material.dart';

class CustomProgessIndicator extends StatefulWidget {
  const CustomProgessIndicator({super.key});

  @override
  State<CustomProgessIndicator> createState() => _CustomProgessIndicatorState();
}

class _CustomProgessIndicatorState extends State<CustomProgessIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 12.0),
          Text(
            "Ambatuload...",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
