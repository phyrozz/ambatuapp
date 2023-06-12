import 'package:ambatuapp/widgets/appbar.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import '../widgets/fixed_header.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            CustomAppBar(),
            SliverPersistentHeader(
              pinned: true,
              delegate: FixedHeaderDelegate(
                text: 'Characters',
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  color: Color.fromARGB(255, 204, 187, 235),
                ),
              ),
            ),
            SliverGrid(
                delegate: SliverChildListDelegate([
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushNamed(context,
                          '/characters/dreamy'); // Navigate to the stats page
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/assets/dreamy.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.deepPurple
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.1, 1])),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'DreamybullXXX',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushNamed(context,
                          '/characters/ankaming'); // Navigate to the stats page
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/assets/ankaming.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.deepPurple
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.1, 1])),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Ankaming',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushNamed(context,
                          '/characters/bunda'); // Navigate to the stats page
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/assets/bunda.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.deepPurple
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.1, 1])),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Bunda Rahma',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushNamed(context,
                          '/characters/kakangku'); // Navigate to the stats page
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/assets/kakangku.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.deepPurple
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.1, 1])),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Kakangku',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushNamed(context,
                          '/characters/nissan'); // Navigate to the stats page
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/assets/nissan.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.deepPurple
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.1, 1])),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Nissan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Navigator.pushNamed(context,
                          '/characters/ampassing'); // Navigate to the stats page
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('lib/assets/ampassing.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.deepPurple
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.1, 1])),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Ampassing',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0)),
          ],
        ),
      ),
      drawer: const Sidebar(currentPage: 'Characters'),
    );
  }
}
