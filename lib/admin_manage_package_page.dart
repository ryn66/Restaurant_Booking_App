import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminManagePackagePage extends StatefulWidget {
  const AdminManagePackagePage({super.key});

  @override
  State<AdminManagePackagePage> createState() => _AdminManagePackagePageState();
}

class _AdminManagePackagePageState extends State<AdminManagePackagePage> {
  final TextEditingController searchController = TextEditingController();

  // 1. ADD PACKAGE DIALOG
  Future<void> showAddPackageDialog() async {
    final packageController = TextEditingController();

    final descriptionController = TextEditingController();

    final locationController = TextEditingController();

    final priceController = TextEditingController();

    final includedController = TextEditingController();

    final addOnController = TextEditingController();

    showDialog(
      context: context,

      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          child: Container(
            width: 500,
            height: 700,

            padding: const EdgeInsets.all(20),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        "Add New Package",

                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),

                  TextField(
                    controller: packageController,

                    decoration: const InputDecoration(
                      labelText: "Package Name",
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: descriptionController,

                    decoration: const InputDecoration(labelText: "Description"),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: locationController,

                    decoration: const InputDecoration(labelText: "Location"),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: addOnController,

                    decoration: const InputDecoration(
                      labelText: "Add-On Services",
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: priceController,

                    decoration: const InputDecoration(labelText: "Price (RM)"),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: includedController,

                    decoration: const InputDecoration(labelText: "Included"),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,

                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),

                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("packages")
                            .add({
                              "name": packageController.text,

                              "description": descriptionController.text,

                              "location": locationController.text,

                              "addOn": addOnController.text,

                              "included": includedController.text,

                              "price": priceController.text,

                              "createdAt": Timestamp.now(),
                            });

                        Navigator.pop(context);
                      },

                      child: const Text("Add Package"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 2. DELETE PACKAGE
  Future<void> deletePackage(String docId) async {
    bool? confirm = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Package"),

          content: const Text("Are you sure you want to delete this package?"),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await FirebaseFirestore.instance
          .collection("packages")
          .doc(docId)
          .delete();
    }
  }

  // 3. EDIT PACKAGE
  Future<void> editPackage(String docId, Map<String, dynamic> package) async {
    final locationController = TextEditingController(
      text: package["location"] ?? "",
    );

    final addOnController = TextEditingController(text: package["addOn"] ?? "");

    final packageController = TextEditingController(text: package["name"]);

    final includedController = TextEditingController(text: package["included"]);

    final descriptionController = TextEditingController(
      text: package["description"],
    );

    final priceController = TextEditingController(
      text: package["price"]?.toString() ?? "",
    );
    await showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Package"),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                TextField(
                  controller: packageController,
                  decoration: const InputDecoration(labelText: "Package Name"),
                ),

                TextField(
                  controller: includedController,
                  decoration: const InputDecoration(labelText: "Included"),
                ),

                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),

                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("packages")
                    .doc(docId)
                    .update({
                      "name": packageController.text,

                      "description": descriptionController.text,

                      "location": locationController.text,

                      "addOn": addOnController.text,

                      "included": includedController.text,

                      "price": priceController.text,
                    });

                Navigator.pop(context);
              },

              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.black,

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text(
          "Manage Package",

          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notifications coming soon")),
              );
            },

            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            TextField(
              controller: searchController,

              decoration: InputDecoration(
                hintText: "Search",

                prefixIcon: const Icon(Icons.search),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 50,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade100,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {
                  showAddPackageDialog();
                },

                icon: const Icon(Icons.add_circle_outline, color: Colors.black),

                label: const Text(
                  "Add New Package",

                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Package List",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("packages")
                        .orderBy("createdAt", descending: true)
                        .snapshots(),

                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final packages = snapshot.data!.docs;

                      if (packages.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(20),

                          child: Center(child: Text("No Packages Found")),
                        );
                      }

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                            Colors.grey.shade800,
                          ),

                          columns: const [
                            DataColumn(
                              label: Text(
                                "Package",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Description",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Location",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Add-On",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                " Included",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Price (RM)",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Actions",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],

                          rows: packages.map((doc) {
                            final package = doc.data() as Map<String, dynamic>;

                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(package["name"]?.toString() ?? ""),
                                ),

                                DataCell(
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      package["description"]?.toString() ?? "",
                                    ),
                                  ),
                                ),

                                DataCell(
                                  Text(package["location"]?.toString() ?? ""),
                                ),

                                DataCell(
                                  Text(package["addOn"]?.toString() ?? ""),
                                ),

                                DataCell(
                                  Text(package["included"]?.toString() ?? ""),
                                ),

                                DataCell(
                                  Text(package["price"]?.toString() ?? ""),
                                ),

                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          editPackage(doc.id, package);
                                        },

                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () async {
                                          bool?
                                          confirm = await showDialog<bool>(
                                            context: context,

                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "Delete Package",
                                                ),

                                                content: const Text(
                                                  "Are you sure you want to delete this package?",
                                                ),

                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        context,
                                                        false,
                                                      );
                                                    },

                                                    child: const Text("No"),
                                                  ),

                                                  ElevatedButton(
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),

                                                    onPressed: () {
                                                      Navigator.pop(
                                                        context,
                                                        true,
                                                      );
                                                    },

                                                    child: const Text("Yes"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          if (confirm == true) {
                                            await FirebaseFirestore.instance
                                                .collection("packages")
                                                .doc(doc.id)
                                                .delete();

                                            if (mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Package deleted successfully",
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        },

                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
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

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Text(
                        "Firebase Live Data",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
}
