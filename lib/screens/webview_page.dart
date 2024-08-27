import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ferrynav/styles/style.dart';

class WebviewPage extends StatefulWidget {
  static const String id = 'webview_page';

  final String? cityFrom;
  final String? cityDestination;
  final String? date;
  final String? numberOfPassenger;
  final List<int>? selectedSeats;
  final String? redirectUrl;

  const WebviewPage({
    Key? key,
    this.cityFrom,
    this.cityDestination,
    this.date,
    this.numberOfPassenger,
    this.selectedSeats,
    this.redirectUrl,
  }) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Initialize WebViewController and load the URL
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('${widget.redirectUrl}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: containerColor,
        ),
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appBarColor,
      ),
      body: WebViewWidget(controller: _webViewController,),
    );
  }
}
