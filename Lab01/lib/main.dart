import 'package:flutter/material.dart'; // import the main app
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart'; // import the package of the encrypted data
import 'package:my_cst2335_labs/ProfilePage.dart'; // import the second page
import 'package:my_cst2335_labs/data_repository.dart'; //import the data repository

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  /// the MaterialApp widget, to make the root to the next page(s)
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Home Page'),
        '/second': (context) => const ProfilePage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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

/// adding the photos unde login code.

  var _oimage = "images/question-mark.png";
  var _limage = "images/idea.png";
  var _simage = "images/stop.png";
  var _showPass = true;

  ///insantiate a new variables to hold the fields of the entry of the user.

  late TextEditingController _logincontroller;
  late TextEditingController _passcontroller;


  @override
  void initState() {
    super.initState();
    _logincontroller = TextEditingController();
    _passcontroller  = TextEditingController();

// calling the saved used username and password used future.delayed to call after the page completly uploaded
    Future.delayed(Duration.zero, () async {
      final encryptedPrefs = EncryptedSharedPreferences(); // creating object from the API encryptedSHaredPreference
      String? savedUser = await encryptedPrefs.getString('username'); // calling the variable from the object and await till the calling end
      String? savedPass = await encryptedPrefs.getString('password');

// if statment to get the entry and the function to what we will do after the calling
      if (savedUser != null && savedPass != null &&
          savedUser.isNotEmpty && savedPass.isNotEmpty)
        {

          /// snackBar under the screen to alert the user
        const snackBar = SnackBar( content: Text('your password and useername saved') );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        /// receving the entry and save it
        _logincontroller.text = savedUser;
        _passcontroller.text = savedPass;
      }

    });
  }

  @override
  ///dispose the memory before closing the page, to avoid memorey leak
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

            /// textField to the login

            TextField(controller: _logincontroller ,
              decoration: InputDecoration(
                  hintText: "  login")
              , ),
/// text field to the password
            TextField(
              controller: _passcontroller,
              obscureText: _showPass,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "  password",
                border: OutlineInputBorder(),
              ),
            ),

            /// the button of login
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                String _password = _passcontroller.text;
                /// method to rebuild ( restate ) the page after pressing
                setState(() {
                  if ( _password == "QWERTY123" ){
                    _oimage = _limage;
                    DataRepository.loginName = _logincontroller.text;
                    Navigator.pushNamed(context, '/second');

                  } else {
                    _oimage = _simage;
                  }
                });

                /// alert message
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
