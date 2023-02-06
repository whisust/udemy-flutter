import 'package:flutter/material.dart';

import 'dart:math';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1])),
      ),
      SingleChildScrollView(
          child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding:
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 94),
                          transform: Matrix4.rotationZ(-8.0 * pi / 180)
                            ..translate(-10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepOrange.shade900,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 8,
                                    color: Colors.black26,
                                    offset: Offset(0, 2))
                              ]),
                          child: Text('MyShop',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .buttonTheme
                                      .colorScheme
                                      ?.inversePrimary,
                                  fontSize: 50,
                                  fontFamily: 'Anton',
                                  fontWeight: FontWeight.normal)))),
                  Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1, child: const AuthCard())
                ],
              )))
    ]));
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_authMode == AuthMode.Login) {
      // login
    } else {
      // register
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 8,
        child: Container(
            height: _authMode == AuthMode.Signup ? 320 : 260,
            constraints: BoxConstraints(
                minHeight: _authMode == AuthMode.Signup ? 320 : 260),
            width: deviceSize.width * .75,
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Invalid email';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _authData['email'] = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 5) {
                          return 'Password is too short';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value!;
                      },
                    ),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            const InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                } else {
                                  return null;
                                }
                              }
                            : null,
                      ),
                    const SizedBox(height: 20),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              backgroundColor: Theme.of(context).primaryColor,
                              textStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .color)),
                          child: Text(_authMode == AuthMode.Login
                              ? 'LOGIN'
                              : 'SIGN UP')),
                    TextButton(
                      onPressed: _switchAuthMode,
                      style: FilledButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'SIGN UP' : 'LOGIN'} instead'),
                    )
                  ],
                )))));
  }
}
