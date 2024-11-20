import 'package:flutter/material.dart';
import 'pages/chat/index.dart';
import 'pages/chat/chat_screen.dart';
import 'pages/contact/index.dart';
import 'pages/explore/index.dart';
import 'pages/profile/index.dart';
import 'pages/profile/my_settings.dart';
import 'routes/routes.dart';
import 'pages/profile/my_order.dart';
import 'pages/profile/my_account.dart';
import 'pages/explore/mini_program.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/locale_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: MaterialApp(
        title: 'NexChat',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) {
          print("Debug - Route Settings: ${settings.name}, Args: ${settings.arguments}");
          
          // 先检查是否是 chat/detail 路由
          if (settings.name == '/chat/detail') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ChatScreen(
                sessionId: args['sessionId'] as String,
                contactName: args['contactName'] as String,
                contactAvatarUrl: args['contactAvatarUrl'] as String,
              ),
            );
          }
          
          // 检查是否是 profile/settings 路由
          if (settings.name == '/profile/settings') {
            return MaterialPageRoute(
              builder: (context) => const MySettingsPage(),
            );
          }

          // 检查是否是 profile/account 路由
          if (settings.name == '/profile/account') {
            return MaterialPageRoute(
              builder: (context) => const MyAccountPage(),
            );
          }

          // 检查是否是 explore/mini-program 路由
          if (settings.name == '/explore/mini-program') {
            return MaterialPageRoute(
              builder: (context) => const MiniProgramPage(),
            );
          }
          
          // 检查是否存在于预定义路由中
          final route = Routes.routes[settings.name];
          if (route != null) {
            return MaterialPageRoute(
              builder: route,
            );
          }
          
          return null;
        },
        home: const MyHomePage(title: 'NexChat'),
        routes: {
          '/profile/order': (context) => const MyOrderPage(),
        },
        locale: Provider.of<LocaleProvider>(context).locale,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ChatPage(),
    const ContactPage(),
    const ExplorePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('NexChat'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
