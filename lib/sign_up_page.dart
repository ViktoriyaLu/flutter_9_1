import 'package:flutter/material.dart';
import 'package:fitst_app/credentials_store.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final loginController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordAgainController = TextEditingController();

  final CredentialsStore _credentialsStore = CredentialsStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Edit Profile')),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 240, 52, 237),
                  Color.fromARGB(255, 5, 202, 237),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person), labelText: 'Login*'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.key), labelText: 'Password*'),
            ),
            TextField(
              controller: passwordAgainController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.key), hintText: 'Password again*'),
            ),
            const TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.face), labelText: 'First name'),
            ),
            const TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.face), labelText: 'Last name'),
            ),
            const TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.phone), labelText: 'Phone number'),
            ),
            const TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.post_add), labelText: 'e-mail'),
            ),
            // TextFormField(validator: (value) {
            //   if (value!.isEmpty) return 'Пожалуйста введите свой E-mail';
            //   if (!value.contains('@') || !value.contains('.'))
            //     return 'Это не E-mail';
            // }),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                final login = loginController.text;
                final password = passwordController.text;
                final passwordAgain = passwordAgainController.text;

                if (password != passwordAgain) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Пароли не совпадают!',
                      ),
                    ),
                  );
                  return;
                }

                final success = await _credentialsStore.signUp(login, password);
                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Такой пользователь уже существует!',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Sign Up'),
            )
          ],
        ),
      ),
    );
  }
}
