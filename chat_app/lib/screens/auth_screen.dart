import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _submitAuthForm(String email, String password, String? username, bool isLogin, BuildContext ctx) async {
    UserCredential? authResult;
    setState(() {
      _isLoading = true;
    });
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({'username': username!, 'email': email});
      }
    } on FirebaseAuthException catch (e) {
      var message = 'An error occured';
      if (e.message != null) {
        message = e.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).colorScheme.error,
      ));
    } catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(err.toString()),
        backgroundColor: Theme.of(ctx).colorScheme.error,
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(onSubmit: _submitAuthForm, isLoading: _isLoading));
  }
}
