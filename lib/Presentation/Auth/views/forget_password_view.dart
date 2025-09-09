import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_food/Core/Routes/routes_name.dart';
import 'package:flash_food/Core/app_colors.dart';
import 'package:flash_food/Core/response_conf.dart';
import 'package:flash_food/Core/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({Key? key}) : super(key: key);

  // Controller to capture the user's email
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function to send password reset email
  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset link has been sent to your email.')),
      );
    } catch (e) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MathUtils.init(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(24)).copyWith(
          top: MediaQuery.of(context).viewPadding.top,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(32),
              Text(
                "Forgot password?",
                style: TextStyles.headingH4SemiBold
                    .copyWith(color: Pallete.neutral100, fontSize: getFontSize(32)),
              ),
              const Gap(8),
              Text(
                "Enter your email address and we’ll send you a password reset link.",
                style: TextStyles.bodyMediumMedium
                    .copyWith(color: Pallete.neutral60, fontSize: getFontSize(14)),
              ),
              const Gap(32),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  hintText: "Enter Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Send the reset link if the form is valid
                      _sendPasswordResetEmail(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: getHeight(16)), backgroundColor: Pallete.orangePrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Send Reset Link",
                    style: TextStyle(fontSize: getFontSize(16)),
                  ),
                ),
              ),
              const Gap(32)
            ],
          ),
        ),
      ),
    );
  }
}
