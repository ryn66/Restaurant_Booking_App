import 'package:flutter/material.dart';

import 'summary_page.dart';

class CustomizePackagePage
    extends StatefulWidget {

  final Map<String, String> package;

  final int guestCount;

  final double subtotal;

  final DateTime? selectedDate;

  final TimeOfDay? selectedTime;

  const CustomizePackagePage({
    super.key,
    required this.package,
    required this.guestCount,
    required this.subtotal,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  State<CustomizePackagePage> createState() =>
      _CustomizePackagePageState();
}

class _CustomizePackagePageState
    extends State<CustomizePackagePage> {

  bool liveCooking = true;
  bool extraDecor = true;
  bool specialCake = false;
  bool extraDrinks = false;

  final TextEditingController requestController =
  TextEditingController();

  double get serviceCharges {

    double total = 0;

    if(liveCooking) total += 200;
    if(extraDecor) total += 200;
    if(specialCake) total += 200;
    if(extraDrinks) total += 200;

    return total;
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
          "Customize Package",

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

            const Text(
              "Add-On Services",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 20),

            CheckboxListTile(
              value: liveCooking,

              onChanged: (value) {

                setState(() {
                  liveCooking = value!;
                });
              },

              title: const Text(
                "Live Cooking Station (+RM200)",
              ),

              controlAffinity:
              ListTileControlAffinity.leading,

              contentPadding: EdgeInsets.zero,
            ),

            CheckboxListTile(
              value: extraDecor,

              onChanged: (value) {

                setState(() {
                  extraDecor = value!;
                });
              },

              title: const Text(
                "Extra Decor (+RM200)",
              ),

              controlAffinity:
              ListTileControlAffinity.leading,

              contentPadding: EdgeInsets.zero,
            ),

            CheckboxListTile(
              value: specialCake,

              onChanged: (value) {

                setState(() {
                  specialCake = value!;
                });
              },

              title: const Text(
                "Special Cake (+RM200)",
              ),

              controlAffinity:
              ListTileControlAffinity.leading,

              contentPadding: EdgeInsets.zero,
            ),

            CheckboxListTile(
              value: extraDrinks,

              onChanged: (value) {

                setState(() {
                  extraDrinks = value!;
                });
              },

              title: const Text(
                "Extra Drinks (+RM200)",
              ),

              controlAffinity:
              ListTileControlAffinity.leading,

              contentPadding: EdgeInsets.zero,
            ),

            const Divider(height: 40),

            const Text(
              "Special Requests (Optional)",

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: requestController,

              maxLines: 4,

              decoration: InputDecoration(
                hintText:
                "Type your request here..",

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  "Service Charges",

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                Text(
                  "RM ${serviceCharges.toStringAsFixed(2)}",

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

              ],
            ),

            const Spacer(),

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
                      builder: (_) => SummaryPage(
                        package: widget.package,

                        guestCount:
                        widget.guestCount,

                        subtotal:
                        widget.subtotal,

                        serviceCharges:
                        serviceCharges,

                        totalPrice:
                        widget.subtotal +
                            serviceCharges,

                        selectedDate:
                        widget.selectedDate,

                        selectedTime:
                        widget.selectedTime,

                        specialRequest:
                        requestController.text,
                      ),
                    ),
                  );
                },

                child: const Text(
                  "View Summary",

                  style: TextStyle(
                    color: Colors.white,
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