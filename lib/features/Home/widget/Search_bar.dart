
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});


  @override
  Widget build(BuildContext context) {


    return  Material(
      borderRadius: BorderRadius.circular(15),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon:  Icon(CupertinoIcons.search) ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.white70,
          filled: true,
        ),
      ),
    );
  }
}


