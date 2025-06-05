import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

// adding the photos unde login code.
  var _oimage = "images/question-mark.png";
  var _limage = "images/idea.png";
  var _simage = "images/stop.png";
  var _showPass = true;
  late TextEditingController _logincontroller;
  late TextEditingController _passcontroller;

  @override
  void initState() {
    super.initState();
    _logincontroller = TextEditingController();
    _passcontroller  = TextEditingController();

// calling the saved used username and password
    Future.delayed(Duration.zero, () async {
      final encryptedPrefs = EncryptedSharedPreferences();
      String? savedUser = await encryptedPrefs.getString('username');
      String? savedPass = await encryptedPrefs.getString('password');


      if (savedUser != null && savedPass != null &&
          savedUser.isNotEmpty && savedPass.isNotEmpty)
        {
        const snackBar = SnackBar( content: Text('your password and useername saved') );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _logincontroller.text = savedUser;
        _passcontroller.text = savedPass;
      }

    });
  }

  @override
  void dispose() {
    _logincontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextField(controller: _logincontroller ,
              decoration: InputDecoration(
                  hintText: "  login")
              , ),

            TextField(
              controller: _passcontroller,
              obscureText: _showPass,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "  password",
                border: OutlineInputBorder(),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),

              ),
              onPressed: () {
                String _password = _passcontroller.text;
                setState(() {
                  if ( _password == "QWERTY123" ){
                    _oimage = _limage;
                  } else {
                    _oimage = _simage;
                  }
                });
                  showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Save Password'),
                    content: const Text('Do you want to Save Your UserName And Password?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          final encryptedPrefs = EncryptedSharedPreferences(); // new object to encruptyd the password
                          await encryptedPrefs.setString('username', _logincontroller.text); // wait until the user enter user name and password
                          await encryptedPrefs.setString('password', _passcontroller.text);

                          Navigator.pop(context); // after that the message will disappear
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final encryptedPrefs = EncryptedSharedPreferences();
                          await encryptedPrefs.clear();
                          _logincontroller.clear();
                          _passcontroller.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
              },
              child:  Text("Login" , style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
              ), ) ,
            ),

            Image.asset(_oimage , width: 300, height: 300,),

          ],
        ),
      ),
    );
  }
}
