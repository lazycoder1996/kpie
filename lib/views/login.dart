import 'package:flutter/material.dart';
import 'package:kpie/utils/config.dart';
import 'package:kpie/utils/constants.dart';
import 'package:kpie/utils/nav.dart';
import 'package:kpie/views/home.dart';
import 'package:kpie/widgets/button.dart';
import 'package:kpie/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool userError = false;
  bool passError = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'RAKTAPP',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          child: Text(
                            'Sign in to continue',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blueGrey[100],
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                            validator: (st) {
                              if (userError) {
                                return 'Username not found';
                              }
                              return null;
                            },
                            padding: padding,
                            controller: username,
                            labelText: 'Username or Email',
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color.fromARGB(213, 219, 156, 61),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                            validator: (st) {
                              if (passError) {
                                return 'Incorrect password';
                              }
                              return null;
                            },
                            padding: padding,
                            controller: password,
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(158, 101, 147, 187),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 80,
                            child: MyButton(
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                formKey.currentState!.reset();
                                setState(() {
                                  userError = false;
                                  passError = false;
                                });
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      );
                                    });
                                await ApiConfig.login(
                                  username.text.trim(),
                                  password.text.trim(),
                                ).then((value) {
                                  if (value['status']) {
                                    // move to next page
                                    Navigator.pop(context);
                                    toNextScreen(context, const HomePage());
                                  } else {
                                    Navigator.pop(context);
                                    // show error message
                                    var res = value['response'];
                                    if (res['error_text'] ==
                                        'Password is incorrect') {
                                      print('true');
                                      setState(() {
                                        passError = true;
                                        formKey.currentState!.validate();
                                      });
                                    } else if (res['error_text'] ==
                                        'Username not found') {
                                      setState(() {
                                        userError = true;
                                        formKey.currentState!.validate();
                                      });
                                    }
                                  }
                                });
                              },
                              borderColor: Colors.orange,
                              borderWidth: 2.5,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 20,
                                  ),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Text('OR'),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 15,
                                  ),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: SizedBox(
                              height: 50,
                              child: MyButton(
                                textStyle: loginStyle,
                                child: Row(
                                  children: [
                                    const Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: FlutterLogo(),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 4,
                                      child: Center(
                                        child: Text(
                                          'Login with Google',
                                          style: loginStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              height: 50,
                              child: MyButton(
                                textStyle: loginStyle,
                                child: Row(
                                  children: [
                                    const Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: FlutterLogo(),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      fit: FlexFit.tight,
                                      child: Center(
                                        child: Text(
                                          'Login with Facebook',
                                          style: loginStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Don\'t have an account?'),
                              SizedBox(
                                width: 3,
                              ),
                              InkWell(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
