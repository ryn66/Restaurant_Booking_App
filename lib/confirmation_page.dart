import 'package:flutter/material.dart';

import 'processing_page.dart';

class ConfirmationPage extends StatelessWidget {

  final Map<String, String> package;

  final int guestCount;

  final double subtotal;

  final double serviceCharges;

  final double totalPrice;

  final DateTime? selectedDate;

  final TimeOfDay? selectedTime;

  final String specialRequest;

  final String paymentMethod;

  const ConfirmationPage({
    super.key,
    required this.package,
    required this.guestCount,
    required this.subtotal,
    required this.serviceCharges,
    required this.totalPrice,
    required this.selectedDate,
    required this.selectedTime,
    required this.specialRequest,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        centerTitle: true,

        title: const Text(
          "Confirm Booking",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.yellow.shade100,

                borderRadius:
                BorderRadius.circular(12),
              ),

              child: const Text(
                "Please review all details before confirming your booking",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "Booking Details",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 25),

            buildRow(
              "Package",
              package["name"]!,
            ),

            buildRow(
              "Event Date",
              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            ),

            buildRow(
              "Event Time",
              selectedTime!.format(context),
            ),

            buildRow(
              "Guests",
              "$guestCount Guests",
            ),

            buildRow(
              "Payment",
              paymentMethod,
            ),

            buildRow(
              "Special Request",
              specialRequest.isEmpty
                  ? "None"
                  : specialRequest,
            ),

            const Divider(height: 40),

            buildRow(
              "Subtotal",
              "RM ${subtotal.toStringAsFixed(2)}",
            ),

            buildRow(
              "Service Charges",
              "RM ${serviceCharges.toStringAsFixed(2)}",
            ),

            const Divider(height: 40),

            buildRow(
              "Total Amount",
              "RM ${totalPrice.toStringAsFixed(2)}",
              isTotal: true,
            ),

            const SizedBox(height: 40),

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
                    BorderRadius.circular(30),
                  ),
                ),

                onPressed: () {

                  DateTime bookingDate = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                  );

                  bool isPast =
                  bookingDate.isBefore(
                    DateTime.now(),
                  );

                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(
                      builder: (_) => ProcessingPage(

                        bookingData: {

                          "month":
                          getMonth(selectedDate!.month),

                          "day":
                          selectedDate!.day.toString(),

                          "weekday":
                          getWeekday(selectedDate!),

                          "fullDate":
                          "${selectedDate!.day} ${getMonth(selectedDate!.month)} ${selectedDate!.year}",

                          "package":
                          package["name"],

                          "time":
                          selectedTime!.format(context),

                          "guests":
                          "$guestCount Guests",

                          "status":
                          isPast
                              ? "Completed"
                              : "Confirmed",

                          "price":
                          "RM ${totalPrice.toStringAsFixed(2)}",

                          "basePrice":
                          "RM ${subtotal.toStringAsFixed(2)}",

                          "serviceCharges":
                          "RM ${serviceCharges.toStringAsFixed(2)}",

                          "serviceTax":
                          "RM ${(totalPrice * 0.06).toStringAsFixed(2)}",

                          "isPast":
                          isPast,
                        },
                      ),
                    ),
                  );
                },

                child: const Text(
                  "Confirm Booking",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget buildRow(
      String title,
      String value, {
        bool isTotal = false,
      }) {

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,

            style: TextStyle(
              fontWeight: FontWeight.bold,

              fontSize:
              isTotal ? 20 : 16,
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Text(
              value,

              textAlign: TextAlign.end,

              style: TextStyle(
                fontWeight: FontWeight.bold,

                fontSize:
                isTotal ? 22 : 16,
              ),
            ),
          ),

        ],
      ),
    );
  }

  String getMonth(int month) {

    List<String> months = [

      "JAN",
      "FEB",
      "MAR",
      "APR",
      "MAY",
      "JUN",
      "JUL",
      "AUG",
      "SEP",
      "OCT",
      "NOV",
      "DEC",

    ];

    return months[month - 1];
  }

  String getWeekday(DateTime date) {

    List<String> weekdays = [

      "MON",
      "TUE",
      "WED",
      "THU",
      "FRI",
      "SAT",
      "SUN",

    ];

    return weekdays[
    date.weekday - 1
    ];
  }
}