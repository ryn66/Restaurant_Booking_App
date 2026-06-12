import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_manage_package_page.dart';
import 'admin_manage_user.dart';
import 'admin_manage_booking.dart';


class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,

    children: [

      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.black,
        ),

        child: Align(
          alignment: Alignment.bottomLeft,

          child: Text(
            "Admin Menu",

            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      ListTile(
        leading: const Icon(
          Icons.dashboard,
        ),

        title: const Text(
          "Dashboard",
        ),

        onTap: () {
          Navigator.pop(context);
        },
      ),

     ListTile(
  leading: const Icon(
    Icons.restaurant_menu,
  ),

  title: const Text(
    "Manage Packages",
  ),

  onTap: () {

    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) =>
        const AdminManageBookingPage(),
  ),
);

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AdminManagePackagePage(),
      ),
    );
  },
),

      ListTile(
        leading: const Icon(
          Icons.people,
        ),

        title: const Text(
          "Manage Users",
        ),

        onTap: () {

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) =>
        const AdminManageUserPage(),
  ),
);
     },
     
      ),
ListTile(
  leading: const Icon(
    Icons.calendar_month,
  ),

  title: const Text(
    "Manage Bookings",
  ),

  onTap: () {

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AdminManageBookingPage(),
      ),
    );
  },
),

      const Divider(),

      ListTile(
        leading: const Icon(
          Icons.logout,
          color: Colors.red,
        ),

        title: const Text(
          "Logout",
          style: TextStyle(
            color: Colors.red,
          ),
        ),

        onTap: () {

          Navigator.pop(context);

          Navigator.pop(context);

        },
      ),

    ],
  ),
),



      backgroundColor: Colors.grey.shade100,

appBar: AppBar(
  backgroundColor: Colors.black,
  elevation: 0,

  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  title: const Text(
    "Admin Dashboard",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),

  actions: [

    IconButton(
      onPressed: () {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Notifications coming soon",
            ),
          ),
        );
      },

      icon: const Icon(
        Icons.notifications,
        color: Colors.white,
      ),
    ),

    IconButton(
      onPressed: () {

        Navigator.pop(context);
      },

      icon: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
    ),

  ],
),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),

            const Text(
              "Welcome, Admin 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Manage reservations and users",
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 25),

Row(
  children: [

    Expanded(
      child: dashboardCard(
        title: "Packages",
        count: 12,
        icon: Icons.restaurant_menu,
        color: Colors.orange,
      ),
    ),

    const SizedBox(width: 15),

    Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .snapshots(),
        builder: (context, snapshot) {

          int totalUsers =
              snapshot.data?.docs.length ?? 0;

          return dashboardCard(
            title: "Users",
            count: totalUsers,
            icon: Icons.people,
            color: Colors.blue,
          );
        },
      ),
    ),

    const SizedBox(width: 15),

    Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("reservations")
            .snapshots(),
        builder: (context, snapshot) {

          int totalBookings =
              snapshot.data?.docs.length ?? 0;

          return dashboardCard(
            title: "Bookings",
            count: totalBookings,
            icon: Icons.calendar_month,
            color: Colors.green,
          );
        },
      ),
    ),

  ],
),

            const SizedBox(height: 30),

           Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),

    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  ),

  child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Recent Bookings",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

const SizedBox(height: 15),

StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection("reservations")
      .orderBy(
        "createdAt",
        descending: true,
      )
      .limit(10)
      .snapshots(),

  builder: (context, snapshot) {

    if (!snapshot.hasData) {

      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final bookings = snapshot.data!.docs;

    if (bookings.isEmpty) {

      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            "No Bookings Found",
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: DataTable(

        columnSpacing: 200,
        horizontalMargin: 40,
        dataRowMinHeight: 65,
        dataRowMaxHeight: 65,

        columns: const [

          DataColumn(
            label: SizedBox(
              width: 300,
              child: Text(
                "Package",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          DataColumn(
            label: SizedBox(
              width: 120,
              child: Text(
                "Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          DataColumn(
            label: SizedBox(
              width: 180,
              child: Text(
                "Guests",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          DataColumn(
            label: SizedBox(
              width: 50,
              child: Text(
                "Status",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        ],

        rows: bookings.map((doc) {

          final booking =
              doc.data() as Map<String, dynamic>;

          return DataRow(
            cells: [

              DataCell(
                SizedBox(
                  width: 300,
                  child: Text(
                    booking["package"] ?? "-",
                  ),
                ),
              ),

              DataCell(
                SizedBox(
                  width: 220,
                  child: Text(
                    booking["fullDate"] ?? "-",
                  ),
                ),
              ),

              DataCell(
                SizedBox(
                  width: 180,
                  child: Text(
                    booking["guests"]?.toString() ?? "-",
                  ),
                ),
              ),

              DataCell(
                SizedBox(
                  width: 220,

                  child: Container(
                    alignment: Alignment.center,

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: getStatusColor(
                        booking["status"],
                      ),

                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: Text(
                      booking["status"] ?? "-",

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          );
        }).toList(),
      ),
    );
  },
),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black,
                ),

                onPressed: () {

                },

                icon: const Icon(
                  Icons.list,
                  color: Colors.white,
                ),

                label: const Text(
                  "View All Bookings",

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

                       ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget dashboardCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    Stream<QuerySnapshot>? stream,
  }) {

    return Container(

      height: 130,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            color: color,
            size: 35,
          ),

          const SizedBox(height: 10),

          Text(
            count.toString(),

            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  static Color getStatusColor(
      String? status) {

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
}