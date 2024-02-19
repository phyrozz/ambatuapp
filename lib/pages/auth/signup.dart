import 'package:ambatuapp/supabase.dart';
import 'package:ambatuapp/widgets/loading.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoadingPage(),
        ),
      );
      if (passwordController.text == confirmPasswordController.text) {
        await SupabaseAuth().signUp(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
      } else {
        showSignUpDialog(
            "Invalid Password", "Passwords do not match. Please try again.");
      }
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      showSignUpDialog(
          "Error", "Unable to create an account. Please try again.");
    }
  }

  Future<void> showSignUpDialog(String title, String message) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 10),
                child: TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text("Back"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create an Account",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person_rounded), labelText: "Email"),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.password_rounded),
                        labelText: "Password"),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.password_rounded),
                        labelText: "Confirm password"),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                          onPressed: signUp,
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text("Sign up")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
