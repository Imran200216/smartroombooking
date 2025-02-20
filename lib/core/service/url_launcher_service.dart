import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  static Future<void> launchUrlInBrowser(String urlString) async {
    final Uri url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
