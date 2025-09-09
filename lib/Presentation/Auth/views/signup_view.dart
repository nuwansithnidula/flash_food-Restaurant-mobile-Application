import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../Core/Routes/routes_name.dart';
import '../../../Core/Utils/utils.dart';
import '../../../Core/app_colors.dart';
import '../../../Core/response_conf.dart';
import '../../../Core/text_styles.dart';
import '../screens/default_button.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers for input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Create your new account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36),),
            Gap(40),
            Text(
              'Create an account to start looking for the \n food you like',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.orange),
            ),
            SizedBox(height: 30),

            // Email TextFormField
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),

            // First Name TextFormField
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),

            // Last Name TextFormField
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),

            // Address TextFormField
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),

            // Contact Number TextFormField
            TextFormField(
              controller: _contactNumberController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 30),

            // Password TextFormField
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 40),
            DefaultButton(
              btnContent: "Register",

              function: () {
                _validateAndRegister(context);
              }
            ),
            const Gap(24),
            Row(
              children: [
                const Expanded(child: Divider(color: Pallete.neutral60,height: 0.5,)),
                const Gap(16),
                Text("Or sign in with", style: TextStyles.bodyMediumMedium.copyWith(color: Pallete.neutral60, fontSize: getFontSize(14)),),
                const Gap(16),
                const Expanded(child: Divider(color: Pallete.neutral60,height: 0.5,)),
              ],
            ),
            const Gap(24),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: socialIcons.map((e) => Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                        Border.all(color: Pallete.neutral40, width: 1)),
                    child: SvgPicture.asset(
                        e
                    ),
                  ),
                )).toList()
            ),
            const Gap(32),
            Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account?",
                      style: TextStyles.bodyMediumMedium
                          .copyWith(color: Pallete.neutral100, fontSize: getFontSize(14)), ),
                    TextSpan(
                        text: ' ', style: TextStyles.bodyMediumSemiBold.copyWith(
                        fontSize: getFontSize(14)
                    )),
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap
                        =()=>Navigator.pushReplacementNamed(context, RoutesName.login),
                        text: 'Login',
                        style: TextStyles.bodyMediumSemiBold
                            .copyWith(color: Pallete.orangePrimary, fontSize: getFontSize(14))),
                  ],
                ),
              ),
            )

  ]
        ),
      ),
    );
  }

  void _validateAndRegister(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final address = _addressController.text.trim();
    final contactNumber = _contactNumberController.text.trim();

    // Perform validation
    if (email.isEmpty || !email.contains('@')) {
      _showAlertDialog(context, 'Invalid Email', 'Please enter a valid email address.');
    } else if (password.isEmpty || password.length < 6) {
      _showAlertDialog(context, 'Invalid Password', 'Password must be at least 6 characters long.');
    } else if (firstName.isEmpty) {
      _showAlertDialog(context, 'Invalid First Name', 'Please enter your first name.');
    } else if (lastName.isEmpty) {
      _showAlertDialog(context, 'Invalid Last Name', 'Please enter your last name.');
    } else if (address.isEmpty) {
      _showAlertDialog(context, 'Invalid Address', 'Please enter your address.');
    } else if (contactNumber.isEmpty || contactNumber.length < 10) {
      _showAlertDialog(context, 'Invalid Contact Number', 'Please enter a valid contact number.');
    } else {
      // All fields are valid, proceed with Firebase registration
      _register(context, email, password, firstName, lastName, address, contactNumber);
    }
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _register(BuildContext context, String email, String password, String firstName, String lastName, String address, String contactNumber) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      // Save additional details in Firestore
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'contactNumber': contactNumber,
        'regDate': DateTime.now(),
        'userType' : 'user',
      });
      userCredential.user!.updateProfile(displayName: "$firstName" "$lastName");
      // Registration successful, show success message or navigate
      Navigator.pushReplacementNamed(context, RoutesName.main);
    }).catchError((error) {
      // Handle registration errors here
      _showAlertDialog(context, 'Registration Failed', 'An error occurred: $error');
    });
  }
}
