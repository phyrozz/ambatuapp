import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 8,
              strokeCap: StrokeCap.round,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              text ?? "",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
