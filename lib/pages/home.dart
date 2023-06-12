import 'dart:convert';
import 'package:ambatuapp/widgets/page_load.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/fixed_header.dart';
import '../widgets/sidebar.dart';
import '../widgets/appbar.dart';
import 'package:ambatuapp/twitter_account.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profileImageUrl = '';
  bool isError = false;
  bool isLoading = true;
  bool isConnected = true;
  List<String> recentTweets = [];
  List<String> recentTweetUrls = [];
  List recentTweetIfRetweeted = [];

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
      // No internet connection
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
        final List<String> fetchedTweets = await fetchTweets();
        final List<String> fetchedTweetUrls = await fetchTweetUrls();
        final List fetchedTweetIfRetweeted = await fetchTweetIfRetweeted();

        setState(() {
          profileImageUrl = twitterAccount.profileImage;
          recentTweets = fetchedTweets;
          recentTweetUrls = fetchedTweetUrls;
          recentTweetIfRetweeted = fetchedTweetIfRetweeted;
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

// RefreshIndicator(
//         onRefresh: _refreshData,
//         child: Center(
//           child: isError
//               ? const Text(
//                   'Failed to load recent tweets. Please try again later.',
//                   style: TextStyle(fontSize: 16),
//                 )
//               : isLoading
//                   ? Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CircularProgressIndicator(),
//                           SizedBox(height: 12.0),
//                           Text(
//                             "Ambatuload...",
//                             style: TextStyle(
//                                 fontSize: 24.0, fontWeight: FontWeight.w100),
//                           ),
//                         ],
//                       ),
//                     )
//                   :

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: isConnected
            ? CustomScrollView(
                slivers: [
                  CustomAppBar(),
                  SliverPersistentHeader(
                    delegate: _HomePageHeader(
                      bgUrl:
                          'https://media.tenor.com/c3xvaQpdxZ8AAAAd/kkatmane.gif',
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: FixedHeaderDelegate(
                      text: 'Recent Tweets',
                      child: Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.centerLeft,
                        color: Color.fromARGB(255, 204, 187, 235),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final tweet = recentTweets[index];
                        return Material(
                          child: InkWell(
                            onTap: () => _launchUrl(recentTweetUrls[index]),
                            child: Card(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(70, 7, 0, 0),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    leading: ClipOval(
                                      child: Image.network(
                                        profileImageUrl,
                                        fit: BoxFit.cover,
                                        width: 50.0,
                                        height: 90.0,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: recentTweetIfRetweeted[index]
                                              ? Text(
                                                  '@dreamybullxxx Retweeted',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        SizedBox(height: 5),
                                        Text(tweet),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: recentTweets.length,
                    ),
                  ),
                  if (isLoading)
                    // Check if loading is in progress
                    SliverFillRemaining(
                      child: CustomProgessIndicator(),
                    ),
                ],
              )
            : Center(
                child: Text(
                    "Can't connect to the internet. Please check your connection."),
              ),
      ),
      drawer: const Sidebar(
        currentPage: 'Home',
      ),
    );
  }
}

class _HomePageHeader extends SliverPersistentHeaderDelegate {
  final String bgUrl;

  _HomePageHeader({required this.bgUrl});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FadeInImage(
          placeholder: AssetImage('lib/assets/loading.gif'),
          placeholderFit: BoxFit.none,
          image: NetworkImage(bgUrl),
          fit: BoxFit.cover,
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
                0.5,
                1.0
              ])),
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: Text(
            "Let's get bussin'!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w100, fontSize: 64, color: Colors.white),
          ),
        ),
        Container(
          padding: EdgeInsets.all(14),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Swipe down to see more",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Icon(Icons.swipe_down),
              ]),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 400;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
