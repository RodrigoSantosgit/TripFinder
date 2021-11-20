import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:tripfinder/user.dart';
import 'authentication_service.dart';
import 'boxes.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageURLController = TextEditingController();

  final ButtonStyle buttonStyle =
  ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textStyle: const TextStyle(fontSize: 15), minimumSize: const Size(150, 25),
      primary: Colors.blue, onPrimary: Colors.white);

  addUser(String email, String name, String image) {
    var box = Boxes.getUsers();
    Users tmp = Users(name, email, image, []);
    box.add(tmp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TripFinder'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(40.0,0.0,40.0,28.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                  TextField(
                    controller: imageURLController,
                    decoration: const InputDecoration(
                      labelText: "Image URL",
                    ),
                  ),
                ],
              )

          ),
          TextButton(
            style: buttonStyle,
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
              addUser(emailController.text.trim(), nameController.text.trim(), imageURLController.text.trim());
              Navigator.pop(context);
            },
            child: const Text("Sign in"),
          ),
        ],
      ),
    );
  }
}