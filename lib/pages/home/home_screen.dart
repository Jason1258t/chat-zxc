import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_zxc/shared/theme/aether.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Contacts List', style: AetherTypography.bodyLarge)),
    Center(child: Text('Active Chats', style: AetherTypography.bodyLarge)),
    Center(child: Text('Settings & Profile', style: AetherTypography.bodyLarge)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(), style: AetherTypography.displayMedium),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search, size: 22),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
            color: AetherColors.void200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AetherRadius.md)),
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
                child: Text('Mark all as read', style: AetherTypography.bodyMedium),
              ),
              PopupMenuItem(
                value: 'archive',
                child: Text('Archive', style: AetherTypography.bodyMedium),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AetherColors.void400, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: AetherColors.void100,
          selectedItemColor: AetherColors.violet500,
          unselectedItemColor: AetherColors.textTertiary,
          selectedLabelStyle: AetherTypography.labelSmall,
          unselectedLabelStyle: AetherTypography.labelSmall,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2),
              activeIcon: Icon(CupertinoIcons.person_2_fill),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble),
              activeIcon: Icon(CupertinoIcons.chat_bubble_fill),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              activeIcon: Icon(CupertinoIcons.settings_solid),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    return switch (_currentIndex) {
      0 => 'Contacts',
      1 => 'ZXC VPN',
      2 => 'Settings',
      _ => 'Aether',
    };
  }
}