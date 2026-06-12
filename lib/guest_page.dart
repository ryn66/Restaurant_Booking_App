import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {

  final TextEditingController searchController =
  TextEditingController();

  List<Map<String, String>> packages = [

    {
      "name": "Premium Set",
      "description":
      "A luxurious dining experience featuring premium main dishes, flavorful sides, and delightful desserts.",
      "price": "RM 88.00",
    },

    {
      "name": "Family Feast",
      "description":
      "Perfect for family gatherings with a wide variety of delicious dishes designed to satisfy every guest.",
      "price": "RM 128.00",
    },

    {
      "name": "Deluxe Combo",
      "description":
      "A delightful combination of chef-selected dishes crafted for elegant and memorable dining occasions.",
      "price": "RM 68.00",
    },

    {
      "name": "Mini Set",
      "description":
      "A simple yet satisfying meal package ideal for smaller private events and intimate gatherings.",
      "price": "RM 48.00",
    },

  ];

  List<Map<String, String>> filteredPackages = [];

  @override
  void initState() {
    super.initState();

    filteredPackages = packages;
  }

  void searchPackage(String query) {

    setState(() {

      filteredPackages = packages.where((package) {

        final packageName =
        package["name"]!.toLowerCase();

        return packageName.contains(
          query.toLowerCase(),
        );

      }).toList();

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,

        leading: IconButton(
          onPressed: () {},

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        titleSpacing: 0,

        title: const Text(
          "MAMALICIOUS",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.3,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 6),

            child: SizedBox(
              height: 36,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),

                  side: BorderSide(
                    color: Colors.grey.shade400,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                  );
                },

                child: const Text(
                  "Login",

                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 12),

            child: SizedBox(
              height: 36,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  elevation: 0,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),

                  side: BorderSide(
                    color: Colors.grey.shade400,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterPage(),
                    ),
                  );
                },

                child: const Text(
                  "Sign Up",

                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // PROMO SECTION

              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Browse Menu Packages Easily",

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Explore our delicious menu packages.\nLogin or register to make a booking.",

                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // BUTTONS

                        Row(
                          children: [

                            Expanded(
                              child: SizedBox(
                                height: 45,

                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.grey.shade200,

                                    foregroundColor:
                                    Colors.black,

                                    elevation: 0,

                                    side: BorderSide(
                                      color:
                                      Colors.grey.shade500,

                                      width: 1.2,
                                    ),

                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                  ),

                                  onPressed: () {},

                                  child: const Text(
                                    "View Menu",

                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: SizedBox(
                                height: 45,

                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.grey.shade300,

                                    foregroundColor:
                                    Colors.black,

                                    elevation: 0,

                                    side: BorderSide(
                                      color:
                                      Colors.grey.shade500,

                                      width: 1.2,
                                    ),

                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                  ),

                                  onPressed: () {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                        const RegisterPage(),
                                      ),
                                    );
                                  },

                                  child: const Text(
                                    "Sign Up Now",

                                    textAlign:
                                    TextAlign.center,

                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        )

                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    width: 110,
                    height: 110,

                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,

                      borderRadius:
                      BorderRadius.circular(16),
                    ),

                    child: const Icon(
                      Icons.image,
                      size: 40,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 25),

              // SEARCH SECTION

              Row(
                children: [

                  Expanded(
                    child: TextField(

                      controller: searchController,

                      onChanged: (value) {
                        searchPackage(value);
                      },

                      decoration: InputDecoration(
                        hintText:
                        "Search menu packages.....",

                        prefixIcon:
                        const Icon(Icons.search),

                        filled: true,
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      border: Border.all(
                        color: Colors.grey,
                      ),

                      borderRadius:
                      BorderRadius.circular(12),
                    ),

                    child: DropdownButton(
                      underline: const SizedBox(),

                      value: "All Categories",

                      items: const [

                        DropdownMenuItem(
                          value: "All Categories",

                          child: Text(
                            "All Categories",
                          ),
                        ),

                      ],

                      onChanged: (value) {},
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 25),

              const Text(
                "Our Menu Packages",

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Discover our best menu selections",

                style: TextStyle(
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 20),

              // PACKAGE LIST

              ListView.builder(

                itemCount:
                filteredPackages.length,

                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemBuilder: (context, index) {

                  final package =
                  filteredPackages[index];

                  return GestureDetector(

                    onTap: () {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            "Please login to view package details.",
                          ),
                        ),
                      );
                    },

                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 16,
                      ),

                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(22),

                        boxShadow: [

                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.05),

                            blurRadius: 6,

                            offset:
                            const Offset(0, 3),
                          ),

                        ],
                      ),

                      child: Row(
                        children: [

                          Container(
                            width: 95,
                            height: 95,

                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,

                              borderRadius:
                              BorderRadius.circular(18),
                            ),

                            child: const Icon(
                              Icons.image,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(
                                  package["name"]!,

                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold,

                                    fontSize: 18,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  package["description"]!,

                                  maxLines: 3,

                                  overflow:
                                  TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Text(
                                  "From ${package["price"]!}",

                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold,

                                    fontSize: 15,
                                  ),
                                ),

                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // LOGIN PANEL

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(18),
                ),

                child: Row(
                  children: [

                    CircleAvatar(
                      radius: 26,
                      backgroundColor:
                      Colors.grey.shade200,

                      child: const Icon(
                        Icons.person_outline,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Text(
                        "Login or Register to make a booking and manage orders",
                      ),
                    ),

                    Column(
                      children: [

                        ElevatedButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const LoginPage(),
                              ),
                            );
                          },

                          child: const Text("Login"),
                        ),

                        const SizedBox(height: 8),

                        ElevatedButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const RegisterPage(),
                              ),
                            );
                          },

                          child: const Text("Register"),
                        ),

                      ],
                    )

                  ],
                ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: 0,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "Bookings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),

        ],
      ),
    );
  }
}