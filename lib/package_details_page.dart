import 'package:flutter/material.dart';
import 'booking_details_page.dart';
import 'cart_data.dart';

class PackageDetailsPage extends StatefulWidget {

  final Map<String, String> package;

  const PackageDetailsPage({
    super.key,
    required this.package,
  });

  @override
  State<PackageDetailsPage> createState() =>
      _PackageDetailsPageState();
}

class _PackageDetailsPageState
    extends State<PackageDetailsPage> {

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
          "Package Details",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // IMAGE

            ClipRRect(
              borderRadius: BorderRadius.circular(24),

              child: Image.asset(
                widget.package["image"]!,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            // DETAILS CARD

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(28),
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          widget.package["name"]!,

                          style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,

                            fontSize: 32,
                          ),
                        ),
                      ),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,

                          borderRadius:
                          BorderRadius.circular(20),
                        ),

                        child: Text(
                          widget.package["category"]!,

                          style: const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    widget.package["description"]!,

                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    "What's Included:",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 20),

                  buildIncludedItem(
                    "Main Dishes (5 choices)",
                  ),

                  buildIncludedItem(
                    "Side Dishes (3 choices)",
                  ),

                  buildIncludedItem(
                    "Dessert (2 choices)",
                  ),

                  buildIncludedItem(
                    "Drinks (1 choices)",
                  ),

                  const SizedBox(height: 28),

        // PRICE + BUTTONS

        Column(
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "From",
                      ),

                      Text(
                        "${widget.package["price"]} / guest",

                        overflow:
                        TextOverflow.ellipsis,

                        style: const TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: SizedBox(
                    height: 52,

                    child: OutlinedButton(

                      style:
                      OutlinedButton.styleFrom(
                        side: BorderSide(
                          color:
                          Colors.grey.shade700,
                        ),

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                      ),

                      onPressed: () {

                        bool alreadyExists =
                        cartItems.any(
                              (item) =>
                          item["name"] ==
                              widget.package["name"],
                        );

                        if (!alreadyExists) {

                          cartItems.add(
                            widget.package,
                          );

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(

                            SnackBar(
                              backgroundColor:
                              Colors.green,

                              content: Text(
                                "${widget.package["name"]} added to cart",
                              ),
                            ),
                          );

                        } else {

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(

                            const SnackBar(
                              content: Text(
                                "Package already in cart",
                              ),
                            ),
                          );
                        }
                      },

                      child: const Text(
                        "Add To Cart",

                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 52,

                    child: ElevatedButton(

                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.grey.shade700,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                      ),

                      onPressed: () {

                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                BookingDetailsPage(
                                  package:
                                  widget.package,
                                ),
                          ),
                        );
                      },

                      child: const Text(
                        "Book Now",

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
        ],
      ),
          ),
  ],
    ),
      ),
    );
  }

  Widget buildIncludedItem(
      String text,
      ) {

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),

      child: Row(
        children: [

          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              text,

              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        ],
      ),
    );
  }
}