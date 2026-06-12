import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class EditBookingPage extends StatefulWidget {

  final Map<String, dynamic> booking;

  final int index;

  const EditBookingPage({
    super.key,
    required this.booking,
    required this.index,
  });

  @override
  State<EditBookingPage> createState() =>
      _EditBookingPageState();
}

class _EditBookingPageState
    extends State<EditBookingPage> {

  late int guestCount;

  late TextEditingController
  dateController;

  late TextEditingController
  timeController;

  late TextEditingController
  packageController;

  double basePrice = 88;

  @override
  void initState() {
    super.initState();

    guestCount = int.parse(

      widget.booking["guests"]
          .toString()
          .split(" ")[0],
    );

    dateController =
        TextEditingController(
          text:
          widget.booking["fullDate"],
        );

    timeController =
        TextEditingController(
          text:
          widget.booking["time"],
        );

    packageController =
        TextEditingController(
          text:
          widget.booking["package"],
        );
  }

  double get subtotal {
    return basePrice * guestCount;
  }

  double get serviceCharges {
    return 550;
  }

  double get serviceTax {
    return subtotal * 0.06;
  }

  double get totalAmount {
    return subtotal +
        serviceCharges +
        serviceTax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:
      Colors.grey.shade100,

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
          "Edit Booking",

          style: TextStyle(
            color: Colors.black,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // PACKAGE TOP

            Row(
              children: [

                Container(
                  width: 90,
                  height: 90,

                  decoration: BoxDecoration(
                    color:
                    Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),
                  ),

                  child: const Icon(
                    Icons.image,
                    size: 35,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        widget.booking["package"],

                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight.bold,

                          fontSize: 26,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "RM ${basePrice.toStringAsFixed(2)} / guest",

                        style: const TextStyle(
                          fontWeight:
                          FontWeight.w500,

                          color: Colors.grey,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

            const SizedBox(height: 35),

            // EVENT DATE

            const Text(
              "Event Date",

              style: TextStyle(
                fontWeight:
                FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(

              onTap: () async {
                DateTime? pickedDate =

                await showDatePicker(

                  context: context,

                  initialDate: DateTime.now(),

                  firstDate: DateTime.now(),

                  lastDate: DateTime(2030),
                );

                if (pickedDate != null) {
                  setState(() {
                    dateController.text =

                    "${pickedDate.day} "
                        "${getMonthName(pickedDate.month)} "
                        "${pickedDate.year}";
                  });
                }
              },

              child: Container(

                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),

                decoration: BoxDecoration(

                  color: Colors.white,

                  border: Border.all(
                    color: Colors.grey,
                  ),

                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.calendar_month,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 12),

                    Text(
                      dateController.text,

                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // EVENT TIME

            const Text(
              "Event Time",

              style: TextStyle(
                fontWeight:
                FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(

              onTap: () async {
                TimeOfDay? pickedTime =

                await showTimePicker(

                  context: context,

                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  setState(() {
                    timeController.text =
                        pickedTime.format(context);
                  });
                }
              },

              child: Container(

                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),

                decoration: BoxDecoration(

                  color: Colors.white,

                  border: Border.all(
                    color: Colors.grey,
                  ),

                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.access_time,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 12),

                    Text(
                      timeController.text,

                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // NUMBER OF GUESTS

            const Text(
              "Number of Guest",

              style: TextStyle(
                fontWeight:
                FontWeight.bold,

                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            Container(

              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              decoration: BoxDecoration(

                border: Border.all(
                  color: Colors.grey,
                ),

                borderRadius:
                BorderRadius.circular(
                  16,
                ),
              ),

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  IconButton(
                    onPressed: () {
                      if (guestCount > 1) {
                        setState(() {
                          guestCount--;
                        });
                      }
                    },

                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),

                  Text(
                    "$guestCount",

                    style:
                    const TextStyle(
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      setState(() {
                        guestCount++;
                      });
                    },

                    icon: const Icon(
                      Icons.add,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "RM ${basePrice.toStringAsFixed(2)} x $guestCount guests",

              style: const TextStyle(
                color: Colors.grey,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // MENU PACKAGE

            const Text(
              "Menu Package",

              style: TextStyle(
                fontWeight:
                FontWeight.bold,

                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: packageController,

              decoration: InputDecoration(

                suffixIcon:
                const Icon(
                  Icons.arrow_forward_ios,
                ),

                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            // PRICE SUMMARY

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color:
                Colors.green.shade50,

                borderRadius:
                BorderRadius.circular(
                  20,
                ),

                border: Border.all(
                  color: Colors.green,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Price Summary",

                    style: TextStyle(
                      color: Colors.green,
                      fontWeight:
                      FontWeight.bold,

                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 20),

                  summaryRow(
                    "Base Price",

                    "RM ${subtotal.toStringAsFixed(2)}",
                  ),

                  summaryRow(
                    "Service Charges",

                    "RM ${serviceCharges.toStringAsFixed(2)}",
                  ),

                  summaryRow(
                    "Service Tax (6%)",

                    "RM ${serviceTax.toStringAsFixed(2)}",
                  ),

                  const Divider(),

                  summaryRow(
                    "Total Amount",

                    "RM ${totalAmount.toStringAsFixed(2)}",

                    isTotal: true,
                  ),

                ],
              ),
            ),

            const SizedBox(height: 35),

            // UPDATE BUTTON

            SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton(

                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.grey.shade700,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                onPressed: () async {

                  List<String> parts =
                  dateController.text.split(" ");

                  String day = "";
                  String month = "";
                  String weekday = "";

                  if (parts.length >= 3) {

                    day = parts[0];
                    month = parts[1];

                    DateTime parsedDate =
                    DateTime.parse(
                      "${parts[2]}-${monthNumber(parts[1])}-${parts[0]}",
                    );

                    weekday =
                        weekdayName(
                          parsedDate.weekday,
                        );
                  }

                  await FirebaseFirestore.instance
                      .collection("reservations")
                      .doc(widget.booking["docId"])
                      .update({

                    "fullDate":
                    dateController.text,

                    "time":
                    timeController.text,

                    "guests":
                    "$guestCount Guests",

                    "package":
                    packageController.text,

                    "price":
                    "RM ${totalAmount.toStringAsFixed(2)}",

                    "basePrice":
                    "RM ${subtotal.toStringAsFixed(2)}",

                    "serviceCharges":
                    "RM ${serviceCharges.toStringAsFixed(2)}",

                    "serviceTax":
                    "RM ${serviceTax.toStringAsFixed(2)}",

                    "day":
                    day,

                    "month":
                    month,

                    "weekday":
                    weekday,
                  });

                  if (!mounted) return;

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Reservation updated successfully",
                      ),
                    ),
                  );

                  Navigator.pop(context);
                },

                child: const Text(
                  "Update Reservation",

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.bold,

                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }

  Widget summaryRow(String title,
      String value, {
        bool isTotal = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,

            style: TextStyle(
              fontWeight:
              isTotal
                  ? FontWeight.bold
                  : FontWeight.w500,

              fontSize:
              isTotal ? 20 : 16,
            ),
          ),

          Text(
            value,

            style: TextStyle(

              color:
              isTotal
                  ? Colors.green
                  : Colors.black,

              fontWeight:
              FontWeight.bold,

              fontSize:
              isTotal ? 20 : 16,
            ),
          ),

        ],
      ),
    );
  }

  String getMonthName(int month) {
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

  String monthNumber(String month) {
    switch (month.toUpperCase()) {
      case "JAN":
        return "01";

      case "FEB":
        return "02";

      case "MAR":
        return "03";

      case "APR":
        return "04";

      case "MAY":
        return "05";

      case "JUN":
        return "06";

      case "JUL":
        return "07";

      case "AUG":
        return "08";

      case "SEP":
        return "09";

      case "OCT":
        return "10";

      case "NOV":
        return "11";

      case "DEC":
        return "12";

      default:
        return "01";
    }
  }

  String weekdayName(int day) {
    switch (day) {
      case 1:
        return "MON";

      case 2:
        return "TUE";

      case 3:
        return "WED";

      case 4:
        return "THU";

      case 5:
        return "FRI";

      case 6:
        return "SAT";

      case 7:
        return "SUN";

      default:
        return "MON";
    }
  }
}