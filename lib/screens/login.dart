import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manager_app/services/database_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _type =
        ModalRoute.of(context).settings.arguments; // recovery user type.
    _emailController.text = 'ste@gmail.com';
    _passWController.text = '123456';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Container(width: 20),
            Text('Login'),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        children: [
          if (Theme.of(context).brightness == Brightness.light) ...[
            ConstantesImages.sizedLogo(ConstantesImages.logo1)
          ] else
            ConstantesImages.sizedLogo(ConstantesImages.logo4),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: MediaQuery.of(context).size.height / 1.828,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.teal,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _emailController,
                          validator: (String value) {
                            return value.isEmpty ? 'Required field.' : null;
                          },
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            labelText: 'Login:',
                            focusColor: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
                        child: TextFormField(
                          controller: _passWController,
                          validator: (String value) {
                            return value.isEmpty ? 'Required field.' : null;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Password:',
                              suffixIcon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              'Forgot password.',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('forgotPassword');
                            },
                          ),
                        ],
                      ),
                      Align(
                        child: Container(
                            width: 150,
                            child: ElevatedButton(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.teal),
                              ),
                              onPressed: () {
                                if (!_validate()) return;

                                DatabaseServiceAuth.login(_emailController.text,
                                    _passWController.text);
                                Navigator.of(context).pushReplacementNamed(
                                    'home',
                                    arguments: _type);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            )),
                      ),
                      if (_type == 'ceo') ...[
                        TextButton(
                          child: Text('Register.',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('register', arguments: _type);
                          },
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  _validate() {
    if (_formkey.currentState.validate()) {
      return true;
    }
    return false;
  }
}
