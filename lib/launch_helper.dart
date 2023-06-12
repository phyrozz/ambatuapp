import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(Uri url) async {
  if (!await launch(url.toString())) {
    throw Exception('Could not launch $url');
  }
}
