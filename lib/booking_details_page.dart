import 'package:flutter/material.dart';

import 'customize_package_page.dart';

class BookingDetailsPage extends StatefulWidget {

  final Map<String, String> package;

  const BookingDetailsPage({
    super.key,
    required this.package,
  });

  @override
  State<BookingDetailsPage> createState() =>
      _BookingDetailsPageState();
}

class _BookingDetailsPageState
    extends State<BookingDetailsPage> {

  DateTime? selectedDate;

  TimeOfDay? selectedTime;

  int guestCount = 20;

  double subtotal = 1760;

  @override
  void initState() {
    super.initState();

    calculateSubtotal();
  }

  void calculateSubtotal() {

    String priceText =
    widget.package["price"]!
        .replaceAll("RM", "")
        .trim();

    double price =
    double.parse(priceText);

    subtotal =
        price * guestCount;
  }

  Future<void> pickDate() async {

    DateTime? pickedDate =
    await showDatePicker(
      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime.now(),

      lastDate: DateTime(2030),
    );

    if(pickedDate != null) {

      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> pickTime() async {

    TimeOfDay? pickedTime =
    await showTimePicker(
      context: context,

      initialTime:
      TimeOfDay.now(),
    );

    if(pickedTime != null) {

      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

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
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Row(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(18),

                  child: Image.asset(
                    widget.package["image"]!,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 16),

                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      widget.package["name"]!,

                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,

                        fontSize: 24,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${widget.package["price"]} / per guest",

                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                  ],
                ),

              ],
            ),

            const SizedBox(height: 40),

            const Text(
              "Event Date",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(

              onTap: pickDate,

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(16),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.calendar_month,
                    ),

                    const SizedBox(width: 12),

                    Text(

                      selectedDate == null

                          ? "Select Date"

                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",

                      style: TextStyle(

                        color:
                        selectedDate == null
                            ? Colors.grey
                            : Colors.black,

                        fontSize: 16,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Event Time",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(

              onTap: pickTime,

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(16),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.access_time,
                    ),

                    const SizedBox(width: 12),

                    Text(

                      selectedTime == null

                          ? "Select Time"

                          : selectedTime!.format(context),

                      style: TextStyle(

                        color:
                        selectedTime == null
                            ? Colors.grey
                            : Colors.black,

                        fontSize: 16,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Number of Guests",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(16),
              ),

              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  IconButton(
                    onPressed: () {

                      if(guestCount > 10) {

                        setState(() {

                          guestCount--;

                          calculateSubtotal();
                        });
                      }
                    },

                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),

                  Text(
                    "$guestCount",

                    style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,

                      fontSize: 24,
                    ),
                  ),

                  IconButton(
                    onPressed: () {

                      setState(() {

                        guestCount++;

                        calculateSubtotal();
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

            const Text(
              "Minimum 10 guests",

              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                Text(
                  "Subtotal ($guestCount x ${widget.package["price"]})",

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                Text(
                  "RM ${subtotal.toStringAsFixed(2)}",

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor:

                  selectedDate != null &&
                      selectedTime != null

                      ? Colors.grey.shade700
                      : Colors.grey,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                ),

                onPressed:

                selectedDate == null ||
                    selectedTime == null

                    ? null

                    : () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          CustomizePackagePage(
                            package:
                            widget.package,

                            guestCount:
                            guestCount,

                            subtotal:
                            subtotal,

                            selectedDate:
                            selectedDate,

                            selectedTime:
                            selectedTime,
                          ),
                    ),
                  );
                },

                child: const Text(
                  "Customize Package",

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}