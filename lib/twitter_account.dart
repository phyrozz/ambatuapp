import 'dart:convert';
import 'package:http/http.dart' as http;

class TwitterAccount {
  final String username;
  final String handleName;
  final String createdAt;
  final String profileImage;
  final String bannerImage;
  final String description;
  final String location;
  final String url;
  final int followersCount;
  final int friendsCount;

  TwitterAccount({
    required this.username,
    required this.handleName,
    required this.createdAt,
    required this.profileImage,
    required this.bannerImage,
    required this.description,
    required this.location,
    required this.url,
    required this.followersCount,
    required this.friendsCount,
  });

  factory TwitterAccount.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return TwitterAccount(
      username: user['name'],
      handleName: user['screen_name'],
      createdAt: user['created_at'],
      profileImage: user['profile_image_url_https'],
      bannerImage: user['profile_banner_url'],
      description: user['description'],
      location: user['location'],
      url: user['url'],
      followersCount: user['followers_count'],
      friendsCount: user['friends_count'],
    );
  }
}

Future<List<String>> fetchTweets() async {
  final response = await http.get(Uri.parse(
      'https://api.apify.com/v2/acts/quacker~twitter-url-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final List<dynamic> items = jsonData;

    final List<String> tweets =
        items.map((item) => item['full_text'] as String).toList();
    final List<String> tweetUrls =
        items.map((item) => item['url'] as String).toList();

    return tweets;
  } else {
    throw Exception('Failed to fetch tweets');
  }
}

Future<List<String>> fetchTweetUrls() async {
  final response = await http.get(Uri.parse(
      'https://api.apify.com/v2/acts/quacker~twitter-url-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final List<dynamic> items = jsonData;

    final List<String> tweetUrls =
        items.map((item) => item['url'] as String).toList();

    return tweetUrls;
  } else {
    throw Exception('Failed to fetch tweet URLs');
  }
}

Future<List> fetchTweetIfRetweeted() async {
  final response = await http.get(Uri.parse(
      'https://api.apify.com/v2/acts/quacker~twitter-url-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final List<dynamic> items = jsonData;

    final List tweetIfRetweeted =
        items.map((item) => item['is_retweet']).toList();

    return tweetIfRetweeted;
  } else {
    throw Exception('Failed to fetch tweet URLs');
  }
}
