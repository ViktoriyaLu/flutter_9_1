import 'package:flutter/material.dart';
import 'package:fitst_app/credentials_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _login = '';
  final CredentialsStore _credentialsStore = CredentialsStore();

  @override
  void initState() {
    super.initState();
    _getLogin();
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
        actions: [
          TextButton(
            onPressed: () {
              _credentialsStore.forgetRemembered();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 120, 222, 240),
            Color.fromARGB(255, 231, 106, 231),
          ],
        )),
        child: Column(
          children: [
            Image.asset('assets/images/Blonde.png'),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                'Hello, $_login!',
                style: const TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 62, 5, 234),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _getLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _login = _credentialsStore.getCurrentLogin();
    });
  }
}
