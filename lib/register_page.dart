import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_navigation_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> registerUser() async {

    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill in all fields",
          ),
        ),
      );

      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Passwords do not match",
          ),
        ),
      );

      return;
    }

    try {
setState(() {
  isLoading = true;
});

UserCredential userCredential =
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
  email: emailController.text.trim(),
  password: passwordController.text.trim(),
);

await FirebaseFirestore.instance
    .collection("users")
    .doc(userCredential.user!.uid)
    .set({

  "uid":
      userCredential.user!.uid,

  "name":
      nameController.text.trim(),

  "email":
      emailController.text.trim(),

  "status":
      "Active",

  "createdAt":
      Timestamp.now(),
});

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text(
      "Account Created Successfully",
    ),
  ),
);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const MainNavigationPage(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String errorMessage =
          "Registration Failed";

      if (e.code ==
          'email-already-in-use') {

        errorMessage =
        "Email already registered";
      }

      else if (e.code ==
          'invalid-email') {

        errorMessage =
        "Invalid email format";
      }

      else if (e.code ==
          'weak-password') {

        errorMessage =
        "Password must be at least 6 characters";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(errorMessage),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        title: const Text(
          "Restaurant - REGISTER",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              const SizedBox(height: 10),

              const Text(
                "Create Account",

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Register to continue.",

                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,

                padding:
                const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius:
                  BorderRadius.circular(25),
                ),

                child: Column(
                  children: [

                    TextField(
                      controller:
                      nameController,

                      decoration:
                      InputDecoration(

                        hintText:
                        "Full Name",

                        prefixIcon:
                        const Icon(
                          Icons.person,
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

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                      emailController,

                      decoration:
                      InputDecoration(

                        hintText:
                        "Email Address",

                        prefixIcon:
                        const Icon(
                          Icons.email,
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

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                      passwordController,

                      obscureText: true,

                      decoration:
                      InputDecoration(

                        hintText:
                        "Password",

                        prefixIcon:
                        const Icon(
                          Icons.lock,
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

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                      confirmPasswordController,

                      obscureText: true,

                      decoration:
                      InputDecoration(

                        hintText:
                        "Confirm Password",

                        prefixIcon:
                        const Icon(
                          Icons.lock_outline,
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

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.black87,

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),

                        onPressed:
                        isLoading
                            ? null
                            : registerUser,

                        child:
                        isLoading

                            ? const CircularProgressIndicator(
                          color:
                          Colors.white,
                        )

                            : const Text(
                          "Register",

                          style:
                          TextStyle(
                            color:
                            Colors.white,

                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {

                        Navigator.pushReplacement(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                            const LoginPage(),
                          ),
                        );
                      },

                      child: const Text.rich(
                        TextSpan(
                          text:
                          "Already have an account? ",

                          children: [

                            TextSpan(
                              text: "Login",

                              style: TextStyle(
                                color:
                                Colors.red,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}