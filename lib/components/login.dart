// ignore_for_file: library_private_types_in_public_api, unnecessary_new, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/components/register.dart';

import '../authentication/authenticate.dart';
import '../home/MyHomePage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;
  final _formKey = GlobalKey<FormState>();
  late String str = 'abc';

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              controller: emailInputController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter correct email!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              style: const TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              controller: pwdInputController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter correct password!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.grey,
                                    backgroundColor: const Color(0xff4c505b),
                                  ),
                                  icon: const FaIcon(FontAwesomeIcons.google),
                                  label: const Text('Log in with Google'),
                                  onPressed: () {},
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          str = await signin(
                                            emailInputController.text,
                                            pwdInputController.text,
                                          );
                                          if (str == '') {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              new MaterialPageRoute(
                                                builder: (context) =>
                                                    new MyHomePage(),
                                              ),
                                              (route) => false,
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  // Retrieve the text the that user has entered by using the
                                                  // TextEditingController.
                                                  content: Text(str.toString()),
                                                );
                                              },
                                            );
                                          }
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new MyRegister()),
                                      (route) => false,
                                    );
                                  },
                                  style: const ButtonStyle(),
                                  child: const Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showInfo() {
    print(emailInputController.text);
    print(pwdInputController.text);
  }
}
