import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/data_repository.dart';
import 'package:url_launcher/url_launcher.dart'; // package for phone and email
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart'; // package for saving data

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // controllers get text from text fields
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  // encrypted shared preferences object for saving data
  EncryptedSharedPreferences encryptedData = EncryptedSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // top bar of page
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // welcome text at top like requirement says
            Text(
              'Welcome Back ${DataRepository.loginName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // textField for first name - input box
            TextField(
              controller: _firstNameController, // connects controller to get text
              onChanged: (value) {
                // saves first name when user types
                _saveData();
              },
              decoration: InputDecoration(
                hintText: "First Name", // placeholder text inside box
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // makes round corners
                ),
              ),
            ),

            SizedBox(height: 16), // makes space between text fields

            // textField for last name - another input box
            TextField(
              controller: _lastNameController, // connects controller to get text
              onChanged: (value) {
                // saves last name when user types
                _saveData();
              },
              decoration: InputDecoration(
                hintText: "Last Name", // placeholder text inside box
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // makes round corners
                ),
              ),
            ),

            SizedBox(height: 16), // makes space between text fields

            // row has phone number field with call and sms buttons
            Row(
              children: [
                Flexible( // makes text field take most of space
                  child: TextField(
                    controller: _phoneController, // gets phone number text
                    onChanged: (value) {
                      // saves phone number when user types
                      _saveData();
                    },
                    decoration: InputDecoration(
                      hintText: "Phone Number", // placeholder text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // round corners
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // small space between field and buttons

                // button calls phone number
                ElevatedButton(
                  onPressed: () async {
                    // uses doctor's method with canLaunch and .then
                    // canLaunch checks if device can make phone calls
                    canLaunch("tel:${_phoneController.text}").then(
                            (itCan) {
                          if(itCan) {
                            // launch opens phone app to call number
                            launch("tel:${_phoneController.text}");
                          } else {
                            // show AlertDialog if device cannot make calls
                            _showNotSupportedDialog("Phone calls are not supported on device");
                          }
                        }
                    );
                  },
                  child: const Icon(Icons.phone), // phone icon on button
                ),

                const SizedBox(width: 4), // small space between buttons

                // button sends sms to phone number
                ElevatedButton(
                  onPressed: () async {
                    // canLaunch checks if device can send sms
                    canLaunch("sms:${_phoneController.text}").then(
                            (itCan) {
                          if(itCan) {
                            // launch opens sms app
                            launch("sms:${_phoneController.text}");
                          } else {
                            // show AlertDialog if device cannot send sms
                            _showNotSupportedDialog("SMS is not supported on device");
                          }
                        }
                    );
                  },
                  child: const Icon(Icons.sms), // sms icon on button
                ),
              ],
            ),

            const SizedBox(height: 16), // space between sections

            // row has email field with send email button
            Row(
              children: [
                Flexible( // makes text field take most of space
                  child: TextField(
                    controller: _emailController, // gets email text
                    onChanged: (value) {
                      // saves email when user types
                      _saveData();
                    },
                    decoration: InputDecoration(
                      hintText: "Email address", // placeholder text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // round corners
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // space between field and button

                // button opens email app to send email
                ElevatedButton(
                  onPressed: () async {
                    // canLaunch checks if device can send emails
                    canLaunch("mailto:${_emailController.text}").then(
                            (itCan) {
                          if(itCan) {
                            // launch opens email app
                            launch("mailto:${_emailController.text}");
                          } else {
                            // show AlertDialog if device cannot send emails
                            _showNotSupportedDialog("Email is not supported on device");
                          }
                        }
                    );
                  },
                  child: const Icon(Icons.mail), // email icon on button
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // loads saved data when page starts
    _loadData();
  }

  // function saves all data to encrypted shared preferences
  void _saveData() async {
    await encryptedData.setString('firstName', _firstNameController.text);
    await encryptedData.setString('lastName', _lastNameController.text);
    await encryptedData.setString('phoneNumber', _phoneController.text);
    await encryptedData.setString('email', _emailController.text);
  }

  // function loads saved data from encrypted shared preferences
  void _loadData() async {
    // get saved data or use empty string if nothing saved
    String firstName = await encryptedData.getString('firstName') ?? '';
    String lastName = await encryptedData.getString('lastName') ?? '';
    String phoneNumber = await encryptedData.getString('phoneNumber') ?? '';
    String email = await encryptedData.getString('email') ?? '';

    // put saved data into text fields
    setState(() {
      _firstNameController.text = firstName;
      _lastNameController.text = lastName;
      _phoneController.text = phoneNumber;
      _emailController.text = email;
    });
  }

  // function shows AlertDialog when URL is not supported
  void _showNotSupportedDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not Supported'), // title of dialog
          content: Text(message), // message to show
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
              },
              child: Text('OK'), // button text
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // cleans up controllers when page closes to save memory
    _phoneController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}