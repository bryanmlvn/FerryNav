import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ferrynav/styles/style.dart';
import 'package:ferrynav/business_logic/payment_status.dart'; // Import the file
import 'dart:async';
import 'package:ferrynav/navigation_menu.dart';

class WebviewPage extends StatefulWidget {
  static const String id = 'webview_page';

  final String? cityFrom;
  final String? cityDestination;
  final String? date;
  final String? numberOfPassenger;
  final List<int>? selectedSeats;
  final String? redirectUrl;
  final String? orderId;

  const WebviewPage({
    Key? key,
    this.cityFrom,
    this.cityDestination,
    this.date,
    this.numberOfPassenger,
    this.selectedSeats,
    this.redirectUrl,
    this.orderId,
  }) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late WebViewController _webViewController;
  bool _paymentCompleted = false;
  Timer? _statusCheckTimer;

  @override
  void initState() {
    super.initState();
    // Initialize WebViewController and load the URL
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.redirectUrl ?? ''))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          print("WebView loading URL: $url");
        },
        onPageFinished: (url) {
          print("WebView finished loading URL: $url");
          _startCheckingPaymentStatus(); // Start checking payment status when page finishes loading
        },
      ));
  }

  void _startCheckingPaymentStatus() {
    // Start checking payment status every 5 seconds
    _statusCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        // Check the status from the API
        final statusResponse = await checkPaymentStatus(widget.orderId!);
        final status = statusResponse['transaction_status'];

        // Print the payment status
        print("Payment status for order ${widget.orderId}: $status");

        if (status == 'settlement') {
          setState(() {
            _paymentCompleted = true;
          });
          // Stop the timer when payment is completed
          _statusCheckTimer?.cancel();
          // Show the success dialog
          _showPaymentSuccessDialog();
        } else if (status == 'pending') {
          print("Payment status is pending. Checking again in 5 seconds.");
        } else {
          // Handle other statuses if needed
          print("Handling other statuses: $status");
          _statusCheckTimer?.cancel(); // Stop the timer if needed
        }
      } catch (e) {
        print("Error checking payment status: $e");
      }
    });
  }

  void _showPaymentSuccessDialog() {
    print("Showing payment success dialog");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Successful'),
        content: const Text('Your payment has been completed successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, NavigationMenu.id);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _statusCheckTimer?.cancel(); // Cancel the timer when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appBarColor,
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
