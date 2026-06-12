import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminManageUserPage extends StatefulWidget {
  const AdminManageUserPage({super.key});

  @override
  State<AdminManageUserPage> createState() =>
      _AdminManageUserPageState();
}

class _AdminManageUserPageState
    extends State<AdminManageUserPage> {

  final TextEditingController searchController =
      TextEditingController();

  Future<void> updateStatus(
    String docId,
    String status,
  ) async {

    await FirebaseFirestore.instance
        .collection("users")
        .doc(docId)
        .update({
      "status": status,
    });
  }

  Future<void> deleteUser(
      String docId) async {

    bool? confirm =
        await showDialog<bool>(
      context: context,

      builder: (context) {

        return AlertDialog(
          title: const Text(
            "Delete User",
          ),

          content: const Text(
            "Delete this user?",
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
                "Delete",
              ),
            ),

          ],
        );
      },
    );

    if (confirm == true) {

      await FirebaseFirestore.instance
          .collection("users")
          .doc(docId)
          .delete();
    }
  }

  void showActionMenu(
    String docId,
  ) {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Action",
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [

              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green,
                ),

                onPressed: () async {

                  await updateStatus(
                    docId,
                    "Active",
                  );

                  Navigator.pop(
                    context,
                  );
                },

                child: const Text(
                  "Approve",
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red,
                ),

                onPressed: () async {

                  await updateStatus(
                    docId,
                    "Blocked",
                  );

                  Navigator.pop(
                    context,
                  );
                },

                child: const Text(
                  "Decline",
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.black,

        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          "Manage Users",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),

        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            Row(

              children: [

                Expanded(
                  child: TextField(
                    controller:
                        searchController,

                    decoration:
                        InputDecoration(

                      hintText:
                          "Search",

                      prefixIcon:
                          const Icon(
                        Icons.search,
                      ),

                      filled: true,
                      fillColor:
                          Colors.white,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),

                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(

                  height: 55,
                  width: 55,

                  decoration:
                      BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),
                  ),

                  child: const Icon(
                    Icons.filter_alt_outlined,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Expanded(

              child: Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(15),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.lightBlue
                          .shade100,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Text(
                      "User List",

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Expanded(

                      child:
                          StreamBuilder<
                              QuerySnapshot>(

                        stream:
                            FirebaseFirestore
                                .instance
                                .collection(
                                    "users")
                                .snapshots(),

                        builder:
                            (context,
                                snapshot) {

                          if (!snapshot
                              .hasData) {

                            return const Center(
                              child:
                                  CircularProgressIndicator(),
                            );
                          }

                          final users =
                              snapshot
                                  .data!
                                  .docs;

                          return SingleChildScrollView(
                            scrollDirection:
                                Axis.horizontal,

                            child:
                                DataTable(

                              headingRowColor:
                                  WidgetStateProperty
                                      .all(
                                Colors
                                    .grey
                                    .shade800,
                              ),

                              columns:
                                  const [

                                DataColumn(
                                  label:
                                      Text(
                                    "Name",

                                    style:
                                        TextStyle(
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                                ),

                                DataColumn(
                                  label:
                                      Text(
                                    "Email",

                                    style:
                                        TextStyle(
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                                ),

                                DataColumn(
                                  label:
                                      Text(
                                    "Status",

                                    style:
                                        TextStyle(
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                                ),

                                DataColumn(
                                  label:
                                      Text(
                                    "Action",

                                    style:
                                        TextStyle(
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                                ),

                              ],

                              rows:
                                  users.map(
                                (doc) {

                                  final user =
                                      doc.data()
                                          as Map<
                                              String,
                                              dynamic>;

                                  return DataRow(
                                    cells: [

                                      DataCell(
                                        Text(
                                          user["name"] ??
                                              "-",
                                        ),
                                      ),

                                      DataCell(
                                        Text(
                                          user["email"] ??
                                              "-",
                                        ),
                                      ),

                                      DataCell(
                                        Text(
                                          user["status"] ??
                                              "Pending",
                                        ),
                                      ),

                                      DataCell(

                                        Row(
                                          children: [

                                            IconButton(
                                              onPressed:
                                                  () {
                                                showActionMenu(
                                                  doc.id,
                                                );
                                              },

                                              icon:
                                                  const Icon(
                                                Icons
                                                    .visibility,
                                              ),
                                            ),

                                            IconButton(
                                              onPressed:
                                                  () {
                                                showActionMenu(
                                                  doc.id,
                                                );
                                              },

                                              icon:
                                                  const Icon(
                                                Icons
                                                    .edit,
                                                color:
                                                    Colors.blue,
                                              ),
                                            ),

                                            IconButton(
                                              onPressed:
                                                  () {
                                                deleteUser(
                                                  doc.id,
                                                );
                                              },

                                              icon:
                                                  const Icon(
                                                Icons
                                                    .delete,
                                                color:
                                                    Colors.red,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),

                                    ],
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}