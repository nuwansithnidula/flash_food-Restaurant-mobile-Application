import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_food/Core/Routes/routes_name.dart';
import 'package:flash_food/Core/app_colors.dart';
import 'package:flash_food/Core/response_conf.dart';
import 'package:flash_food/Core/text_styles.dart';
import 'package:flash_food/Presentation/Auth/screens/default_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flash_food/Core/Utils/utils.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MathUtils.init(context);

    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(24)).copyWith(
            top: MediaQuery.of(context).viewPadding.top,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(32),
              Text(
                "Login to your\n account.",
                style: TextStyles.headingH4SemiBold
                    .copyWith(color: Pallete.neutral100),
              ),
              const Gap(8),
              Text(
                "Please sign in to your account ",
                style: TextStyles.bodyMediumMedium
                    .copyWith(color: Pallete.neutral60, fontSize: getFontSize(14)),
              ),
              const Gap(32),

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
              SizedBox(height: 30),
              const Gap(24),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, RoutesName.forgetPassword),
                  child: Text(
                    "Forgot password?",
                    style: TextStyles.bodyMediumMedium
                        .copyWith(color: Pallete.orangePrimary, fontSize: getFontSize(14)),
                  ),
                ),
              ),
              const Gap(24),

              // Sign In Button using Firebase Auth
              DefaultButton(
                btnContent: "Login",
                function: () => _login(context),
              ),
              const Gap(24),
              Row(
                children: [
                  const Expanded(
                      child: Divider(
                        color: Pallete.neutral60,
                        height: 0.5,
                      )),
                  const Gap(16),
                  Text(
                    "Or sign in with",
                    style: TextStyles.bodyMediumMedium
                        .copyWith(color: Pallete.neutral60, fontSize: getFontSize(14)),
                  ),
                  const Gap(16),
                  const Expanded(
                      child: Divider(
                        color: Pallete.neutral60,
                        height: 0.5,
                      )),
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
                          border: Border.all(color: Pallete.neutral40, width: 1)),
                      child: SvgPicture.asset(e),
                    ),
                  )).toList()),
              const Gap(32),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account?",
                        style: TextStyles.bodyMediumMedium
                            .copyWith(color: Pallete.neutral100, fontSize: getFontSize(14)),
                      ),
                      TextSpan(
                          text: ' ',
                          style: TextStyles.bodyMediumSemiBold.copyWith(fontSize: getFontSize(14))),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(context, RoutesName.signUp),
                          text: 'Register',
                          style: TextStyles.bodyMediumSemiBold
                              .copyWith(color: Pallete.orangePrimary, fontSize: getFontSize(14))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _login(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showAlertDialog(context, 'Error', 'Email and password cannot be empty');
      return;
    }

    try {
      // Sign in using Firebase Authentication
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user details from Firestore after successful login
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (userDoc.exists) {
        String userType = userDoc.get('userType'); // Fetch 'userType' field from Firestore

        // Redirect based on the userType field
        if (userType == 'admin') {
          Navigator.pushReplacementNamed(context, RoutesName.admin); // Admin page route
        } else if (userType == 'user') {
          Navigator.pushReplacementNamed(context, RoutesName.main); // Main page route
        } else {
          _showAlertDialog(context, 'Error', 'User type not recognized');
        }
      } else {
        _showAlertDialog(context, 'Error', 'User data not found');
      }
    } catch (e) {
      _showAlertDialog(context, 'Login Failed', 'Invalid email or password');
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
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
