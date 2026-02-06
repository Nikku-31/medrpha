import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownwidgets extends StatelessWidget {
  final String title;
  final String? selectedValue;
  final Function(String?) onChanged;
  final List<Widget> yesFields;
  final bool isRequired;

  const DropDownwidgets({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.onChanged,
    required this.yesFields,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          isDense: true,
          menuMaxHeight: 120,
          decoration: InputDecoration(
            labelText: "$title${isRequired ? " *" : ""}",
            filled: true,
            fillColor: Colors.grey.shade100,
            prefixIcon: const Icon(
              CupertinoIcons.doc_text,
              size: 18,
              color: Colors.blue,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 45,
              minHeight: 40,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
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
          ),
          value: selectedValue,
          items: const [
            DropdownMenuItem(
              value: "Yes",
              child: Text("Yes"),
            ),
            DropdownMenuItem(
              value: "No",
              child: Text("No"),
            ),
          ],
          onChanged: onChanged, validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return "Please select Yes or No";
            }
            return null;
          },
        ),

        if (selectedValue == "Yes") ...[
          const SizedBox(height: 12),
          ...yesFields,
        ],
      ],
    );
  }
}
