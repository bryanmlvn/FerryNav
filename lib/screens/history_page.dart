import 'package:flutter/material.dart';
import 'package:ferrynav/styles/style.dart';


class HistoryPage extends StatefulWidget {
  static const String id = 'history_page';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool animationComplete = false;
  double buttonOpacity = 0.0;
  double containerOpacity = 0.0;


  void _showDetailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appBarColor,
          titlePadding: EdgeInsets.all(15), // Custom padding for the title
          contentPadding: EdgeInsets.all(20), // Custom padding for the content
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Customize the dialog shape
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            height: MediaQuery.of(context).size.height * 0.5,// Fixed height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('City 1', style: h2StyleB.copyWith(color: containerColor)),
                    Text('->', style: h2StyleB.copyWith(color: containerColor)),
                    Text('City 2', style: h2StyleB.copyWith(color: containerColor))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Jam Berangkat', style: desc1Style(containerColor),),
                    Text('Jam Nyampe', style: desc1Style(containerColor),)
                  ],
                ),
                SizedBox(height: 25),

                Text('Nama Pemesan: ', style: h3Style.copyWith(color: containerColor)),
                Text('nama', style: desc1Style(containerColor),),
                SizedBox(height: 10,),

                Text('Departutre Date: ', style: h3Style.copyWith(color: containerColor)),
                Text('tanggal', style: desc1Style(containerColor),),
                SizedBox(height: 10,),

                Text('Booking Number: ', style: h3Style.copyWith(color: containerColor)),
                Text('booking number', style: desc1Style(containerColor),),
                SizedBox(height: 10,),

                Text('Seat: ', style: h3Style.copyWith(color: containerColor)),
                Text('seat number', style: desc1Style(containerColor),),
                SizedBox(height: 10,),

                Text('Payment Status: ', style: h3Style.copyWith(color: containerColor)),
                Text('payment status', style: desc1Style(containerColor),),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Close', style: h3Style.copyWith(color: Colors.red)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 350), // Set duration to 0.35 seconds
      vsync: this,
    );

    // Define the animation
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Start the animation after a delay
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        buttonOpacity = 1.0;
        containerOpacity = 1.0;
      });
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Make the row as small as its children
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: _animation
                          .value, // Apply the animation value to opacity
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 8.0), // Space between image and title
                        child: Image.asset(
                          'assets/FerryNav-3.png',
                          width: 50.0,
                        ),
                      ),
                    ),
                    Text(
                      'FerryNav',
                      style: TextStyle(
                        color: containerColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: appBarColor.withOpacity(_animation.value),
            );
          },
        ),
      ),
      body: AnimatedOpacity(
        opacity: containerOpacity,
        duration: Duration(milliseconds: 500),
        child: Container(
          padding: EdgeInsets.all(3.0),
          margin: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 45.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            // color: Colors.grey
          ),
          constraints: BoxConstraints(
            minWidth: double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'History',
                style: h1Style,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.fromLTRB(0, 15.0, 0, 45.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: containerColor,
                ),
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'City 1 - City 2',
                      style: h2StyleB,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Nama Pemesan',
                          style: h4Style,
                        ),
                        TextButton(
                            onPressed: _showDetailDialog,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, // Remove default padding
                              minimumSize: Size(0, 0),  // Optional: Set minimum size to zero if needed
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink the tap target size
                            ),
                            child: Text(
                              'Details',
                              style: h3Style.copyWith(color: appBarColor)
                            ),
                        )
                      ],
                    ),
                    Text(
                      'Purchase Date',
                      style: h4Style,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
