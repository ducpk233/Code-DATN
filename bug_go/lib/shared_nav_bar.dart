import 'package:bus_go/screens/home/home.dart';
import 'package:bus_go/screens/profile/profile.dart';
import 'package:bus_go/screens/search/search.dart';
import 'package:bus_go/screens/start/share.dart';
import 'package:bus_go/screens/ticket/ticket.dart';
import 'package:bus_go/screens/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SharedNavBar extends StatefulWidget {
  const SharedNavBar({super.key});

  @override
  State<SharedNavBar> createState() => _SharedNavBarState();
}

class _SharedNavBarState extends State<SharedNavBar> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    title: Text(_getTitleByIndex(_controller.selectedIndex)),
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  )
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 10,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
                "https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png"),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Trang chủ',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Tra cứu',
        ),
        const SidebarXItem(
          icon: Icons.airplane_ticket,
          label: 'Vé',
        ),
        const SidebarXItem(
          icon: Icons.wallet,
          label: 'Ví của bạn',
        ),
        const SidebarXItem(
          icon: Icons.person,
          label: 'Cá nhân',
        ),
        const SidebarXItem(
          icon: Icons.logout,
          label: 'Đăng xuất',
        ),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        //title ở trong widget
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return HomeScreen();
          // ListView.builder(
          //   padding: const EdgeInsets.only(top: 10),
          //   itemBuilder: (context, index) => Container(
          //     height: 100,
          //     width: double.infinity,
          //     margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       color: Theme.of(context).canvasColor,
          //       boxShadow: const [BoxShadow()],
          //     ),
          //   ),
          // );
          case 1:
            return Search();
          case 2:
            return Ticket();
          case 3:
            return Wallet();
          case 4:
            return Profile();
          case 5:
            return AlertDialog(
              title: Text('Xác nhận đăng xuất'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Bạn có chắc chắn muốn đăng xuất khỏi ứng dụng?'),
                  Divider(), // Tạo đường kẻ ngăn cách tiêu đề và nút
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SharedNavBar()),
                          );
                        },
                        child: Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Share()),
                          );
                        },
                        child: Text('Đăng xuất'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Trang chủ';
    case 1:
      return 'Tra cứu';
    case 2:
      return 'Vé';
    case 3:
      return 'Ví của bạn';
    case 4:
      return 'Cá nhân';
    case 5:
      return 'Đăng xuất';
    case 6:
      return 'Đăng xuất';
    default:
      return 'Not found page';
  }
}

const primaryColor = Colors.brown;
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
