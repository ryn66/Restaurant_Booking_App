import 'package:flutter/material.dart';

import 'payment_page.dart';

class SummaryPage extends StatelessWidget {

  final Map<String, String> package;

  final int guestCount;

  final double subtotal;

  final double serviceCharges;

  final double totalPrice;

  final DateTime? selectedDate;

  final TimeOfDay? selectedTime;

  final String specialRequest;

  const SummaryPage({
    super.key,
    required this.package,
    required this.guestCount,
    required this.subtotal,
    required this.serviceCharges,
    required this.totalPrice,
    required this.selectedDate,
    required this.selectedTime,
    required this.specialRequest,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        title: const Text(
          "Booking Summary",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // TITLE

            const Text(
              "Review Your Booking",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Please review all booking details before proceeding to payment.",

              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            // SUMMARY CARD

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(24),
              ),

              child: Column(
                children: [

                  buildSummaryRow(
                    "Package",
                    package["name"]!,
                  ),

                  buildSummaryRow(
                    "Guests",
                    "$guestCount Guests",
                  ),

                  buildSummaryRow(
                    "Date",
                    selectedDate == null
                        ? "-"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  ),

                  buildSummaryRow(
                    "Time",
                    selectedTime == null
                        ? "-"
                        : selectedTime!.format(context),
                  ),

                  buildSummaryRow(
                    "Subtotal",
                    "RM ${subtotal.toStringAsFixed(2)}",
                  ),

                  buildSummaryRow(
                    "Service Charges",
                    "RM ${serviceCharges.toStringAsFixed(2)}",
                  ),

                  const Divider(height: 35),

                  buildSummaryRow(
                    "TOTAL",
                    "RM ${totalPrice.toStringAsFixed(2)}",
                    isTotal: true,
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            // SPECIAL REQUESTS

            const Text(
              "Special Requests",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(18),
              ),

              child: Text(
                specialRequest.isEmpty
                    ? "No special requests added."
                    : specialRequest,

                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),

            const Spacer(),

            // PAYMENT BUTTON

            SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.grey.shade700,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                ),

                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) => PaymentPage(
                        package: package,

                        guestCount: guestCount,

                        subtotal: subtotal,

                        serviceCharges: serviceCharges,

                        totalPrice: totalPrice,

                        selectedDate: selectedDate,

                        selectedTime: selectedTime,

                        specialRequest: specialRequest,
                      ),
                    ),
                  );
                },

                child: const Text(
                  "Proceed To Payment",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildSummaryRow(
      String title,
      String value, {
        bool isTotal = false,
      }) {

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,

            style: TextStyle(
              fontWeight: FontWeight.bold,

              fontSize: isTotal ? 20 : 16,
            ),
          ),

          Text(
            value,

            style: TextStyle(
              fontWeight: FontWeight.bold,

              fontSize: isTotal ? 22 : 16,
            ),
          ),

        ],
      ),
    );
  }
}