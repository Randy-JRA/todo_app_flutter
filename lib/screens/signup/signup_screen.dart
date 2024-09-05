import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  Future<void> signup() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    //GET The api request for the signup
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
    //show success massage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('SignUp Successful')),
    );

    //navigate to the lgoin
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            SizedBox(
              height: 20,
            ),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: signup,
                    child: Text('Sign Up'),
                  ),
          ],
        ),
      ),
    );
  }
}
