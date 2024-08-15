import 'package:flutter/material.dart';
import 'package:ferrynav/styles/style.dart';
import 'package:ferrynav/components/rounded_button.dart';

Color appBarColor = const Color(0xFF06305A);
Color containerColor = const Color(0xFFd2fbf7);
String pelabuhanFrom = "Pelabuhan 1";
String timeFrom = '10.30';
String pelabuhanDestination = "Pelabuhan 2";
String timeDestination = '15.30';
int remainingSeat = 999;
String duration = "±5h 15m";
String kodeFerry = "FerryNav 02";
int seatCapacity = 200;

class SeatPage extends StatefulWidget {
  static const String id = 'seat_page';
  const SeatPage(
      {Key? key,
      this.cityFrom,
      this.cityDestination,
      this.date,
      this.numberOfPassenger})
      : super(key: key);
  final String? cityFrom;
  final String? cityDestination;
  final String? date;
  final String? numberOfPassenger; //HARUSNYA INTEGER SIH TAPI GPP

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // Seat status list: 0 = available, 1 = selected, 2 = unavailable
  List<int> seatStatus = List.filled(70, 0);

  late int numberOfPassengers;

  @override
  void initState() {
    super.initState();
    numberOfPassengers =
        int.parse(widget.numberOfPassenger!); //  JADI CONVERT DISINI AJA DEH
  }

  void toggleSeat(int index) {
    setState(() {
      if (seatStatus[index] == 0 && _selectedSeatCount() < numberOfPassengers) {
        seatStatus[index] = 1;
      } else if (seatStatus[index] == 1) {
        seatStatus[index] = 0;
      }
    });
  }

  int _selectedSeatCount() {
    return seatStatus.where((status) => status == 1).length;
  }

  void validateAndProceed() {
    if (_selectedSeatCount() == numberOfPassengers) {
      printSelectedSeats();
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selection Error'),
          content: Text('Please select $numberOfPassengers seats.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void printSelectedSeats() {
    List<int> selectedSeats = [];
    for (int i = 0; i < seatStatus.length; i++) {
      if (seatStatus[i] == 1) {
        selectedSeats.add(i);
      }
    }
    print("Selected Seats: $selectedSeats");
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
                        '${widget.cityFrom} - ${widget.cityDestination}',
                        style: h1Style,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${widget.date}',
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
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 70,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                    ),
                    itemBuilder: (context, index) {
                      // Indices where the container should be invisible
                      List<int> invisibleIndices = [
                        0,
                        7,
                        6,
                        13,
                        3,
                        10,
                        17,
                        24,
                        31,
                        38,
                        45,
                        52,
                        59,
                        66
                      ];
                      bool isVisible = !invisibleIndices.contains(index);

                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: Visibility(
                          visible: isVisible,
                          child: GestureDetector(
                            onTap: () => toggleSeat(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: seatStatus[index] == 0
                                    ? Colors.green
                                    : (seatStatus[index] == 1
                                        ? Colors.lightBlue
                                        : Colors.red),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Center(
                                child: Text(
                                  '$index',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
              Container(
                margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
                child: RoundedButton(
                  title: 'Continue',
                  colour: const Color(0xFF219EBC),
                  onPressed: validateAndProceed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _colorBox(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
