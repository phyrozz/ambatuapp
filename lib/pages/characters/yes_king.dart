import 'package:ambatuapp/widgets/character_appbar.dart';
import 'package:ambatuapp/widgets/character_header.dart';
import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

class YesKingPage extends StatefulWidget {
  const YesKingPage({super.key});

  @override
  State<YesKingPage> createState() => _YesKingPageState();
}

class _YesKingPageState extends State<YesKingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomCharacterAppBar(),
          SliverPersistentHeader(
              pinned: true,
              delegate: CustomCharacterHeader(
                  bgUrl: './lib/assets/yes_king_header.jpg', text: 'Yes King')),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
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
      drawer: Sidebar(currentPage: 'Characters'),
    );
  }
}