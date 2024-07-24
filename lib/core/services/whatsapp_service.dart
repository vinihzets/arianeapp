import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class WhatsApp {
  static Future<bool> sendMessage(String number, String text) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+55$number',
      text: text,
    );
    return launchUrlString(link.toString());
  }
}
