import 'package:ambatuapp/widgets/character_appbar.dart';
import 'package:ambatuapp/widgets/character_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AnkamingPage extends StatefulWidget {
  const AnkamingPage({super.key});

  @override
  State<AnkamingPage> createState() => _AnkamingPageState();
}

class _AnkamingPageState extends State<AnkamingPage> {
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
          const CustomCharacterAppBar(),
          SliverPersistentHeader(
              pinned: true,
              delegate: CustomCharacterHeader(
                  bgUrl: 'assets/ankaming_header.jpg', text: 'Amkaming')),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.lightBlue)),
                        onPressed: () =>
                            _launchUrl('https://twitter.com/inndigold'),
                        icon: const Icon(FeatherIcons.twitter),
                        label: const Text('Check Profile')),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton.icon(
                        onPressed: () =>
                            _launchUrl('https://allmylinks.com/realeshamae'),
                        icon: const Icon(Icons.person_2),
                        label: const Text('Other Socials'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: const [
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec molestie magna a lectus lobortis, quis porttitor nibh lacinia. Curabitur tincidunt turpis luctus magna tincidunt cursus eu congue lorem. Nullam ut dictum arcu, at faucibus quam. Vivamus lacinia tellus ac urna malesuada consequat. Cras venenatis mauris non tristique malesuada. Nam et ultrices mi. Nulla molestie quam ac nisi scelerisque, eu rutrum sem euismod. Proin non nisi tellus. Mauris vehicula commodo leo non congue. Praesent et aliquet augue, sit amet dapibus justo.",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "Donec elementum hendrerit justo, ac auctor lorem lobortis et. Aenean eu auctor dui. Morbi in dolor nec nunc imperdiet aliquet. Nam ac lectus sit amet massa elementum consectetur in in sem. Nunc sodales risus sit amet ante vulputate lacinia. Donec dictum a odio sed tristique. Pellentesque ligula ligula, scelerisque sed congue sit amet, pharetra a libero. Maecenas tempus augue sed nisi pharetra euismod. Sed venenatis sem id lacus cursus, in lacinia metus auctor. Donec eleifend eget orci at semper. Nunc sagittis accumsan ipsum in lobortis. Vestibulum hendrerit euismod tempor. Mauris dapibus dictum congue."),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "Mauris ac euismod nunc. Donec nibh odio, egestas faucibus tellus non, porttitor bibendum est. Donec mattis, odio consequat convallis blandit, metus erat placerat tellus, ut aliquam erat nunc fringilla velit. Pellentesque eleifend consequat dolor at cursus. Morbi ipsum massa, luctus id sodales et, blandit nec est. Donec eget placerat ex, non posuere dolor. Curabitur eu consequat mauris. Maecenas sit amet nisl auctor, egestas sapien a, tincidunt metus. Aenean dictum lobortis nulla vitae congue."),
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
