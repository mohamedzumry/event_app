// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PasswordCard extends StatefulWidget {
  String title;
  String label;
  bool iconIsVisible;
  String passwordText;
  bool passwordTextReadOnly;
  PasswordCard({
    super.key,
    required this.title,
    required this.label,
    required this.iconIsVisible,
    this.passwordText = '',
    this.passwordTextReadOnly = false,
  });

  @override
  State<PasswordCard> createState() => _PasswordCardState();
}

class _PasswordCardState extends State<PasswordCard> {
  bool _obscureText = false;
  bool passwordReadOnly = false;

  //For the 1st password field to auto fill current password
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _obscureText = widget.iconIsVisible;
    passwordReadOnly = widget.passwordTextReadOnly;

    super.initState();

    passwordTextController.text = widget.passwordText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),

          //
          const SizedBox(height: 10),

          // Username textbox
          SizedBox(
            height: 54,
            child: TextField(
              readOnly: passwordReadOnly,
              controller: passwordTextController,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                contentPadding: const EdgeInsets.only(left: 20.0),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                hintText: widget.label,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                //suffix icon
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                      // if(widget.isVisible == true){
                      //   _obscureText: true;
                      // };
                      // if(widget.isVisible == false){
                      //   _obscureText: false;
                      // };
                    });
                  },
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Visibility(
                      visible: widget.iconIsVisible,
                      child: Icon(
                          color: Colors.black,
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                    ),
                  ),
                ),
              ),
              obscureText: _obscureText,
            ),
          ),
        ],
      ),
    );
  }
}
