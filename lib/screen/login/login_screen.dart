import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: const Center(
                    child: Text(
                      'GTR',
                      style: TextStyle(
                        fontSize: 60,
                      ),
                    ),
                  ),
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login ke akun Anda',
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Login')),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Atau login dengan',
                ),
                SizedBox(
                  height: 50,
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icon/onboarding/google.png',
                            height: 25,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'Sign In with Google',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('Belum punya akun?'),
                Text('Register disini'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
