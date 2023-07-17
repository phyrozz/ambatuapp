import 'package:ambatuapp/widgets/appbar.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';

import '../widgets/fixed_header.dart';

class AmbatuGamesPage extends StatelessWidget {
  const AmbatuGamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBar(),
          SliverPersistentHeader(
            pinned: true,
            delegate: FixedHeaderDelegate(
              text: 'AmbatuGames',
              child: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                color: const Color.fromARGB(255, 204, 187, 235),
              ),
            ),
          ),
          SliverGrid(
              delegate: SliverChildListDelegate([
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/games/ambatugame');
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/ambatutap_header.jpg',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.all(8.0),
                          color: const Color.fromARGB(75, 0, 0, 0),
                          child: const Text(
                            'AmbatuTap',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/games/ambatusnake');
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/ambatusnake_header.jpg',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.all(8.0),
                          color: const Color.fromARGB(75, 0, 0, 0),
                          child: const Text(
                            'AmbatuSnake',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/games/ambatublou');
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/ambatublou_header.jpg',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.all(8.0),
                          color: const Color.fromARGB(75, 0, 0, 0),
                          child: const Text(
                            'Ambatublou',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/games/flappyBus');
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/flappy_bus.png',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.all(8.0),
                          color: const Color.fromARGB(75, 0, 0, 0),
                          child: const Text(
                            'Flappy Bus',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 1.0))
        ],
      ),
      drawer: const Sidebar(currentPage: 'AmbatuGames'),
    );
  }
}
