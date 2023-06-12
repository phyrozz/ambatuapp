import 'package:flutter/material.dart';
import 'package:ambatuapp/widgets/appbar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/sidebar.dart';

class NissanPage extends StatefulWidget {
  const NissanPage({super.key});

  @override
  State<NissanPage> createState() => _NissanPageState();
}

class _NissanPageState extends State<NissanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
        ],
      ),
      drawer: Sidebar(currentPage: 'Characters'),
    );
  }
}
