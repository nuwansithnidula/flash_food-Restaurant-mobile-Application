import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_food/Core/app_colors.dart';
import 'package:flash_food/Core/assets_constantes.dart';
import 'package:flash_food/Presentation/Auth/screens/default_button.dart';
import 'package:flash_food/Presentation/Base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../Core/response_conf.dart';

class PersonalDataView extends StatefulWidget {
  const PersonalDataView({Key? key}) : super(key: key);

  @override
  State<PersonalDataView> createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
  // Variables to hold the user data
  String? displayName;
  String? firstName;
  String? lastName;
  String? email;
  String? phone; // Phone will be handled as a String for text input
  String? address;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers for form fields
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get user data from Firestore using user ID
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          // Assign the data to the respective fields
          displayName = userDoc.data()?['displayName'] ?? user.displayName ?? '';
          firstName = userDoc.data()?['firstName'] ?? '';
          lastName = userDoc.data()?['lastName'] ?? '';
          email = userDoc.data()?['email'] ?? user.email ?? '';
          phone = userDoc.data()?['contactNumber']?.toString() ?? ''; // Convert phone int to String
          address = userDoc.data()?['address'] ?? '';

          // Set the values to the controllers
          displayNameController.text = displayName ?? '';
          firstNameController.text = firstName ?? '';
          lastNameController.text = lastName ?? '';
          emailController.text = email ?? '';
          phoneController.text = phone ?? '';
          addressController.text = address ?? '';
        });
      }
    }
  }

  Future<void> _saveUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'displayName': displayNameController.text,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'phone': int.tryParse(phoneController.text), // Safely convert phone to int
          'address': addressController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User data updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user data: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers
    displayNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(buildContext: context, screenTitle: "Personal Data"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(24)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(24),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(AssetsConstants.user),
                    radius: getSize(50),
                  ),
                  Positioned(
                    left: getSize(72),
                    bottom: getSize(8),
                    child: Container(
                      width: getSize(32),
                      height: getSize(32),
                      padding: EdgeInsets.all(getSize(6)),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CupertinoIcons.camera_fill,
                        color: Pallete.orangePrimary,
                        size: getSize(20),
                      ),
                    ),
                  )
                ],
              ),
              const Gap(24),
              Column(
                children: [
                  TextFormField(
                    controller: displayNameController,
                    decoration: InputDecoration(
                      labelText: "Display Name",
                    ),
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: "First Name",
                    ),
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                    ),
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Phone",
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Address",
                    ),
                  ),
                ],
              ),
              const Gap(36),
              DefaultButton(
                btnContent: "Save",
                function: () {
                  if (_formKey.currentState!.validate()) {
                    _saveUserData();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
