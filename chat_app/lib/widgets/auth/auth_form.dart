import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String? username, bool isLogin, BuildContext ctx) onSubmit;
  bool isLoading;

  AuthForm({Key? key, required this.onSubmit, required this.isLoading}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String? _email;
  String? _username;
  String? _password;

  void _trySubmit() {
    final formState = _formKey.currentState;
    if (formState != null) {
      final isValid = formState.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        formState.save();
        widget.onSubmit(_email!.trim(), _password!, _username?.trim(), _isLogin, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      TextFormField(
                        key: const ValueKey('email'),
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Invalid email';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                        ),
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: const ValueKey('username'),
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 2) {
                              return 'Username must be at least 2 chars long';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _username = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Username',
                          ),
                        ),
                      TextFormField(
                        key: const ValueKey('password'),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 7) {
                            return 'Password too short (must be greater than 7)';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _password = value;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        ElevatedButton(onPressed: _trySubmit, child: Text(_isLogin ? 'Login' : 'Signup')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin ? 'Not registered? Create an account' : 'Have an account? Log in'))
                    ]),
                  )),
            )));
  }
}
