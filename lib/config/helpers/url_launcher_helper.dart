import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<void> openLink(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch $link');
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> openWhatsApp(String phone) async {
    final url = Uri.parse("https://wa.me/$phone"); // e.g. 201234567890
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }
}
