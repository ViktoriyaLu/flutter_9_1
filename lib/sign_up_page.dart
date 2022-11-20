import 'package:flutter/material.dart';
import 'package:fitst_app/credentials_store.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
  final CredentialsStore _credentialsStore = CredentialsStore();
  bool _agreement = false;

  @override
  void dispose() {
    // !!! ubivaem controllers - chtob ne tratit pamyat
    loginController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    super.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 208, 229, 245),
              ),
              child: Column(
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
                        icon: Icon(Icons.face), labelText: 'Имя'),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.face), labelText: 'Фамилия'),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone), labelText: 'Номер телефона'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.post_add), labelText: 'e-mail*'),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),

            CheckboxListTile(
                value: _agreement,
                title: const Text(
                  'Я ознакомлен с документом "Согласие на обработку персональных данных" и даю согласие на обработку моих персональных данных в соответствии с требованиями "Федерального закона О персональных данных № 152-ФЗ".',
                ),
                onChanged: (bool? value) =>
                    setState(() => _agreement = value!)),

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

                if (login.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Login required !',
                      ),
                    ),
                  );
                  return;
                } else if (password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Password required!',
                      ),
                    ),
                  );
                  return;
                } else if (password != passwordAgain) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Пароли не совпадают!',
                      ),
                    ),
                  );
                  return;
                } else if (!emailController.text.contains('@') ||
                    !emailController.text.contains('.')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Пожалуйста введите корректный e-mail',
                      ),
                    ),
                  );
                  return;
                } else if (!_agreement) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        'Примите согласие!',
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
