import 'dart:convert';
import 'package:ambatuapp/widgets/page_load.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/sidebar.dart';
import 'package:http/http.dart' as http;
import 'package:ambatuapp/twitter_account.dart';
import 'package:url_launcher/url_launcher.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  String profileImageUrl = '';
  String bannerImageUrl = '';
  String name = '';
  String handle = '';
  String bio = '';
  String location = '';
  String bioUrl = '';
  int followers = 0;
  int following = 0;
  bool isError = false;
  bool isLoading = true;
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    fetchUserData();
  }

  Future<void> _refreshData() async {
    await checkConnectivity();
    await fetchUserData();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    }
  }

  Future<void> fetchUserData() async {
    final String apiUrl =
        'https://api.apify.com/v2/acts/quacker~twitter-url-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'; // Replace with your JSON URL

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userData = data[0];

        final twitterAccount = TwitterAccount.fromJson(userData);

        setState(() {
          profileImageUrl = twitterAccount.profileImage;
          bannerImageUrl = twitterAccount.bannerImage;
          name = twitterAccount.username;
          handle = twitterAccount.handleName;
          bio = twitterAccount.description;
          location = twitterAccount.location;
          bioUrl = twitterAccount.url;
          followers = twitterAccount.followersCount;
          following = twitterAccount.friendsCount;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  _launchUrl(url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Center(
          child: isConnected
              ? CustomScrollView(
                  slivers: [
                    CustomAppBar(),
                    SliverPersistentHeader(
                      delegate: _ProfileHeader(
                          profileImageUrl: profileImageUrl,
                          bannerImageUrl: bannerImageUrl),
                      pinned: true,
                    ),
                    if (isLoading)
                      SliverFillRemaining(
                        child: CustomProgessIndicator(),
                      ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        ListTile(
                          title: Text(
                            name,
                            textScaleFactor: 1.4,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '@$handle',
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            bio,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Followers: '),
                            Text(
                              '$followers',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(width: 16),
                            Text('Following: '),
                            Text(
                              '$following',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_pin),
                            Text('$location')
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.lightBlue)),
                                  onPressed: () => _launchUrl(
                                      'https://www.twitter.com/dreamybullxxx'),
                                  icon: Icon(Icons.exit_to_app),
                                  label: const Text('Open on Twitter')),
                              SizedBox(
                                height: 5.0,
                              ),
                              ElevatedButton(
                                onPressed: () => _launchUrl(bioUrl),
                                child: const Text('Follow on JustFor.Fans'),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    if (isError)
                      const SliverFillRemaining(
                        child: Text(
                          'Failed to retrieve information. Please try again later.',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                  ],
                )
              : Center(
                  child: Text(
                      "Can't connect to the internet. Please check your connection."),
                ),
        ),
      ),
      drawer: const Sidebar(currentPage: 'Stats'),
    );
  }
}

class _ProfileHeader extends SliverPersistentHeaderDelegate {
  final String profileImageUrl;
  final String bannerImageUrl;

  _ProfileHeader({required this.profileImageUrl, required this.bannerImageUrl});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  bannerImageUrl,
                )),
          ),
          height: 350.0,
        ),
        Container(
          height: 350.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                Colors.grey.withOpacity(0.0),
                Theme.of(context).primaryColor,
              ],
                  stops: [
                0.0,
                1.0
              ])),
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            radius: 60.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(profileImageUrl),
              radius: 50.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
