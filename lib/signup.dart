import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String successMessage = '';

  void login(String email, String password) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        setState(() {
          successMessage = "Account created successfully: $data";
        });
      } else {
        setState(() {
          successMessage = "Failed to register";
        });
      }
    } on Exception catch (e) {
      setState(() {
        successMessage = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up Page",
        ),
        backgroundColor: Colors.blue[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                controller: emailcontroller,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                controller: passwordcontroller,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  login(emailcontroller.text.toString(),
                      passwordcontroller.text.toString());
                },
                child: Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("Sign Up"),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                successMessage,
                style: TextStyle(
                  color: successMessage.startsWith('Failed') ||
                          successMessage.startsWith('Error')
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ]),
      ),
    );
  }
}