import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medrpha/widgets/terms_condition_page.dart';
import '../Controllers/register_user_controller.dart';
import 'drop_downWidgets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';


class RegisterUser extends StatefulWidget {
  final String? mobileNumber;

  const RegisterUser({super.key, this.mobileNumber});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  String? selectedCountry;
  final List<Country> countryList = CountryService().getAll();

  final ScrollController myController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final RegisterUserController controller = RegisterUserController();

  bool _obscurePassword = true;

  String? gstSelected;
  String? dlSelected;
  String? fssaiSelected;

  @override
  void initState() {
    super.initState();

    if(widget.mobileNumber != null &&
        widget.mobileNumber!.isNotEmpty) {
      controller.phoneController.text = widget.mobileNumber!;
    }
  }

  //  Pick DL file
  Future<void> pickDLFile({required bool isDL1}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        if (isDL1) {
          controller.dl1File = result.files.first;
          controller.dl1Controller.text = controller.dl1File!.name;
        } else {
          controller.dl2File = result.files.first;
          controller.dl2Controller.text = controller.dl2File!.name;
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text("Create New User Account",
        style: GoogleFonts.poppins(
          color: Colors.white
        ),),
      ),
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: RawScrollbar(
            controller: myController,
            thumbColor: Colors.blue,
            radius: const Radius.circular(12),
            minThumbLength: 20,
            child: SingleChildScrollView(
              controller: myController,
              padding: const EdgeInsets.only(right: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // --- FIRM DETAILS ---
                    const Text(
                      "Firm Details",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Name (Firm/Customer) *",
                      controller.nameController,
                      icon: CupertinoIcons.person,
                      isRequired: true,
                    ),
                    const SizedBox(height: 15),

                    // GST
                    DropDownwidgets(
                      title: "GST No.",
                      selectedValue: gstSelected,
                      onChanged: (value) {
                        setState(() {
                          gstSelected = value;
                          if (gstSelected == "No") {
                            controller.gstController.clear();
                          }
                        });
                      },
                      yesFields: [
                        const SizedBox(height: 15),
                        _customTextField(
                          "GST Number *",
                          controller.gstController,
                          icon: CupertinoIcons.doc_text,
                          isRequired: true,
                          validator: (value) {
                            if (gstSelected == "Yes" &&
                                (value == null || value.trim().isEmpty)) {
                              return "GST number is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    _customTextField(
                      "Phone No.",
                      controller.phoneController,
                      icon: CupertinoIcons.phone,
                      keyboardType: TextInputType.phone,
                      readOnly: true,
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Password",
                      controller.passwordController,
                      icon: CupertinoIcons.lock,
                      isObscure: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          size: 20,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Email Address",
                      controller.emailController,
                      icon: CupertinoIcons.mail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return null;
                        final emailRegex =
                        RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                        if (!emailRegex.hasMatch(value)) return "Invalid Email";
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Drugs Licence
                    DropDownwidgets(
                      title: "Drugs Licence",
                      selectedValue: dlSelected,
                      onChanged: (value) {
                        setState(() {
                          dlSelected = value;

                          if (dlSelected == "No") {
                            controller.drugsNameController.clear();
                            controller.drugsNoController.clear();
                            controller.dl1Controller.clear();
                            controller.dl2Controller.clear();
                            controller.validUptoController.clear();
                            controller.dl1File = null;
                            controller.dl2File = null;
                          }
                        });
                      },
                      yesFields: [
                        const SizedBox(height: 15),
                        _customTextField(
                          "Drugs Licence Name *",
                          controller.drugsNameController,
                          icon: CupertinoIcons.doc_text,
                          isRequired: true,
                        ),
                        const SizedBox(height: 15),
                        _customTextField(
                          "Drugs Licence No. *",
                          controller.drugsNoController,
                          icon: CupertinoIcons.doc_text,
                          isRequired: true,
                        ),
                        const SizedBox(height: 15),

                        //  DL-1 File Upload
                        _fileUploadField(
                          label: "DL-1 *",
                          textController: controller.dl1Controller,
                          icon: CupertinoIcons.doc,
                          isRequired: true,
                          onPickFile: () => pickDLFile(isDL1: true),
                        ),

                        const SizedBox(height: 15),

                        //  DL-2 File Upload
                        _fileUploadField(
                          label: "DL-2 *",
                          textController: controller.dl2Controller,
                          icon: CupertinoIcons.doc,
                          isRequired: true,
                          onPickFile: () => pickDLFile(isDL1: false),
                        ),

                        const SizedBox(height: 15),
                        _customTextField(
                          "Valid Upto *",
                          controller.validUptoController,
                          icon: CupertinoIcons.calendar,
                          isRequired: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // FSSAI
                    DropDownwidgets(
                      title: "FSSAI",
                      selectedValue: fssaiSelected,
                      onChanged: (value) {
                        setState(() {
                          fssaiSelected = value;
                          if (fssaiSelected == "No") {
                            controller.fssaiController.clear();
                            controller.fssaiImageController.clear();
                          }
                        });
                      },
                      yesFields: [
                        const SizedBox(height: 15),
                        _customTextField(
                          "FSSAI No. *",
                          controller.fssaiController,
                          icon: CupertinoIcons.doc_text,
                          isRequired: true,
                        ),
                        const SizedBox(height: 15),
                        _customTextField(
                          "FSSAI Image *",
                          controller.fssaiImageController,
                          icon: CupertinoIcons.photo,
                          isRequired: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // _customTextField(
                    //   "Country *",
                    //   controller.countryController,
                    //   icon: CupertinoIcons.globe,
                    //   readOnly: true,
                    //   isRequired: true,
                    // ),

                    DropdownSearch<Country>(
                      items: countryList,
                      itemAsString: (Country c) => "${c.flagEmoji} ${c.name}",
                      selectedItem: selectedCountry != null
                          ? countryList.firstWhere(
                            (c) => c.name == selectedCountry,
                      )
                          : null,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search country...",
                          ),
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Country *",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          prefixIcon: const Icon(
                            CupertinoIcons.globe,
                            size: 20,
                            color: Colors.blue,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Country is required";
                        }
                        return null;
                      },
                      onChanged: (Country? country) {
                        setState(() {
                          selectedCountry = country?.name;
                          controller.countryController.text = country?.name ?? "";
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    _customTextField(
                      "State *",
                      controller.stateController,
                      icon: CupertinoIcons.map_pin_ellipse,
                      isRequired: true,
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Select City *",
                      controller.cityController,
                      icon: CupertinoIcons.location_solid,
                      isRequired: true,
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Select Pin Code *",
                      controller.pinController,
                      icon: CupertinoIcons.map_pin,
                      keyboardType: TextInputType.number,
                      isRequired: true,
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Address *",
                      controller.addressController,
                      icon: CupertinoIcons.home,
                      isRequired: true,
                    ),

                    const Divider(height: 30, thickness: 1),

                    // --- CONTACT DETAILS ---
                    const Text(
                      "Contact Detail",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Contact Person Name *",
                      controller.contactNameController,
                      icon: CupertinoIcons.person_alt,
                      isRequired: true,
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Number *",
                      controller.contactPhoneController,
                      icon: CupertinoIcons.phone_fill,
                      keyboardType: TextInputType.phone,
                      isRequired: true,
                    ),
                    const SizedBox(height: 15),

                    _customTextField(
                      "Alternate Number",
                      controller.alternatePhoneController,
                      icon: CupertinoIcons.phone_circle,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),

                    CheckboxListTile(
                      title: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: "I agree with "),
                            TextSpan(
                              text: "Terms and Conditions",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const TermsConditionPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),

                      value: controller.isChecked,
                      onChanged: (val) {
                        setState(() {
                          controller.isChecked = val ?? false;
                        });
                      },
                      activeColor: Colors.blue,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),

                    const SizedBox(height: 20),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          if (!controller.isChecked) {
                            Get.snackbar(
                              "Warning",
                              "Please accept Terms and Conditions",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }

                          Get.snackbar(
                            "Success",
                            "Account Created Successfully",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green.shade300,
                            colorText: Colors.white,
                          );
                        },
                        icon: const Icon(CupertinoIcons.check_mark_circled,
                            color: Colors.white),
                        label: const Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),

    );
  }

  // ✅ File Upload Field
  Widget _fileUploadField({
    required String label,
    required TextEditingController textController,
    required IconData icon,
    required VoidCallback onPickFile,
    bool isRequired = false,
  }) {
    return TextFormField(
      controller: textController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: Icon(icon, size: 20, color: Colors.blue),
        suffixIcon: IconButton(
          icon: const Icon(CupertinoIcons.cloud_upload, color: Colors.blue),
          onPressed: onPickFile,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return "File is required";
        }
        return null;
      },
      onTap: onPickFile,
    );
  }

  // TextField with optional required validation
  Widget _customTextField(
      String label,
      TextEditingController controller, {
        bool isObscure = false,
        bool readOnly = false,
        TextInputType keyboardType = TextInputType.text,
        required IconData icon,
        bool isRequired = false,
        Widget? suffixIcon,
        String? Function(String?)? validator,
      }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: Icon(icon, size: 20, color: Colors.blue),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: const TextStyle(height: 1.5, color: Colors.red),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      validator: validator ??
              (value) {
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return "This field is required";
            }
            return null;
          },
    );
  }
}
