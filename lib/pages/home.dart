import 'dart:convert';
import 'package:ambatuapp/widgets/page_load.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/fixed_header.dart';
import '../widgets/sidebar.dart';
import '../widgets/appbar.dart';
import 'package:ambatuapp/twitter_account.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:ambatuapp/yt_search_results.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profileImageUrl = '';
  bool isError = false;
  bool isYTSearchResultListLoading = true;
  bool isTweetListLoading = true;
  bool isConnected = true;
  List<String> recentTweets = [];
  List<String> recentTweetUrls = [];
  List recentTweetIfRetweeted = [];
  List ytSearchResultUrls = [];
  List ytSearchResultTitles = [];
  List ytSearchResultThumbnails = [];
  List ytSearchResultViewCounts = [];
  List ytSearchResultUploadDates = [];
  List ytSearchResultChannelNames = [];
  List ytSearchResultChannelUrls = [];
  List ytSearchResultLikes = [];
  List ytSearchResultNumberOfSubscribers = [];
  List ytSearchResultVideoDurations = [];

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
      if (mounted) {
        setState(() {
          isConnected = false;
        });
      }
    }
  }

  Future<void> fetchUserData() async {
    const String twitterApiUrl =
        'https://api.apify.com/v2/acts/quacker~twitter-url-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq';
    const String ytSearchResultApiUrl =
        'https://api.apify.com/v2/acts/bernardo~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq';

    try {
      if (mounted) {
        setState(() {
          isYTSearchResultListLoading = true;
          isTweetListLoading = true;
        });
      }

      final ytSearchResultListResponse =
          await http.get(Uri.parse(ytSearchResultApiUrl));
      if (ytSearchResultListResponse.statusCode == 200) {
        final List fetchedYTSearchResultUrls =
            await YTSearchResults.fetchYTSearchResultUrls();
        final List fetchedYTSearchResultTitles =
            await YTSearchResults.fetchYTSearchResultTitles();
        final List fetchedYTSearchResultThumbnails =
            await YTSearchResults.fetchYTSearchResultThumbnails();
        final List fetchedYTSearchResultViewCounts =
            await YTSearchResults.fetchYTSearchResultViewCounts();
        final List fetchedYTSearchResultUploadDates =
            await YTSearchResults.fetchYTSearchResultUploadDates();
        final List fetchedYTSearchResultChannelNames =
            await YTSearchResults.fetchYTSearchResultChannelNames();
        final List fetchedYTSearchResultChannelUrls =
            await YTSearchResults.fetchYTSearchResultChannelUrls();
        final List fetchedYTSearchResultLikes =
            await YTSearchResults.fetchYTSearchResultLikes();
        final List fetchedYTSearchResultNumberOfSubscribers =
            await YTSearchResults.fetchYTSearchResultNumberOfSubscribers();
        final List fetchedYTSearchResultVideoDuration =
            await YTSearchResults.fetchYTSearchResultVideoDuration();

        if (mounted) {
          setState(() {
            ytSearchResultUrls = fetchedYTSearchResultUrls;
            ytSearchResultTitles = fetchedYTSearchResultTitles;
            ytSearchResultThumbnails = fetchedYTSearchResultThumbnails;
            ytSearchResultViewCounts = fetchedYTSearchResultViewCounts;
            ytSearchResultUploadDates = fetchedYTSearchResultUploadDates;
            ytSearchResultChannelNames = fetchedYTSearchResultChannelNames;
            ytSearchResultChannelUrls = fetchedYTSearchResultChannelUrls;
            ytSearchResultLikes = fetchedYTSearchResultLikes;
            ytSearchResultNumberOfSubscribers =
                fetchedYTSearchResultNumberOfSubscribers;
            ytSearchResultVideoDurations = fetchedYTSearchResultVideoDuration;
            isYTSearchResultListLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isError = true;
            isYTSearchResultListLoading = false;
          });
        }
      }

      final tweetListResponse = await http.get(Uri.parse(twitterApiUrl));
      if (tweetListResponse.statusCode == 200) {
        final data = json.decode(tweetListResponse.body);
        final userData = data[0];
        final twitterAccount = TwitterAccount.fromJson(userData);
        final List<String> fetchedTweets = await fetchTweets();
        final List<String> fetchedTweetUrls = await fetchTweetUrls();
        final List fetchedTweetIfRetweeted = await fetchTweetIfRetweeted();

        if (mounted) {
          setState(() {
            profileImageUrl = twitterAccount.profileImage;
            recentTweets = fetchedTweets;
            recentTweetUrls = fetchedTweetUrls;
            recentTweetIfRetweeted = fetchedTweetIfRetweeted;
            isTweetListLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isError = true;
            isTweetListLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isError = true;
          isTweetListLoading = false;
          isYTSearchResultListLoading = false;
        });
      }
    }
  }

  _launchUrl(url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  String _getTimeAgo(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    Duration timeAgo = DateTime.now().difference(dateTime);

    if (timeAgo.inDays > 365) {
      int years = (timeAgo.inDays / 365).floor();
      return "$years year${years > 1 ? 's' : ''} ago";
    } else if (timeAgo.inDays >= 30) {
      int months = (timeAgo.inDays / 30).floor();
      return "$months month${months > 1 ? 's' : ''} ago";
    } else if (timeAgo.inDays >= 1) {
      return "${timeAgo.inDays} day${timeAgo.inDays > 1 ? 's' : ''} ago";
    } else if (timeAgo.inHours >= 1) {
      return "${timeAgo.inHours} hour${timeAgo.inHours > 1 ? 's' : ''} ago";
    } else if (timeAgo.inMinutes >= 1) {
      return "${timeAgo.inMinutes} minute${timeAgo.inMinutes > 1 ? 's' : ''} ago";
    } else {
      return "Just now";
    }
  }

  String _formatViews(int views) {
    if (views >= 1000000) {
      double millions = views / 1000000;
      return millions.toStringAsFixed(1) + "m";
    } else if (views >= 1000) {
      double thousands = views / 1000;
      return thousands.toStringAsFixed(1) + "k";
    } else {
      return views.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: isConnected
            ? CustomScrollView(
                slivers: [
                  const CustomAppBar(),
                  SliverPersistentHeader(
                    delegate: _HomePageHeader(
                        // bgUrl:
                        //     'https://media.tenor.com/c3xvaQpdxZ8AAAAd/kkatmane.gif',
                        ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: FixedHeaderDelegate(
                      text: 'Videos',
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.centerLeft,
                        color: const Color.fromARGB(255, 204, 187, 235),
                      ),
                    ),
                  ),
                  isYTSearchResultListLoading
                      ? SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SkeletonItem(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 250.0,
                                      child: const SkeletonAvatar(),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        children: [
                                          const SkeletonLine(
                                            style:
                                                SkeletonLineStyle(height: 20),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                                height: 14,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3),
                                          ),
                                          const SizedBox(
                                            height: 15.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        }, childCount: 5))
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => _launchUrl(ytSearchResultUrls[index]),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 250,
                                    child: Image.network(
                                      ytSearchResultThumbnails[index],
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 5),
                                    child: Text(
                                      ytSearchResultTitles[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 18),
                                    child: Row(
                                      children: [
                                        Text(
                                          ytSearchResultChannelNames[index],
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          _formatViews(ytSearchResultViewCounts[
                                                  index]) +
                                              " views",
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          _getTimeAgo(
                                              ytSearchResultUploadDates[index]),
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                              childCount: ytSearchResultTitles.length > 5
                                  ? 5
                                  : ytSearchResultTitles.length)),
                  ytSearchResultTitles.length > 5
                      ? SliverToBoxAdapter(
                          child: Container(
                            height: 50,
                            child: Builder(
                              builder: (context) => TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/ambatuwatch');
                                },
                                child: const Text('See More'),
                              ),
                            ),
                          ),
                        )
                      : const SliverToBoxAdapter(),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: FixedHeaderDelegate(
                      text: 'Recent Tweets',
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.centerLeft,
                        color: const Color.fromARGB(255, 204, 187, 235),
                      ),
                    ),
                  ),
                  isTweetListLoading
                      ? SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 15.0),
                            child: SkeletonItem(
                              child: ListTile(
                                leading: SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      shape: BoxShape.circle,
                                      width: 50,
                                      height: 50),
                                ),
                                title: SkeletonLine(),
                              ),
                            ),
                          );
                        }, childCount: 10))
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Material(
                              child: InkWell(
                                onTap: () => _launchUrl(recentTweetUrls[index]),
                                child: Card(
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            70, 7, 0, 0),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      ListTile(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 0, 20, 10),
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
                                              child:
                                                  recentTweetIfRetweeted[index]
                                                      ? const Text(
                                                          '@dreamybullxxx Retweeted',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        )
                                                      : null,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(recentTweets[index]),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }, childCount: recentTweets.length),
                          // Other slivers...
                        ),
                ],
              )
            : Stack(
                children: const [
                  CustomScrollView(
                    slivers: [
                      CustomAppBar(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "Unable to load some bussin' information. Please check your Internet connection.",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      drawer: const Sidebar(
        currentPage: 'Home',
      ),
    );
  }
}

class _HomePageHeader extends SliverPersistentHeaderDelegate {
  // final String bgUrl;

  // _HomePageHeader({required this.bgUrl});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double fontSize = Tween<double>(begin: 64.0, end: 40.0)
        .transform(shrinkOffset / maxExtent); // Font size transition
    final ColorTween colorTween = ColorTween(
        begin: Theme.of(context).colorScheme.onSurfaceVariant, end: null);
    final Color? swipeTextColor =
        colorTween.transform(shrinkOffset / maxExtent);

    return Stack(
      fit: StackFit.expand,
      children: [
        const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          placeholderFit: BoxFit.none,
          image: AssetImage('assets/home_header.jpg'),
          fit: BoxFit.cover,
        ),
        // Just uncomment this to revert to the default .gif header
        // Don't forget to require the bgUrl again
        //
        // Image.network(
        //   bgUrl,
        //   fit: BoxFit.cover,
        //   loadingBuilder: (BuildContext context, Widget child,
        //       ImageChunkEvent? loadingProgress) {
        //     if (loadingProgress == null) {
        //       return child;
        //     }
        //     return Center(
        //       child: CircularProgressIndicator(
        //         value: loadingProgress.expectedTotalBytes != null
        //             ? loadingProgress.cumulativeBytesLoaded /
        //                 loadingProgress.expectedTotalBytes!
        //             : null,
        //       ),
        //     );
        //   },
        // ),
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
                  stops: const [
                0.5,
                1.0
              ])),
        ),
        Container(
          padding: const EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: const Text(
            "Let's get bussin'!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: 64,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 20.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(14),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Swipe down to see more",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: swipeTextColor),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Icons.swipe_down,
                  color: swipeTextColor,
                ),
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
