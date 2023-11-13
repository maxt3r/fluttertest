import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'webview.dart';

class LoginScreen extends StatefulWidget {
  final AuthManager authManager;

  const LoginScreen({required this.authManager});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                    labelText: 'Jitbit URL', border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                var token = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewContainer(
                            '${_urlController.text}/user/login?needAuthToken=true')));
                // Save the auth token and navigate to the main screen
                if (token != null && token.isNotEmpty) {
                  await widget.authManager.saveAuth(token, _urlController.text);
                  // Navigator.of(context).pushReplacementNamed('/tickets');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
