import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_booking_page.dart';

class BookingViewPage extends StatelessWidget {
  final Map<String, dynamic> booking;
  final int index;

  const BookingViewPage({
    super.key,
    required this.booking,
    required this.index,
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
          "Booking Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [
                Container(
                  width: 80,
                  height: 100,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(14),

                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [
                      Text(
                        booking["month"] ?? "",
                      ),

                      Text(
                        booking["day"] ?? "",
                        style: const TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),

                      Text(
                        booking["weekday"] ?? "",
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.end,

                  children: [
                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color:
                        Colors.green.shade100,

                        borderRadius:
                        BorderRadius.circular(
                            20),
                      ),

                      child: Text(
                        booking["status"] ??
                            "Confirmed",

                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      booking["price"] ?? "",
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),

            infoRow(
              Icons.calendar_month,
              booking["fullDate"] ?? "",
            ),

            const SizedBox(height: 20),

            infoRow(
              Icons.access_time,
              booking["time"] ?? "",
            ),

            const SizedBox(height: 20),

            infoRow(
              Icons.groups,
              booking["guests"] ?? "",
            ),

            const SizedBox(height: 40),

            const Divider(),

            const SizedBox(height: 30),

            const Text(
              "Price Summary",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 25),

            summaryRow(
              "Base Price",
              booking["basePrice"] ?? "",
            ),

            summaryRow(
              "Service Charges",
              booking["serviceCharges"] ?? "",
            ),

            summaryRow(
              "Service Tax (6%)",
              booking["serviceTax"] ?? "",
            ),

            const SizedBox(height: 25),

            summaryRow(
              "Total Amount",
              booking["price"] ?? "",
              isTotal: true,
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,

                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.grey.shade300,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              16),
                        ),
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                EditBookingPage(
                                  booking: booking,
                                  index: index,
                                ),
                          ),
                        );
                      },

                      child: const Text(
                        "Edit Booking",

                        style: TextStyle(
                          color: Colors.black,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: SizedBox(
                    height: 55,

                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.red,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              16),
                        ),
                      ),

                      onPressed: () {
                        showDialog(
                          context: context,

                          builder: (_) {
                            return AlertDialog(
                              title: const Text(
                                "Cancel Booking",
                              ),

                              content: const Text(
                                "Are you sure you want to cancel this reservation?",
                              ),

                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context);
                                  },

                                  child:
                                  const Text(
                                    "No",
                                  ),
                                ),

                                TextButton(
                                  onPressed:
                                      () async {
                                    await FirebaseFirestore
                                        .instance
                                        .collection(
                                        "reservations")
                                        .doc(booking[
                                    "docId"])
                                        .delete();

                                    if (context
                                        .mounted) {
                                      Navigator.pop(
                                          context);

                                      Navigator.pop(
                                          context);

                                      ScaffoldMessenger.of(
                                          context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Reservation cancelled successfully",
                                          ),
                                        ),
                                      );
                                    }
                                  },

                                  child:
                                  const Text(
                                    "Yes",
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      child: const Text(
                        "Cancel Booking",

                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(
      IconData icon,
      String text,
      ) {
    return Row(
      children: [
        Icon(icon),

        const SizedBox(width: 14),

        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget summaryRow(
      String title,
      String value, {
        bool isTotal = false,
      }) {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 18),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,

            style: TextStyle(
              fontWeight: isTotal
                  ? FontWeight.bold
                  : FontWeight.w500,

              fontSize:
              isTotal ? 22 : 18,
            ),
          ),

          Text(
            value,

            style: TextStyle(
              color: isTotal
                  ? Colors.green
                  : Colors.black,

              fontWeight:
              FontWeight.bold,

              fontSize:
              isTotal ? 24 : 18,
            ),
          ),
        ],
      ),
    );
  }
}