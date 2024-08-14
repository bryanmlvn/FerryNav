import 'package:flutter/material.dart';
import 'package:ferrynav/styles/style.dart';

Color appBarColor = const Color(0xFF06305A);
Color containerColor = const Color(0xFFd2fbf7);
String cityFrom = "City 1";
String pelabuhanFrom = "Pelabuhan 1";
String timeFrom = '10.30';
String cityDestination = "City 2";
String pelabuhanDestination = "Pelabuhan 2";
String timeDestination = '15.30';
String date = "Fri, 99 December 2099";
int remainingSeat = 999;
String duration = "±5h 15m";
String kodeFerry = "FerryNav 02";
int seatCapacity = 200;

class SeatPage extends StatefulWidget {
  static const String id = 'seat_page';

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // Seat status list: 0 = available, 1 = selected, 2 = unavailable
  List<int> seatStatus = List.filled(24, 0);

  void toggleSeat(int index) {
    setState(() {
      if (seatStatus[index] == 0) {
        seatStatus[index] = 1;
      } else if (seatStatus[index] == 1) {
        seatStatus[index] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Ticket Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                decoration: commonBoxDecorationStyle(containerColor),
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '$cityFrom - $cityDestination',
                        style: h1Style,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            date,
                            style: desc1Style(Colors.black),
                          ),
                          Text(
                            duration,
                            style: desc1Style(Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '$remainingSeat Remaining seats',
                        style: h3Style,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _colorBox(Colors.lightBlue, 'Selected'),
                  const SizedBox(width: 10),
                  _colorBox(Colors.green, 'Available'),
                  const SizedBox(width: 10),
                  _colorBox(Colors.red, 'Unavailable'),
                ],
              ),
              const SizedBox(height: 5.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                decoration: commonBoxDecorationStyle(containerColor),
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                ),
                // child: _buildSeatGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //GPT PUNYA AMPAS
//   Widget _buildSeatGrid() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 7, // 6 seats + 1 for the hallway spacing
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//         childAspectRatio: 1.5,
//       ),
//       itemCount: seatStatus.length + 4, // +4 for hallway spaces
//       itemBuilder: (context, index) {
//         if ((index + 1) % 7 == 0 || (index + 1) % 7 == 4) {
//           // Hallway spaces
//           return SizedBox.shrink();
//         }
//         int seatIndex = index - (index ~/ 7);
//         return GestureDetector(
//           onTap: () => toggleSeat(seatIndex),
//           child: Container(
//             decoration: BoxDecoration(
//               color: seatStatus[seatIndex] == 0
//                   ? Colors.green
//                   : seatStatus[seatIndex] == 1
//                       ? Colors.lightBlue
//                       : Colors.red,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Center(
//               child: Text(
//                 '${seatIndex + 1}',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

  Widget _colorBox(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.circular(4), // Adjust the radius as needed
          ),
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
