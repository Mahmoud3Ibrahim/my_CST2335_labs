import 'package:flutter/material.dart';

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
  }



  @override
  void dispose() {
    _logincontroller.dispose();
    _passcontroller.dispose();
    super.dispose();
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                    _showPass = false;
                  } else {
                    _oimage = _simage;
                    _showPass = false;
                  }
                }
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
