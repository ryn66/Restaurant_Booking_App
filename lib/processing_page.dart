import 'dart:async';

import 'package:flutter/material.dart';

import 'booking_success_page.dart';

class ProcessingPage extends StatefulWidget {

  final Map<String, dynamic> bookingData;

  const ProcessingPage({
    super.key,
    required this.bookingData,
  });

  @override
  State<ProcessingPage> createState() =>
      _ProcessingPageState();
}

class _ProcessingPageState
    extends State<ProcessingPage> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),

          () {

        Navigator.pushReplacement(
          context,

          MaterialPageRoute(
            builder: (_) =>
                BookingSuccessPage(
                  bookingData:
                  widget.bookingData,
                ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {},

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        centerTitle: true,

        title: const Text(
          "Processing",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: const Center(

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            SizedBox(
              width: 90,
              height: 90,

              child:
              CircularProgressIndicator(
                strokeWidth: 8,
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Please wait...",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "We are confirming your booking.",

              style: TextStyle(
                fontSize: 16,
              ),
            ),

          ],
        ),
      ),
    );
  }
}