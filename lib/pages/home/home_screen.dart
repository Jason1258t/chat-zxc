import 'package:chat_zxc/pages/chats/chats_screen.dart';
import 'package:chat_zxc/pages/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_zxc/shared/theme/aether.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ChatsScreen(),
    Center(child: Text('Contacts List', style: AetherTypography.bodyLarge)),
    Center(child: Text('Settings', style: AetherTypography.bodyLarge)),
    ProfileScreen(),
  ];

  final PageController _controller = PageController();

  @override
  void initState() {
    _controller.addListener(() {
      final int page = _controller.page?.toInt() ?? _currentIndex;
      if (page != _currentIndex) {
        setState(() {
          _currentIndex = page;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: _controller, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AetherColors.void400, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _controller.animateToPage(
              index,
              duration: 150.ms,
              curve: Curves.easeIn,
            );
            _currentIndex = index;
          }),
          backgroundColor: AetherColors.void100,
          selectedItemColor: AetherColors.violet500,
          unselectedItemColor: AetherColors.textTertiary,
          selectedLabelStyle: AetherTypography.labelSmall,
          unselectedLabelStyle: AetherTypography.labelSmall,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble),
              activeIcon: Icon(CupertinoIcons.chat_bubble_fill),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2),
              activeIcon: Icon(CupertinoIcons.person_2_fill),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              activeIcon: Icon(CupertinoIcons.settings_solid),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
