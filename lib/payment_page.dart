import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'confirmation_page.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, String> package;
  final int guestCount;
  final double subtotal;
  final double serviceCharges;
  final double totalPrice;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String specialRequest;

  const PaymentPage({
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
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPayment = "Card";

  @override
  Widget build(BuildContext context) {
    String bookingDate = widget.selectedDate != null
        ? DateFormat('dd MMM yyyy').format(widget.selectedDate!)
        : "Not Selected";

    String bookingTime = widget.selectedTime != null
        ? widget.selectedTime!.format(context)
        : "Not Selected";

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        title: const Text(
          "Payment Method",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Row(
                children: [

                  Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "All payment data is encrypted and secure",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "RM ${widget.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            paymentOption(
              icon: Icons.credit_card,
              title: "Credit / Debit Card",
              subtitle: "Mastercard • Visa • AMEX",
              value: "Card",
            ),

            paymentOption(
              icon: Icons.paypal,
              title: "Digital Payment",
              subtitle: "PayPal",
              value: "Paypal",
            ),

            paymentOption(
              icon: Icons.account_balance,
              title: "Online Banking",
              subtitle: "Maybank • CIMB • RHB",
              value: "Bank",
            ),

            paymentOption(
              icon: Icons.account_balance_wallet,
              title: "E-Wallet",
              subtitle: "Touch 'n Go • ShopeePay",
              value: "Wallet",
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Booking Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const Divider(height: 25),

                  summaryRow(
                    "Package",
                    widget.package["name"] ?? "",
                  ),

                  summaryRow(
                    "Guests",
                    "${widget.guestCount}",
                  ),

                  summaryRow(
                    "Date",
                    bookingDate,
                  ),

                  summaryRow(
                    "Time",
                    bookingTime,
                  ),

                  summaryRow(
                    "Payment",
                    selectedPayment,
                  ),

                  const Divider(height: 25),

                  summaryRow(
                    "Total",
                    "RM ${widget.totalPrice.toStringAsFixed(2)}",
                    isBold: true,
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConfirmationPage(
                        package: widget.package,
                        guestCount: widget.guestCount,
                        subtotal: widget.subtotal,
                        serviceCharges: widget.serviceCharges,
                        totalPrice: widget.totalPrice,
                        selectedDate: widget.selectedDate,
                        selectedTime: widget.selectedTime,
                        specialRequest: widget.specialRequest,
                        paymentMethod: selectedPayment,
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),

                label: Text(
                  "Pay RM ${widget.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
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

  Widget paymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    bool selected = selectedPayment == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 15),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: selected
                ? Colors.blue
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),

        child: Row(
          children: [

            Icon(
              icon,
              color: Colors.blue,
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                ],
              ),
            ),

            Radio(
              value: value,
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value.toString();
                });
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget summaryRow(
      String title,
      String value, {
        bool isBold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),

      child: Row(
        children: [

          Text(title),

          const Spacer(),

          Text(
            value,
            style: TextStyle(
              fontWeight:
              isBold
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),

        ],
      ),
    );
  }
}