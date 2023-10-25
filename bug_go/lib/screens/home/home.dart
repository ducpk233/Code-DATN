import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue, // Màu nền cho thanh avatar
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    foregroundImage: NetworkImage(
                        "https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png"), // Thay bằng đường dẫn hình ảnh của bạn
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Xin chào, John', // Thay bằng tên của user
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0, // Độ nổi của thẻ
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vị trí hiện tại:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '123 Main Street, City',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Các tuyến:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    ListTile(
                      title: Text('Tuyến A'),
                      subtitle: Text('Thời gian chờ: 5 phút'),
                    ),
                    ListTile(
                      title: Text('Tuyến B'),
                      subtitle: Text('Thời gian chờ: 10 phút'),
                    ),
                    // Thêm các tuyến khác tương tự ở đây
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông báo:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    // Hiển thị danh sách thông báo dưới dạng danh sách cụ thể với hình ảnh
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Thông báo 1'),
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Thông báo 2'),
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Thông báo 3'),
                    ),
                    // Thêm các thông báo khác tương tự ở đây
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
