import 'package:ambatuapp/widgets/character_appbar.dart';
import 'package:ambatuapp/widgets/character_header.dart';
import 'package:ambatuapp/widgets/character_video_header.dart';
import 'package:ambatuapp/widgets/fixed_header.dart';
import 'package:ambatuapp/widgets/youtube_player.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ambatuapp/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/sidebar.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DreamyPage extends StatefulWidget {
  const DreamyPage({super.key});

  @override
  State<DreamyPage> createState() => _DreamyPageState();
}

class _DreamyPageState extends State<DreamyPage> {
  _launchUrl(url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomCharacterAppBar(),
          SliverPersistentHeader(
              pinned: true,
              delegate: CustomCharacterHeader(
                  bgUrl: './lib/assets/dreamybull_header.jpg',
                  text: 'DreamybullXXX')),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.lightBlue)),
                        onPressed: () =>
                            _launchUrl('https://www.twitter.com/dreamybullxxx'),
                        icon: Icon(FeatherIcons.twitter),
                        label: Text('Check Profile')),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context); // Close the drawer
                          Navigator.pushNamed(
                              context, '/stats'); // Navigate to the stats page
                        },
                        icon: Icon(Icons.trending_up),
                        label: Text('Check Stats'))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      child: const Text(
                        '"'
                        r"Incredible! However, if your energy in your pseudo-mind is not conducive or, yeah, I like the word conducive to what I'm saying or what I'm feeling, then there's incompatibility. So how do you know that? How do you fix that? Well, first you have to understand. You have to look at yourself and say, what kind of energy or what kind of pseudo power do I have to set my atmosphere? Woooooah, That's good. What kind of pseudo-energy do I have that I can create?"
                        '"',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      r"Perrell Brown, more known by his online name DreamybullXXX, is an internet personality, most notable for his workout videos on Twitter.",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "DreamybullXXX was born on April 20, 1989 in Barangay Ambasing, Sagada, Philippines. His Japanese parents migrated to the Philippines in 1981 during the insurgency of Badublou on their hometown that began right after the kamikaze death of his grandfather, Amuba Tokamu."),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        r'His workout career on Twitter began to blow up after the success of his promotional campaign in early 2021, showing his entire body to many of his twitter followers doing the so-called "Bussing Challenge". This led to more engagement on his Twitter account and pushing him to pursue his bodybuilding career even more.'),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
