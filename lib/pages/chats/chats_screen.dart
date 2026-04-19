import 'package:chat_zxc/entities/chat/chat.dart';
import 'package:chat_zxc/entities/chat/view_model.dart';
import 'package:chat_zxc/entities/message/message.dart';
import 'package:chat_zxc/entities/message/message_author.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:chat_zxc/widgets/chats_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat ZXC", style: AetherTypography.displayMedium),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search, size: 22),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
            color: AetherColors.void200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AetherRadius.md),
            ),
            onSelected: (value) {
              // Обработка быстрых функций
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'new_group',
                child: Text('New Group', style: AetherTypography.bodyMedium),
              ),
              PopupMenuItem(
                value: 'read_all',
                child: Text(
                  'Mark all as read',
                  style: AetherTypography.bodyMedium,
                ),
              ),
              PopupMenuItem(
                value: 'archive',
                child: Text('Archive', style: AetherTypography.bodyMedium),
              ),
            ],
          ),
        ],
      ),
      body: ChatsList(
        chats: [
          ChatViewModel(
            id: 'id',
            title: 'name',
            lastMessage: Message(
              id: 'id',
              author: AuthorPreview('чушпан', null, 'шпак'),
              sentAt: DateTime.now().subtract(Duration(minutes: 5)),
              reactions: [],
            ),
            imageUrl: null,
          ),
        ],
      ),
    );
  }
}
