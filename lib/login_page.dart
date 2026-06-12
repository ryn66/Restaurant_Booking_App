import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_navigation_page.dart';
import 'guest_page.dart';
import 'register_page.dart';
import 'admin_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {

    if(emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Please enter email and password",
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
        .signInWithEmailAndPassword(

  email:
      emailController.text.trim(),

  password:
      passwordController.text.trim(),
);

DocumentSnapshot userDoc =
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user!.uid)
        .get();

if (!userDoc.exists) {

  await FirebaseAuth.instance.signOut();

  if (!mounted) return;

  ScaffoldMessenger.of(context)
      .showSnackBar(

    const SnackBar(
      content: Text(
        "User not registered in system",
      ),
    ),
  );

  return;
}

Map<String, dynamic> userData =
    userDoc.data()
        as Map<String, dynamic>;

if (userData["status"] != "Active") {

  await FirebaseAuth.instance.signOut();

  if (!mounted) return;

  ScaffoldMessenger.of(context)
      .showSnackBar(

    const SnackBar(
      content: Text(
        "Your account has been blocked",
      ),
    ),
  );

  return;
}

      if(!mounted) return;

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (_) =>
          const MainNavigationPage(),
        ),
      );

    } on FirebaseAuthException catch(e) {

      String message =
          "Login Failed";

      if(e.code == "invalid-credential") {

        message =
        "Incorrect email or password";
      }

      if(e.code == "user-not-found") {

        message =
        "User not found";
      }

      if(e.code == "wrong-password") {

        message =
        "Incorrect password";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(message),
        ),
      );

    } finally {

      if(mounted) {

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();

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
          "Restaurant - LOGIN",

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

              const SizedBox(height: 30),

              const Text(
                "Welcome Back!",

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Please login to continue.",

                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius:
                  BorderRadius.circular(25),
                ),

                child: Column(
                  children: [

                    const Text(
                      "Login",

                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        const Text(
                          "Don't have an Account? ",
                        ),

                        GestureDetector(
                          onTap: () {

                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                const RegisterPage(),
                              ),
                            );
                          },

                          child: const Text(
                            "Sign Up",

                            style: TextStyle(
                              color: Colors.red,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 25),

                    TextField(
                      controller:
                      emailController,

                      decoration: InputDecoration(
                        hintText:
                        "Enter your Email Address",

                        prefixIcon:
                        const Icon(
                          Icons.email_outlined,
                        ),

                        filled: true,
                        fillColor: Colors.white,

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

                      decoration: InputDecoration(
                        hintText:
                        "Enter Password",

                        prefixIcon:
                        const Icon(
                          Icons.lock_outline,
                        ),

                        filled: true,
                        fillColor: Colors.white,

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

                    const SizedBox(height: 20),

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
                            : loginUser,

                        child:
                        isLoading

                            ? const CircularProgressIndicator(
                          color:
                          Colors.white,
                        )

                            : const Text(
                          "Login",

                          style: TextStyle(
                            color:
                            Colors.white,

                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

const SizedBox(height: 15),

SizedBox(
  width: double.infinity,
  height: 55,

  child: OutlinedButton.icon(

    icon: const Icon(
      Icons.admin_panel_settings,
      color: Colors.black,
    ),

    label: const Text(
      "Admin Login",
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(30),
      ),
    ),

    onPressed: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder: (_) =>
              const AdminLoginPage(),
        ),
      );
    },
  ),
),

const SizedBox(height: 20),

GestureDetector(
  onTap: () {

    Navigator.pushReplacement(
      context,

      MaterialPageRoute(
        builder: (_) =>
            const GuestPage(),
      ),
    );
  },

  child: const Text(
    "Or Continue as Guest",

    style: TextStyle(
      fontSize: 16,
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