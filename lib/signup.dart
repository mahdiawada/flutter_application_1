import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  Future<void> signUp() async {
    const String apiUrl = 'http://localhost/flutter_app/signup.php'; 
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text
        }),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (responseData['status'] == 'success') {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        throw Exception('Failed to sign up');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Something went wrong, please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0.0,
        title: const Text('Sign Up',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: ListView(children: [
          const SizedBox(height: 20),
          const Text(
            "Welcome To our Shop",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: const Text(
              "Sign Up With Your Email, Username, And Password OR Continue With Social Media",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 25),
          CustomTextField(controller: _usernameController,hintText: "Enter your Username",labelText: "Username",suffixIcon: Icons.account_circle,),
          const SizedBox(height: 25),
          CustomTextField(controller: _emailController,hintText: "Enter your Email",labelText: "Email",suffixIcon: Icons.email_outlined,),
          const SizedBox(height: 25),
          CustomTextField(controller: _passwordController,hintText: "Enter your Password",labelText: "Password",suffixIcon: Icons.lock,obscureText: true,),
          const SizedBox(height: 25),
          MaterialButton(
            onPressed: signUp,
            color: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 15),
          
        ]),
      ),
    );
  }
}




class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData suffixIcon;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        label: Text(labelText),
        suffixIcon: Icon(suffixIcon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      obscureText: obscureText,
    );
  }
}