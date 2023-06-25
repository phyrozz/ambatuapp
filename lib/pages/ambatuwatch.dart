import 'package:ambatuapp/widgets/appbar.dart';
import 'package:ambatuapp/widgets/fixed_header.dart';
import 'package:ambatuapp/widgets/sidebar.dart';
import 'package:ambatuapp/yt_search_results.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:skeletons/skeletons.dart';

class AmbatuWatchPage extends StatefulWidget {
  const AmbatuWatchPage({super.key});

  @override
  State<AmbatuWatchPage> createState() => _AmbatuWatchPageState();
}

class _AmbatuWatchPageState extends State<AmbatuWatchPage> {
  bool isError = false;
  bool isLoading = true;
  bool isConnected = true;
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
          isLoading = true;
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
            isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isError = true;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isError = true;
          isLoading = false;
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
            ? LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return CustomScrollView(
                    slivers: [
                      const CustomAppBar(),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: FixedHeaderDelegate(
                          text: 'AmbatuWatch',
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.centerLeft,
                            color: const Color.fromARGB(255, 204, 187, 235),
                          ),
                        ),
                      ),
                      isLoading
                          ? SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SkeletonItem(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 250.0,
                                          child: SkeletonAvatar(),
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            children: [
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                    height: 20),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                    height: 14,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3),
                                              ),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            }, childCount: 10))
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () =>
                                        _launchUrl(ytSearchResultUrls[index]),
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height: 250,
                                            child: Image.network(
                                              ytSearchResultThumbnails[index],
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 18),
                                            child: Row(
                                              children: [
                                                Text(
                                                  ytSearchResultChannelNames[
                                                      index],
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  _formatViews(
                                                          ytSearchResultViewCounts[
                                                              index]) +
                                                      " views",
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  _getTimeAgo(
                                                      ytSearchResultUploadDates[
                                                          index]),
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                childCount: ytSearchResultTitles.length,
                              ),
                            ),
                    ],
                  );
                },
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
        currentPage: 'AmbatuWatch',
      ),
    );
  }
}
