import 'package:ambatuapp/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widgets/sidebar.dart';

class KakangkuPage extends StatefulWidget {
  const KakangkuPage({super.key});

  @override
  State<KakangkuPage> createState() => _KakangkuPageState();
}

class _KakangkuPageState extends State<KakangkuPage> {
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
