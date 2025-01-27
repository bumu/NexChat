import 'package:flutter/material.dart';
import '../pages/chat/index.dart';
import '../pages/contact/index.dart';
import '../pages/explore/index.dart';
import '../pages/profile/index.dart';
import '../pages/profile/profile_service.dart';
import '../pages/chat/chat_screen.dart';
import '../pages/profile/my_profile.dart';
import '../pages/profile/my_settings.dart';
import '../pages/profile/my_order.dart';
import '../pages/profile/my_account.dart';
import '../pages/explore/mini_program.dart';
import '../pages/payment/history.dart';
import '../pages/payment/add_card.dart';
import '../pages/profile/device.dart';
import '../pages/profile/nfc.dart';
import '../pages/chat/index.dart';
import '../pages/chat/chat_mini_program.dart';
import '../pages/chat/mobile_scanner.dart';
import '../pages/profile/payment_code_page.dart';


class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/chat/index': (context) => const ChatPage(),
    '/profile/order': (context) => const MyOrderPage(),
    '/profile/payment_code': (context) => const PaymentCodePage(),
    '/chat/mini_program': (context) => const ChatMiniProgramPage(),
    '/chat/qr_scan_page': (context) => const QRScanPage(),
    '/chat': (context) => const ChatPage(),
    '/chat/index': (context) => const ChatPage(),
    '/contacts': (context) => const ContactPage(),
    '/explore': (context) => const ExplorePage(),
    '/profile': (context) => const ProfilePage(),
    '/profile/service': (context) => const ProfileServicePage(),
    '/profile/me': (context) => const MyProfilePage(),
    '/profile/settings': (context) => const MySettingsPage(),
    '/profile/account': (context) => const MyAccountPage(),
    '/profile/order': (context) => const MyOrderPage(),
    '/explore/mini-program': (context) => const MiniProgramPage(),
    '/chat/detail': (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      print('Debug: Arguments received in route builder: $args');
      return ChatScreen(
        contactName: args['contactName'] as String,
        contactAvatarUrl: args['contactAvatarUrl'] as String,
        sessionId: args['sessionId'] as String,
      );
    },
    '/payment/history': (context) => const PaymentHistoryPage(),
    '/payment/add-card': (context) => const AddCardPage(),
    '/profile/device': (context) => const DeviceManagementPage(),
    '/profile/nfc': (context) => const NFCPage(),
  };
} 