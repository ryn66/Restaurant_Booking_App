import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'booking_view_page.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() =>
      _BookingsPageState();
}

class _BookingsPageState
    extends State<BookingsPage> {

  bool showUpcoming = true;

  @override
  Widget build(BuildContext context) {

    final currentUser =
        FirebaseAuth.instance.currentUser;

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        centerTitle: true,

        title: const Text(
          "My Reservations",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          const SizedBox(height: 10),

          // TABS

          Row(
            children: [

              Expanded(
                child: GestureDetector(

                  onTap: () {

                    setState(() {
                      showUpcoming = true;
                    });
                  },

                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                          showUpcoming
                              ? Colors.black
                              : Colors.grey,

                          width: 2,
                        ),
                      ),
                    ),

                    child: Text(
                      "Upcoming",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,

                        color:
                        showUpcoming
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(

                  onTap: () {

                    setState(() {
                      showUpcoming = false;
                    });
                  },

                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                          !showUpcoming
                              ? Colors.black
                              : Colors.grey,

                          width: 2,
                        ),
                      ),
                    ),

                    child: Text(
                      "Past",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,

                        color:
                        !showUpcoming
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

          Expanded(

            child: StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance
                  .collection("reservations")
                  .where(
                "userId",
                isEqualTo:
                currentUser?.uid,
              )
                  .snapshots(),

              builder:
                  (context, snapshot) {

                if(snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if(!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {

                  return Center(
                    child: Text(

                      showUpcoming
                          ? "No upcoming reservations."
                          : "No past reservations.",

                      style:
                      const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                final docs =
                    snapshot.data!.docs;

                final filteredDocs =
                docs.where((doc) {

                  final booking =
                  doc.data()
                  as Map<String, dynamic>;

                  bool isPast =
                  isReservationPast(
                    booking["fullDate"],
                  );

                  if(showUpcoming) {
                    return !isPast;
                  }

                  return isPast;

                }).toList();

                if(filteredDocs.isEmpty) {

                  return Center(
                    child: Text(

                      showUpcoming
                          ? "No upcoming reservations."
                          : "No past reservations.",

                      style:
                      const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(

                  padding:
                  const EdgeInsets.all(20),

                  itemCount:
                  filteredDocs.length,

                  itemBuilder:
                      (context, index) {

                    final doc =
                    filteredDocs[index];

                    final booking =
                    doc.data()
                    as Map<String, dynamic>;

                    booking["docId"] =
                        doc.id;

                    return GestureDetector(

                      onTap: () {

                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                BookingViewPage(
                                  booking:
                                  booking,

                                  index:
                                  index,
                                ),
                          ),
                        );
                      },

                      child: Container(

                        margin:
                        const EdgeInsets.only(
                          bottom: 20,
                        ),

                        padding:
                        const EdgeInsets.all(
                          16,
                        ),

                        decoration:
                        BoxDecoration(
                          color:
                          Colors.white,

                          borderRadius:
                          BorderRadius.circular(
                            24,
                          ),
                        ),

                        child: Row(
                          children: [

                            Container(
                              width: 70,
                              height: 90,

                              decoration:
                              BoxDecoration(

                                color:
                                Colors.grey
                                    .shade100,

                                borderRadius:
                                BorderRadius.circular(
                                  14,
                                ),

                                border:
                                Border.all(
                                  color:
                                  Colors.grey
                                      .shade400,
                                ),
                              ),

                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [

                                  Text(
                                    booking["month"] ??
                                        "",
                                  ),

                                  Text(
                                    booking["day"] ??
                                        "",

                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,

                                      fontSize:
                                      28,
                                    ),
                                  ),

                                  Text(
                                    booking["weekday"] ??
                                        "",
                                  ),

                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 18,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                                children: [

                                  Text(
                                    booking["package"],

                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,

                                      fontSize:
                                      22,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons
                                            .access_time,

                                        size: 18,

                                        color:
                                        Colors.grey,
                                      ),

                                      const SizedBox(
                                        width: 6,
                                      ),

                                      Text(
                                        booking["time"],
                                      ),

                                    ],
                                  ),

                                  const SizedBox(
                                    height: 6,
                                  ),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons.groups,

                                        size: 18,

                                        color:
                                        Colors.grey,
                                      ),

                                      const SizedBox(
                                        width: 6,
                                      ),

                                      Text(
                                        booking["guests"],
                                      ),

                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,

                                    children: [

                                      Text(
                                        isReservationPast(
                                          booking["fullDate"],
                                        )
                                            ? "Completed"
                                            : "Confirmed",

                                        style:
                                        TextStyle(

                                          color:
                                          isReservationPast(
                                            booking["fullDate"],
                                          )
                                              ? Colors.grey
                                              : Colors.green,

                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),

                                      Text(
                                        booking["price"],

                                        style:
                                        const TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            const Icon(
                              Icons
                                  .arrow_forward_ios,

                              size: 18,
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.only(
              bottom: 20,
            ),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                const Icon(
                  Icons.info_outline,
                  color: Colors.grey,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    "Tap on a booking to view details or manage your reservation",

                    style: TextStyle(
                      color:
                      Colors.grey.shade600,
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
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

bool isReservationPast(String fullDate) {
  try {
    List<String> parts = fullDate.split(" ");

    DateTime eventDate = DateTime.parse(
      "${parts[2]}-${monthNumber(parts[1])}-${parts[0]}",
    );

    DateTime today = DateTime.now();

    DateTime currentDate = DateTime(
      today.year,
      today.month,
      today.day,
    );

    return eventDate.isBefore(currentDate);

  } catch (e) {
    return false;
  }
}