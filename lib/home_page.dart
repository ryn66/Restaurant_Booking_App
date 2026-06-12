import 'package:flutter/material.dart';

import 'cart_data.dart';
import 'cart_page.dart';
import 'package_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String selectedCategory = "All";

  final TextEditingController searchController =
  TextEditingController();

  List<Map<String, String>> packages = [

    {
      "name": "Premium Set",
      "description":
      "A premium set with a variety of main dishes, sides, and desserts.",
      "price": "RM 88.00",
      "category": "Popular",
      "image": "assets/images/premium_set.jpg",
    },

    {
      "name": "Family Feast",
      "description":
      "Perfect for family gatherings with a wide selection of dishes.",
      "price": "RM 128.00",
      "category": "Premium",
      "image": "assets/images/family_set.jpg",
    },

    {
      "name": "Deluxe Combo",
      "description":
      "A delightful combo of chef's special dishes.",
      "price": "RM 68.00",
      "category": "Vegetarian",
      "image": "assets/images/deluxe_combo.jpg",
    },

    {
      "name": "Mini Set",
      "description":
      "A simple and affordable package for smaller events.",
      "price": "RM 48.00",
      "category": "Popular",
      "image": "assets/images/mini_set.jpg",
    },
  ];

  List<Map<String, String>> filteredPackages = [];

  @override
  void initState() {
    super.initState();

    filteredPackages = packages;
  }

  void filterPackages() {

    setState(() {

      filteredPackages = packages.where((package) {

        final matchesSearch =
        package["name"]!
            .toLowerCase()
            .contains(
          searchController.text.toLowerCase(),
        );

        final matchesCategory =
        selectedCategory == "All"
            ? true
            : package["category"] ==
            selectedCategory;

        return matchesSearch &&
            matchesCategory;

      }).toList();

    });
  }

  void sortPackages(String sortType) {
    setState(() {

      switch (sortType) {

        case "Price Low to High":

          filteredPackages.sort((a, b) {

            double priceA = double.parse(
              a["price"]!.replaceAll("RM ", ""),
            );

            double priceB = double.parse(
              b["price"]!.replaceAll("RM ", ""),
            );

            return priceA.compareTo(priceB);
          });

          break;

        case "Price High to Low":

          filteredPackages.sort((a, b) {

            double priceA = double.parse(
              a["price"]!.replaceAll("RM ", ""),
            );

            double priceB = double.parse(
              b["price"]!.replaceAll("RM ", ""),
            );

            return priceB.compareTo(priceA);
          });

          break;

        case "Name A-Z":

          filteredPackages.sort(
                (a, b) =>
                a["name"]!.compareTo(
                  b["name"]!,
                ),
          );

          break;

        case "Name Z-A":

          filteredPackages.sort(
                (a, b) =>
                b["name"]!.compareTo(
                  a["name"]!,
                ),
          );

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,


        centerTitle: true,

        title: const Text(
          "Browse Packages",

          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 16),

            child: GestureDetector(

              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CartPage(),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },

              child: Stack(
                children: [

                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                    size: 28,
                  ),

                  if(cartItems.isNotEmpty)

                    Positioned(
                      right: 0,

                      child: Container(
                        padding: const EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),

                        child: Text(
                          cartItems.length.toString(),

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ),

        ],
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              // SEARCH

              Row(
                children: [

                  Expanded(
                    child: TextField(

                      controller:
                      searchController,

                      onChanged: (value) {
                        filterPackages();
                      },

                      decoration: InputDecoration(
                        hintText:
                        "Start your search",

                        prefixIcon:
                        const Icon(Icons.search),

                        filled: true,
                        fillColor: Colors.white,

                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30),

                          borderSide:
                          BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,

                        builder: (context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: [

                                const Padding(
                                  padding: EdgeInsets.all(16),

                                  child: Text(
                                    "Sort Packages",

                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                ListTile(
                                  leading: const Icon(Icons.arrow_upward),
                                  title: const Text(
                                    "Price Low to High",
                                  ),

                                  onTap: () {
                                    sortPackages(
                                      "Price Low to High",
                                    );

                                    Navigator.pop(context);
                                  },
                                ),

                                ListTile(
                                  leading: const Icon(Icons.arrow_downward),
                                  title: const Text(
                                    "Price High to Low",
                                  ),

                                  onTap: () {
                                    sortPackages(
                                      "Price High to Low",
                                    );

                                    Navigator.pop(context);
                                  },
                                ),

                                ListTile(
                                  leading: const Icon(Icons.sort_by_alpha),
                                  title: const Text(
                                    "Name A-Z",
                                  ),

                                  onTap: () {
                                    sortPackages("Name A-Z");

                                    Navigator.pop(context);
                                  },
                                ),

                                ListTile(
                                  leading: const Icon(Icons.sort),
                                  title: const Text(
                                    "Name Z-A",
                                  ),

                                  onTap: () {
                                    sortPackages("Name Z-A");

                                    Navigator.pop(context);
                                  },
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                        },
                      );
                    },

                    child: Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(14),
                      ),

                      child: const Icon(Icons.tune),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 20),

              // CATEGORY FILTERS

              SingleChildScrollView(
                scrollDirection:
                Axis.horizontal,

                child: Row(
                  children: [

                    categoryChip("All"),

                    categoryChip("Popular"),

                    categoryChip("Premium"),

                    categoryChip("Vegetarian"),

                  ],
                ),
              ),

              const SizedBox(height: 25),

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

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PackageDetailsPage(
                                package: package,
                              ),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },

                    child: Container(
                      margin:
                      const EdgeInsets.only(
                        bottom: 16,
                      ),

                      padding:
                      const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                          22,
                        ),
                      ),

                      child: Row(
                        children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),

                            child: Image.asset(
                              package["image"]!,
                              width: 95,
                              height: 95,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [

                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),

                                  decoration:
                                  BoxDecoration(
                                    color:
                                    Colors.grey
                                        .shade300,

                                    borderRadius:
                                    BorderRadius.circular(
                                      20,
                                    ),
                                  ),

                                  child: Text(
                                    package[
                                    "category"]!,
                                  ),
                                ),

                                const SizedBox(
                                  height: 6,
                                ),

                                Text(
                                  package["name"]!,

                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,

                                    fontSize: 18,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                Text(
                                  package[
                                  "description"]!,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  "From ${package["price"]!}",

                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),

                              ],
                            ),
                          ),

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

            ],
          ),
        ),
      ),
    );
  }

  Widget categoryChip(String title) {

    final isSelected =
        selectedCategory == title;

    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
      ),

      child: GestureDetector(

        onTap: () {

          selectedCategory = title;

          filterPackages();
        },

        child: Container(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),

          decoration: BoxDecoration(
            color: isSelected
                ? Colors.grey.shade700
                : Colors.grey.shade300,

            borderRadius:
            BorderRadius.circular(20),
          ),

          child: Text(
            title,

            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors.black,

              fontWeight:
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}