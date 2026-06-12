import 'package:flutter/material.dart';

import 'cart_data.dart';
import 'booking_details_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

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
          "My Cart",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: cartItems.isEmpty

          ? const Center(
        child: Text(
          "No packages added yet.",
        ),
      )

          : ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: cartItems.length,

        itemBuilder: (context, index) {

          // FIXED PACKAGE TYPE
          Map<String, dynamic> package =
          cartItems[index];

          return GestureDetector(

            onTap: () async {

              final confirm =
              await showDialog(

                context: context,

                builder: (_) {

                  return AlertDialog(

                    title: const Text(
                      "Confirm Booking",
                    ),

                    content: const Text(
                      "Do you want to continue with this booking?",
                    ),

                    actions: [

                      TextButton(
                        onPressed: () {

                          Navigator.pop(
                            context,
                            false,
                          );
                        },

                        child: const Text(
                          "Cancel",
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {

                          Navigator.pop(
                            context,
                            true,
                          );
                        },

                        child: const Text(
                          "Confirm",
                        ),
                      ),

                    ],
                  );
                },
              );

              if(confirm == true) {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        BookingDetailsPage(
                          package: Map<String, String>.from(package),
                        ),
                  ),
                );
              }
            },

            child: Container(
              margin: const EdgeInsets.only(
                bottom: 16,
              ),

              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: Row(
                children: [

                  // IMAGE

                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),

                    child: Image.asset(
                      package["image"],
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,

                      errorBuilder: (
                          context,
                          error,
                          stackTrace,
                          ) {
                        return Container(
                          width: 90,
                          height: 90,

                          color: Colors.grey.shade300,

                          child: const Icon(
                            Icons.image,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  // DETAILS

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          package["name"],

                          style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,

                            fontSize: 22,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          package["description"],

                          maxLines: 2,

                          overflow:
                          TextOverflow.ellipsis,

                          style: const TextStyle(
                            height: 1.5,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          package["price"],

                          style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,

                            fontSize: 18,
                          ),
                        ),

                      ],
                    ),
                  ),

                  // DELETE BUTTON

                  IconButton(
                    onPressed: () {

                      setState(() {

                        cartItems.removeAt(index);

                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            "Package removed from cart.",
                          ),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}