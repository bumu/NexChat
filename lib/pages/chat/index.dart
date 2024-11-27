import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
export 'chat_screen.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _chatItems.length,
      separatorBuilder: (context, index) => const Divider(
        height: 0.5,
        color: Colors.black12,
      ),
      itemBuilder: (context, index) {
        final chat = _chatItems[index];
        print('Avatar URL for ${chat.name}: ${chat.avatarUrl}');

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: ClipOval(
              child: Image.network(
                chat.avatarUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading avatar: $error');
                  return const Icon(Icons.person, color: Colors.white);
                },
              ),
            ),
            /*
            child: SvgPicture.network(
              chat.avatarUrl,
              fit: BoxFit.cover,
              // 加载时显示进度条
              placeholderBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              // 发生错误时显示默认头像图标
              onError: (error, stackTrace) {
                print('Error loading SVG avatar: $error');
                return const Icon(Icons.person, color: Colors.white);
              },
            ),
            ),
            */
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              chat.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          subtitle: Text(
            chat.message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          trailing: Text(
            chat.time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          onTap: () {
            final args = {
              'contactName': chat.name,
              'contactAvatarUrl': chat.avatarUrl,
              'sessionId': chat.sessionId,
            };
            print('Debug: Sending arguments from ChatPage: $args');
            Navigator.pushNamed(
              context,
              '/chat/detail',
              arguments: args,
            );
          },
        );
      },
    );
  }
}

class ChatItemData {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final String sessionId;

  ChatItemData({
    required this.name,
    required this.message,
    required this.time,
    String? sessionId,
  }) : avatarUrl = generateAvatarUrl(name),
       sessionId = sessionId ?? name.toLowerCase().replaceAll(' ', '_');

  static String generateAvatarUrl(String name) {
    /*
    final randomNumber = (name.hashCode % 5) + 1;
    return 'assets/avatar/avatar_0${randomNumber}.png';
    */
    // Use name hash to generate a consistent avatar for each name
    final hash = name.hashCode.abs().toString();
    return 'https://api.dicebear.com/7.x/avataaars/png?seed=$hash';
  }
}

final List<ChatItemData> _chatItems = [
  ChatItemData(
    name: "Alex Johnson",
    message: "Want to grab coffee later?",
    time: "09:23",
  ),
  ChatItemData(
    name: "Emma Wilson",
    message: "How's the project going?",
    time: "08:45",
  ),
  ChatItemData(
    name: "Michael Brown",
    message: "Meeting at 2pm today",
    time: "Yesterday",
  ),
  ChatItemData(
    name: "Sarah Davis",
    message: "I sent you the files",
    time: "11:05",
  ),
  ChatItemData(
    name: "James Smith",
    message: "Thanks for your help!",
    time: "10:17",
  ),
  ChatItemData(
    name: "Emily Taylor",
    message: "See you at lunch",
    time: "Wed",
  ),
  ChatItemData(
    name: "David Miller",
    message: "Don't forget the meeting",
    time: "Tue",
  ),
  ChatItemData(
    name: "Sophie Clark",
    message: "Are you free tomorrow?",
    time: "Mon",
  ),
  ChatItemData(
    name: "Oliver White",
    message: "Check the latest updates",
    time: "Sun",
  ),
]; 