import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _showPasswordDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Đổi mật khẩu'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu cũ',
                  ),
                ),
                TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu mới',
                  ),
                ),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Xác nhận mật khẩu',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cập nhật'),
              onPressed: () {
                // Xử lý cập nhật mật khẩu ở đây
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Trở về'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị ban đầu cho các trường thông tin
    _nameController.text = 'John Doe';
    _emailController.text = 'john.doe@example.com';
    _phoneController.text = '+1 (123) 456-7890';
    _addressController.text = '123 Main Street, City';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              // Hình đại diện
              CircleAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png"), // Thay bằng đường dẫn hình ảnh của bạn), // Thay bằng đường dẫn hình ảnh của bạn
              ),
              SizedBox(height: 16.0),
              // Tên người dùng
              Text(
                'John Doe', // Thay bằng tên của bạn
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              // Thông tin cá nhân có thể chỉnh sửa
              buildTextField("Họ và tên", _nameController),
              buildTextField("Email", _emailController),
              buildTextField("Số điện thoại", _phoneController),
              buildTextField("Địa chỉ", _addressController),
              SizedBox(height: 16.0),
              // Nút "Cập Nhật Thông Tin" và "Đổi Mật Khẩu" cùng hàng
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Xử lý cập nhật thông tin người dùng ở đây
                    },
                    style: ButtonStyle(),
                    icon: Icon(Icons.change_circle),
                    label: Text(
                      'Cập nhật thông tin',
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showPasswordDialog();
                    },
                    style: ButtonStyle(),
                    icon: Icon(Icons.password),
                    label: Text(
                      'Đổi mật khẩu',
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(label),
        subtitle: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
