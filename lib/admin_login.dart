import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'admin_page.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() =>
      _AdminLoginPageState();
}

class _AdminLoginPageState
    extends State<AdminLoginPage> {

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> adminLogin() async {

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
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

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password:
            passwordController.text.trim(),
      );

      if (!mounted) return;

      if (emailController.text.trim() !=
          "admin@gmail.com") {

        await FirebaseAuth.instance.signOut();

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "You are not authorized as Admin",
            ),
          ),
        );

        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const AdminPage(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String message =
          "Admin Login Failed";

      if (e.code ==
              "invalid-credential" ||
          e.code == "wrong-password") {

        message =
            "Invalid email or password";
      }

      if (e.code ==
          "user-not-found") {

        message =
            "Admin account not found";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(message),
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

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.black,

        title: const Text(
          "Admin Login",

          style: TextStyle(
            color: Colors.white,
          ),
        ),

        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: Center(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child: Container(

            padding:
                const EdgeInsets.all(25),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                25,
              ),
            ),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                const Icon(
                  Icons
                      .admin_panel_settings,
                  size: 90,
                  color: Colors.black,
                ),

                const SizedBox(
                    height: 20),

                const Text(
                  "Administrator Login",

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 30),

                TextField(
                  controller:
                      emailController,

                  decoration:
                      InputDecoration(
                    hintText:
                        "Admin Email",

                    prefixIcon:
                        const Icon(
                      Icons.email,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

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

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child:
                      ElevatedButton(

                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          Colors.black,
                    ),

                    onPressed:
                        isLoading
                            ? null
                            : adminLogin,

                    child:
                        isLoading

                            ? const CircularProgressIndicator(
                                color: Colors
                                    .white,
                              )

                            : const Text(
                                "Login as Admin",

                                style:
                                    TextStyle(
                                  color: Colors
                                      .white,
                                  fontSize:
                                      18,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                  ),
                ),

                const SizedBox(
                    height: 15),

                const Text(
                  "Login using Firebase Authentication",

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
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

