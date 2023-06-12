import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ambatuapp/widgets/appbar.dart';

import '../../widgets/sidebar.dart';

class BundaPage extends StatefulWidget {
  const BundaPage({super.key});

  @override
  State<BundaPage> createState() => _BundaPageState();
}

class _BundaPageState extends State<BundaPage> {
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
