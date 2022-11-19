import 'package:flutter/material.dart';
import 'package:fitst_app/credentials_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final CredentialsStore _credentialsStore = CredentialsStore();
  var remember = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 5, 202, 237),
            Color.fromARGB(255, 240, 52, 237),
          ],
        )),
        // Column(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'HELLO!!!',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Sign in to your account',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
              child: TextFormField(
                controller: loginController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person), hintText: 'Login*'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.key), hintText: 'Password*'),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              value: remember,
              onChanged: (b) {
                setState(() {
                  remember = b ?? false;
                });
              },
              title: const Text('Remember me'),
            ),
            ElevatedButton(
              onPressed: () {
                final login = loginController.text;
                final password = passwordController.text;

                if (login.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Заполните все поля!',
                      ),
                    ),
                  );

                  return;
                }

                final result = _credentialsStore.login(login, password);

                switch (result) {
                  case LoginResult.wrongLogin:
                  case LoginResult.wrongPassword:
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          result.message,
                        ),
                      ),
                    );
                    return;
                  case LoginResult.success:
                    if (remember) {
                      _credentialsStore.rememberMe();
                    }
                    Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 2));
    final remember = _credentialsStore.wasRemembered();
    if (remember) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
