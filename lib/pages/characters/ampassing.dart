import 'package:ambatuapp/widgets/character_appbar.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:ambatuapp/widgets/appbar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AmpassingPage extends StatefulWidget {
  const AmpassingPage({super.key});

  @override
  State<AmpassingPage> createState() => _AmpassingPageState();
}

class _AmpassingPageState extends State<AmpassingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomCharacterAppBar(),
        ],
      ),
    );
  }
}
