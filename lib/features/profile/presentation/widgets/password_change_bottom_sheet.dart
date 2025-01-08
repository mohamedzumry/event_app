import 'package:event_app/core/configs/colors_config.dart';
import 'package:flutter/material.dart';

class PasswordChangeBottomSheet extends StatelessWidget {
  const PasswordChangeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordTextController = TextEditingController();
    TextEditingController confirmPasswordTextController =
        TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 5,
              width: 64,
              decoration: const BoxDecoration(
                color: Color(0x40000000),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topRight,
            child: IconButton.filled(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Color(0xFFF5F5F5)),
                backgroundColor: WidgetStatePropertyAll(Color(0xFFF5F5F5)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close_rounded,
                color: Colors.black,
              ),
            ),
          ),
          Text('Change Password',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              )),
          const SizedBox(height: 10),
          Text('Add a new secure password here',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0x80000000),
              )),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                TextField(
                  obscureText: true,
                  controller: passwordTextController,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    label: Text('New Password'),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20.0),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  controller: confirmPasswordTextController,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    label: Text('Confirm Password'),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20.0),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                  ),
                ),
                // PasswordCard(
                //   title: 'New Password',
                //   label: 'Type New Password',
                //   iconIsVisible: true,
                // ),
                // PasswordCard(
                //   title: 'Confirm New Password',
                //   label: 'Type New Password',
                //   iconIsVisible: true,
                // ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: TextButton(
                onPressed: () {
                  //Add the logic to update the password here

                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(ColorsConfig().purpleBlue),
                  minimumSize: const Size.fromHeight(54),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Update Password',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
