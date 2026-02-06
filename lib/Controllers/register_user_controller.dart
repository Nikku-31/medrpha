import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RegisterUserController {
  // Firm Detail
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Drugs Licence Detail
  final TextEditingController drugsController = TextEditingController(); // old (optional)
  final TextEditingController drugsNameController = TextEditingController();
  final TextEditingController drugsNoController = TextEditingController();
  final TextEditingController dl1Controller = TextEditingController();
  final TextEditingController dl2Controller = TextEditingController();
  final TextEditingController validUptoController = TextEditingController();

  // FSSAI Detail
  final TextEditingController fssaiController = TextEditingController();
  final TextEditingController fssaiImageController = TextEditingController();

  // Address Detail
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Contact Detail
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactPhoneController = TextEditingController();
  final TextEditingController alternatePhoneController = TextEditingController();

  PlatformFile? dl1File;
  PlatformFile? dl2File;

  bool isChecked = false;

  // Optional: Dispose function (recommended)
  void dispose() {
    nameController.dispose();
    gstController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    emailController.dispose();

    drugsController.dispose();
    drugsNameController.dispose();
    drugsNoController.dispose();
    dl1Controller.dispose();
    dl2Controller.dispose();
    validUptoController.dispose();

    fssaiController.dispose();
    fssaiImageController.dispose();

    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    pinController.dispose();
    addressController.dispose();

    contactNameController.dispose();
    contactPhoneController.dispose();
    alternatePhoneController.dispose();
  }
}
