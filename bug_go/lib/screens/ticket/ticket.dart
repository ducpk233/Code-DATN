import 'package:bus_go/screens/ticket/components/ticket_widget.dart';
import 'package:bus_go/shared_nav_bar.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          shadowColor: Colors.black,
          backgroundColor: canvasColor,
          bottom: TabBar(
            overlayColor: MaterialStateProperty.all<Color>(Colors.white),
            tabs: [
              Tab(
                text: 'Vé đã mua',
              ),
              Tab(text: 'Vé đã sử dụng'),
              Tab(text: 'Vé đã hủy'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TicketList(title: 'Vé Đã Mua'),
            TicketList(title: 'Vé Đã Dùng'),
            TicketList(title: 'Vé Đã Hủy'),
          ],
        ),
        backgroundColor: Colors.grey[200],
        // Background nhẹ nhàng
      ),
    );
  }
}

class TicketList extends StatelessWidget {
  final String title;

  TicketList({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        TicketWidget(
          width: 350,
          height: 300,
          isCornerRounded: true,
          padding: EdgeInsets.all(20),
          child: TicketData(),
        ),
        SizedBox(
          height: 10,
        ),
        TicketWidget(
          width: 350,
          height: 300,
          isCornerRounded: true,
          padding: EdgeInsets.all(20),
          child: TicketData(),
        ),
        SizedBox(
          height: 10,
        ),
        TicketWidget(
          width: 350,
          height: 300,
          isCornerRounded: true,
          padding: EdgeInsets.all(20),
          child: TicketData(),
        ),
        SizedBox(
          height: 10,
        ),
        TicketWidget(
          width: 350,
          height: 300,
          isCornerRounded: true,
          padding: EdgeInsets.all(20),
          child: TicketData(),
        ),
        // Thêm các mục vé vào danh sách ở đây
      ],
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120.0,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(width: 1.0, color: Colors.green),
              ),
              child: const Center(
                child: Text(
                  'Business Class',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
            Row(
              children: const [
                Text(
                  'LHR',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.arrow_right,
                    color: Colors.pink,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'ISL',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Vé xe bus một lần',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget(
                  'Hành khách', 'Huỳnh Đức', 'Ngày', '28-08-2023'),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 47.0),
                child: ticketDetailsWidget('Mã vé', '76836A45', 'Giờ', '6AM'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 53.0),
                child: ticketDetailsWidget('Loại vé', 'Thường', 'Ghế', '21B'),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
        //   child: Container(
        //     width: 250.0,
        //     height: 60.0,
        //     decoration: const BoxDecoration(
        //         image: DecorationImage(
        //             image: AssetImage('assets/barcode.png'),
        //             fit: BoxFit.cover)),
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(top: 10.0, left: 75.0, right: 75.0),
        //   child: Text(
        //     '0000 +9230 2884 5163',
        //     style: TextStyle(
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
