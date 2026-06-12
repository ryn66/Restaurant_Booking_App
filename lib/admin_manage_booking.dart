import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminManageBookingPage extends StatefulWidget {
  const AdminManageBookingPage({super.key});

  @override
  State<AdminManageBookingPage> createState() =>
      _AdminManageBookingPageState();
}

class _AdminManageBookingPageState
    extends State<AdminManageBookingPage> {

  final TextEditingController searchController =
      TextEditingController();

  Future<void> updateBookingStatus(
    String docId,
    String status,
  ) async {

    await FirebaseFirestore.instance
        .collection("reservations")
        .doc(docId)
        .update({
      "status": status,
    });
  }

  Color getStatusColor(String? status) {

    switch (status) {

      case "Confirmed":
        return Colors.green;

      case "Pending":
        return Colors.orange;

      case "Cancelled":
        return Colors.red;

      case "Completed":
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.black,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          "Manage Bookings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: searchController,

              decoration: InputDecoration(
                hintText: "Search Booking",

                prefixIcon:
                    const Icon(Icons.search),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color:
                      Colors.lightBlue.shade100,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: StreamBuilder<QuerySnapshot>(

                  stream: FirebaseFirestore
                      .instance
                      .collection(
                          "reservations")
                      .orderBy(
                        "createdAt",
                        descending: true,
                      )
                      .snapshots(),

                  builder:
                      (context, snapshot) {

                    if (!snapshot.hasData) {

                      return const Center(
                        child:
                            CircularProgressIndicator(),
                      );
                    }

                    final bookings =
                        snapshot.data!.docs;

                    if (bookings.isEmpty) {

                      return const Center(
                        child: Text(
                          "No Bookings Found",
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal,

                      child: DataTable(

                        headingRowColor:
                            WidgetStateProperty
                                .all(
                          Colors.grey.shade800,
                        ),

                        columns: const [

                          DataColumn(
                            label: Text(
                              "User",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Package",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Date",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Time",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Guests",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Price",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Status",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              "Action",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),

                        ],

                        rows: bookings.map((doc) {

                          final booking =
                              doc.data()
                                  as Map<String,
                                      dynamic>;

                          return DataRow(
                            cells: [

                              DataCell(
  FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection("users")
        .doc(booking["userId"])
        .get(),

    builder: (context, userSnapshot) {

      if (!userSnapshot.hasData) {
        return const Text("Loading...");
      }

      if (!userSnapshot.data!.exists) {
        return Text(
          booking["userId"] ?? "-",
        );
      }

      final userData =
          userSnapshot.data!.data()
              as Map<String, dynamic>;

      return Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Text(
            userData["name"] ?? "No Name",

            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            booking["userId"] ?? "-",

            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      );
    },
  ),
),

                              DataCell(
                                Text(
                                  booking[
                                          "package"] ??
                                      "-",
                                ),
                              ),

                              DataCell(
                                Text(
                                  booking[
                                          "fullDate"] ??
                                      "-",
                                ),
                              ),

                              DataCell(
                                Text(
                                  booking[
                                          "time"] ??
                                      "-",
                                ),
                              ),

                              DataCell(
                                Text(
                                  booking[
                                          "guests"] ??
                                      "-",
                                ),
                              ),

                              DataCell(
                                Text(
                                  booking[
                                          "price"] ??
                                      "-",
                                ),
                              ),

                              DataCell(
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        getStatusColor(
                                      booking[
                                          "status"],
                                    ),

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      20,
                                    ),
                                  ),

                                  child: Text(
                                    booking[
                                            "status"] ??
                                        "-",

                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.white,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ),
                              ),

                              DataCell(

                                PopupMenuButton<
                                    String>(

                                  onSelected:
                                      (value) {

                                    updateBookingStatus(
                                      doc.id,
                                      value,
                                    );
                                  },

                                  itemBuilder:
                                      (context) => [

                                    const PopupMenuItem(
                                      value:
                                          "Confirmed",

                                      child: Text(
                                        "Approve",
                                      ),
                                    ),

                                    const PopupMenuItem(
                                      value:
                                          "Pending",

                                      child: Text(
                                        "Pending",
                                      ),
                                    ),

                                    const PopupMenuItem(
                                      value:
                                          "Cancelled",

                                      child: Text(
                                        "Reject",
                                      ),
                                    ),

                                    const PopupMenuItem(
                                      value:
                                          "Completed",

                                      child: Text(
                                        "Completed",
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}