import 'package:ambatuapp/widgets/character_appbar.dart';
import 'package:ambatuapp/widgets/character_header.dart';
import 'package:flutter/material.dart';

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
          const CustomCharacterAppBar(),
          SliverPersistentHeader(
              pinned: true,
              delegate: CustomCharacterHeader(
                  bgUrl: 'assets/kakangku.jpg', text: 'Kakangku')),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: const [
                    SizedBox(
                      height: 200,
                    ),
                    Center(
                      child: Text(
                        'This page is under construction. Stay tuned!',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
      drawer: const Sidebar(currentPage: 'Characters'),
    );
  }
}
