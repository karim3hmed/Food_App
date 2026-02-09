import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.hint,
    required this.controller,
    required this.ispassword,
  });
  final String hint;
  final TextEditingController controller;
  final bool ispassword;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscuretext;

  @override
  void initState() {
    _obscuretext = widget.ispassword;
    super.initState();
  }

  void togglepassword() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscuretext,
      controller: widget.controller,
      cursorColor: Colors.grey,
      cursorHeight: 25,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please fill ${widget.hint}";
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: widget.ispassword
            ? GestureDetector(
                onTap: () => togglepassword(),
                child: Icon(CupertinoIcons.eye, color: Colors.white),
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
