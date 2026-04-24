import 'package:chat_zxc/entities/chat/view_model.dart';
import 'package:chat_zxc/shared/components/aether_button.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:chat_zxc/shared/utils/time_ago.dart';
import 'package:flutter/material.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key, required this.chats});

  final List<ChatViewModel> chats;

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Nothing yet", style: AetherTypography.bodyLarge),
            SizedBox(height: AetherSpacing.lg),
            AetherButton.elevated(
              label: 'Start your first conversation',
              onPressed: () {},
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (context, ind) => ChatWidget(chat: chats[ind]),
      itemCount: chats.length,
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.chat});

  final ChatViewModel chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to chat screen
      },
      borderRadius: BorderRadius.circular(AetherRadius.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AetherSpacing.lg,
          vertical: AetherSpacing.sm,
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                Container(
                  width: AetherSpacing.avatarSizeLg,
                  height: AetherSpacing.avatarSizeLg,
                  decoration: chat.isOnline
                      ? AetherAvatarStyle.online
                      : AetherAvatarStyle.default_,
                  child: ClipOval(
                    child: Image.network(
                      chat.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.person,
                        color: AetherColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                if (chat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: AetherAvatarStyle.onlineIndicator,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AetherSpacing.md),
            // Chat info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.title,
                          style: chat.isUnread
                              ? AetherTypography.chatListName.copyWith(
                                  fontWeight: FontWeight.w700,
                                )
                              : AetherChatTextStyle.chatListName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AetherSpacing.xs),
                      Text(
                        timeAgo(chat.time),
                        style: chat.isUnread
                            ? AetherChatTextStyle.chatListTimeUnread
                            : AetherChatTextStyle.chatListTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: AetherSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage?.textContent ?? "meow",
                          style: chat.isUnread
                              ? AetherTypography.bodyMedium.copyWith(
                                  color: AetherColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                )
                              : AetherChatTextStyle.chatListPreview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat.isUnread)
                        const SizedBox(width: AetherSpacing.sm),
                      if (chat.isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: AetherBadgeStyle.unread,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
