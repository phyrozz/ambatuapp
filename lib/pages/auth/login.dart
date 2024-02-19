import 'package:ambatuapp/pages/auth/signup.dart';
import 'package:ambatuapp/supabase.dart';
import 'package:ambatuapp/widgets/loading.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoadingPage(),
        ),
      );
      await SupabaseAuth().signIn(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      showLoginDialog("Error", "Unable to log in. Please try again.");
    }
  }

  Future<void> showLoginDialog(String title, String message) async {
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
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const FadeInImage(
                    image: AssetImage(
                      "assets/home_header.jpg",
                    ),
                    width: double.infinity,
                    height: 250.0,
                    fit: BoxFit.fitWidth,
                    placeholder: AssetImage('assets/loading.gif'),
                    placeholderFit: BoxFit.none,
                  ),
                  Container(
                    height: 250.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                          Colors.transparent,
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                            stops: const [
                          0.1,
                          1.0
                        ])),
                  ),
                ],
              ),
              Text("Let's get bussin'!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium),
              Text(
                "Log in to get started",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person_rounded), labelText: "Email"),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.password_rounded),
                          labelText: "Password"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(onPressed: signIn, child: const Text("Log in")),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SignUpPage(),
                    ),
                  );
                },
                child: const Text("Create an Account")),
          ),
        ],
      ),
    );
  }
}
