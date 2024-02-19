import 'dart:convert';
import 'package:http/http.dart' as http;

class YTSearchResults {
  static Future<List<String>> fetchYTSearchResultUrls() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List<String> result =
          items.map((item) => item['url'] as String).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result URLs');
    }
  }

  static Future<List<String>> fetchYTSearchResultTitles() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List<String> result =
          items.map((item) => item['title'] as String).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result titles');
    }
  }

  static Future<List> fetchYTSearchResultThumbnails() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List result = items.map((item) => item['thumbnailUrl']).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result thumbnail URLs');
    }
  }

  static Future<List> fetchYTSearchResultViewCounts() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List result = items.map((item) => item['viewCount']).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result view counts');
    }
  }

  static Future<List> fetchYTSearchResultUploadDates() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List result = items.map((item) => item['date']).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result upload dates');
    }
  }

  static Future<List> fetchYTSearchResultChannelNames() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List result = items.map((item) => item['channelName']).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result channel names');
    }
  }

  static Future<List> fetchYTSearchResultChannelUrls() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List result = items.map((item) => item['channelUrl']).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result channel URLs');
    }
  }

  static Future<List> fetchYTSearchResultLikes() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List result = items.map((item) => item['likes']).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result video likes.');
    }
  }

  static Future<List> fetchYTSearchResultNumberOfSubscribers() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List result =
          items.map((item) => item['numberOfSubscribers']).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result number of subscribers.');
    }
  }

  static Future<List> fetchYTSearchResultVideoDuration() async {
    final response = await http.get(Uri.parse(
        'https://api.apify.com/v2/acts/streamers~youtube-scraper/runs/last/dataset/items?token=apify_api_kaFcgcBqiY440vWPsDdhGXOZk5A87O4um3pq'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> items = jsonData;

      final List result = items.map((item) => item['duration']).toList();

      return result;
    } else {
      throw Exception('Failed to fetch search result video durations.');
    }
  }
}
