import 'package:ambatuapp/pages/characters/ampassing.dart';
import 'package:ambatuapp/pages/characters/ankaming.dart';
import 'package:ambatuapp/pages/characters/axel.dart';
import 'package:ambatuapp/pages/characters/bunda.dart';
import 'package:ambatuapp/pages/characters/bus_soldier.dart';
import 'package:ambatuapp/pages/characters/daddy_amkaming.dart';
import 'package:ambatuapp/pages/characters/dreamy.dart';
import 'package:ambatuapp/pages/characters/hump_day.dart';
import 'package:ambatuapp/pages/characters/kakangku.dart';
import 'package:ambatuapp/pages/characters/nissan.dart';
import 'package:ambatuapp/pages/characters/turbulence_man.dart';
import 'package:ambatuapp/pages/characters/viktor.dart';
import 'package:ambatuapp/pages/characters/yes_king.dart';
import 'package:ambatuapp/widgets/appbar.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import '../widgets/fixed_header.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      body: Container(
        child: CustomScrollView(
          slivers: [
            const CustomAppBar(),
            SliverPersistentHeader(
              pinned: true,
              delegate: FixedHeaderDelegate(
                text: 'Characters',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const DreamyPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/dreamy.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'DreamybullXXX',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const AnkamingPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/ankaming.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Amkaming',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const DaddyAmkamingPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/daddy_amkaming.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Daddy Amkaming',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const ViktorPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/viktor.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Viktor',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const BundaPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/bunda.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Bunda Rahma',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const KakangkuPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/kakangku.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Kakangku',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const NissanPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/nissan.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Nissan',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const HumpDayPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/hump_day.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Brandon Currington',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const AmpassingPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/ampassing.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Ampassing',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const YesKingPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/yes_king.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Yes King',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const TurbulenceManPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/turbulence_man.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Turbulence Man',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const AxelPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/axel.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Axel',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const BusSoldierPage(),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/bus_soldier.png',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(8.0),
                            color: const Color.fromARGB(117, 0, 0, 0),
                            child: const Text(
                              'Bus Soldier',
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
                    childAspectRatio: 1.0)),
          ],
        ),
      ),
      drawer: const Sidebar(currentPage: 'Characters'),
    );
  }
}
