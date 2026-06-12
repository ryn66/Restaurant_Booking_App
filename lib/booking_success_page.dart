import 'dart:math';

import 'package:flutter/material.dart';
import 'firebase_reservation_service.dart';
import 'main_navigation_page.dart';
import 'cart_data.dart';


class BookingSuccessPage extends StatelessWidget {

  final Map<String, dynamic> bookingData;

  BookingSuccessPage({
    super.key,
    required this.bookingData,
  }) {

    FirebaseReservationService
        .saveReservation(
      bookingData,
    );

    cartItems.clear();
  }

  String bookingReference() {

    final random =
    Random().nextInt(999);

    return "JAK#$random";
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

        title: const Row(
          children: [

            Icon(
              Icons.check_circle,
              color: Colors.black,
            ),

            SizedBox(width: 10),

            Text(
              "Booking Successful",

              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 60),

            Container(
              width: 140,
              height: 140,

              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 6,
                ),

                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.check,
                color: Colors.green,
                size: 80,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "Your booking has\nbeen confirmed!",

              textAlign: TextAlign.center,

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),

            const SizedBox(height: 40),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(30),

              decoration: BoxDecoration(
                color: Colors.green.shade50,

                border: Border.all(
                  color: Colors.green,
                ),

                borderRadius:
                BorderRadius.circular(30),
              ),

              child: Column(
                children: [

                  const Text(
                    "Booking Reference",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    bookingReference(),

                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "A confirmation has been sent to your email",

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),

                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 65,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.grey.shade700,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(30),
                  ),
                ),

                onPressed: () {

                  Navigator.pushAndRemoveUntil(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                      const MainNavigationPage(),
                    ),

                        (route) => false,
                  );
                },

                child: const Text(
                  "Go To Homepage",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }
}