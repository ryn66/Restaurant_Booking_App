import 'package:flutter/material.dart';
import 'guest_page.dart';
import 'app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                const Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 120,
                ),

                const SizedBox(height: 30),

                const Text(
                  "Restaurant Hall Booking",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight:
                    FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Book Your Perfect Dining Experience",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 60),

                SizedBox(
                  width: 220,
                  height: 55,

                  child: ElevatedButton(

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.white,

                      foregroundColor:
                      AppColors.primary,

                      elevation: 5,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),

                    onPressed: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                          const GuestPage(),
                        ),
                      );
                    },

                    child: const Text(
                      "Get Started",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}