import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'guest_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user =
        FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              CircleAvatar(
                radius: 70,
                backgroundColor:
                Colors.grey.shade300,

                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                user?.email
                    ?.split("@")
                    .first ??
                    "Restaurant User",

                style: const TextStyle(
                  fontSize: 30,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                user?.email ??
                    "No Email",

                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 60),

              SizedBox(
                width: double.infinity,
                height: 60,

                child: ElevatedButton.icon(

                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    Colors.red,

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          18),
                    ),
                  ),

                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),

                  label: const Text(
                    "Logout",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  onPressed: () async {

                    bool? confirm =
                    await showDialog<bool>(

                      context: context,

                      builder: (_) =>
                          AlertDialog(

                            title:
                            const Text(
                              "Logout",
                            ),

                            content:
                            const Text(
                              "Are you sure you want to logout?",
                            ),

                            actions: [

                              TextButton(
                                onPressed: () {

                                  Navigator.pop(
                                    context,
                                    false,
                                  );
                                },

                                child:
                                const Text(
                                  "Cancel",
                                ),
                              ),

                              TextButton(
                                onPressed: () {

                                  Navigator.pop(
                                    context,
                                    true,
                                  );
                                },

                                child:
                                const Text(
                                  "Logout",
                                ),
                              ),
                            ],
                          ),
                    );

                    if (confirm != true) {
                      return;
                    }

                    await FirebaseAuth
                        .instance
                        .signOut();

                    if (!context.mounted) {
                      return;
                    }

                    Navigator
                        .pushAndRemoveUntil(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                        const GuestPage(),
                      ),

                          (route) => false,
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}