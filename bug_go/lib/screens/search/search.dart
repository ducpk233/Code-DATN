import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //We will pass the sink to the places auto complete widget to get the selected address by user
  final _pickUpLocationSC = StreamController<PlaceDetail>.broadcast();
  StreamSink<PlaceDetail> get pickUpLocationSink => _pickUpLocationSC.sink;
  Stream<PlaceDetail> get pickUpLocationStream => _pickUpLocationSC.stream;

  final _dropUpLocationSC = StreamController<PlaceDetail>.broadcast();
  StreamSink<PlaceDetail> get dropLocationSink => _dropUpLocationSC.sink;
  Stream<PlaceDetail> get dropLocationStream => _dropUpLocationSC.stream;

  @override
  Widget build(BuildContext context) {
    final pickupDropIconWidget = Column(
      children: [
        SizedBox(height: 8),
        const Icon(
          Icons.trip_origin_rounded,
          color: Colors.green,
          size: 28,
        ),
        Container(
          height: 54,
          child: CustomPaint(
              size: Size(1, double.infinity),
              painter: DashedLineVerticalPainter()),
        ),
        const Icon(
          Icons.place_rounded,
          color: Colors.green,
          size: 32,
        ),
      ],
    );

    final tvPickupAddress = ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black,
        primary: Colors.grey,
        fixedSize: Size(getScreenWidth(context) - 88, 42),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.black,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(21))),
      ),
      child: Row(
        children: [
          Expanded(
            child: StreamBuilder<PlaceDetail>(
                stream: pickUpLocationStream,
                builder: (context, snapshot) {
                  final address = snapshot.data == null
                      ? "Chọn địa điểm"
                      : snapshot.data!.address ?? "Chọn địa điểm";
                  return Text(
                    address,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  );
                }),
          ),
        ],
      ),
      onPressed: () {
        // Navigator.of(context).push(fadeScreenTransition(LocationSearchScreen(
        //     title: "Enter Pickup Location", sink: pickUpLocationSink)));
      },
    );

    final tvDropAddress = ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black,
        primary: Colors.grey,
        fixedSize: Size(getScreenWidth(context) - 88, 42),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.black,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(21))),
      ),
      child: Row(
        children: [
          Expanded(
            child: StreamBuilder<PlaceDetail>(
                stream: dropLocationStream,
                builder: (context, snapshot) {
                  final address = snapshot.data == null
                      ? "Chọn địa điểm"
                      : snapshot.data!.address ?? "Chọn địa điểm";
                  return Text(
                    address,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  );
                }),
          ),
        ],
      ),
      onPressed: () {
        // Navigator.of(context).push(fadeScreenTransition(LocationSearchScreen(
        //     title: "Enter drop Location", sink: dropLocationSink)));
      },
    );

    final pickupDropWidget = Container(
      height: 300,
      width: getScreenWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8),
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 32),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 18, top: 0, bottom: 4),
                child: Text(
                  "Bạn đang muốn đi đâu?",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 16),
                  pickupDropIconWidget,
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(left: 0, top: 8, bottom: 4),
                        child: Text(
                          "Từ",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      tvPickupAddress,
                      Container(
                        padding:
                            const EdgeInsets.only(left: 0, top: 8, bottom: 4),
                        child: Text(
                          "Đến",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      tvDropAddress,
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
              "https://www.google.com/maps/d/thumbnail?mid=11RLJtMBbp61h-N9uMDaI7_WLtMKKosG7&hl=en"),
          pickupDropWidget,
        ],
      ),
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

class Suggestion {
  final String placeId;
  final String description;
  final String title;

  Suggestion(this.placeId, this.description, this.title);
}

class PlaceDetail {
  String? address;
  double? latitude;
  double? longitude;
  String? name;

  PlaceDetail({
    this.address,
    this.latitude,
    this.longitude,
    this.name,
  });
}

class SimpleMap extends StatelessWidget {
  const SimpleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
