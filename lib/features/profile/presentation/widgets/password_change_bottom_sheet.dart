import 'package:event_app/core/configs/colors_config.dart';
import 'package:event_app/features/profile/presentation/widgets/password_card.dart';
import 'package:flutter/material.dart';

class PasswordChangeBottomSheet extends StatelessWidget {
  const PasswordChangeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
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

          //
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

          //
          const SizedBox(height: 10),

          Text('Add a new secure password here',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0x80000000),
              )),

          //
          const SizedBox(height: 10),

          //create password widget and add it here
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              // padding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom),
              children: [
                PasswordCard(
                  title: 'Current Password',
                  //Add the current password here
                  passwordText: 'k220bh3',
                  passwordTextReadOnly: true,
                  label: '',
                  iconIsVisible: true,
                ),
                PasswordCard(
                  title: 'New Password',
                  label: 'Type New Password',
                  iconIsVisible: true,
                ),
                PasswordCard(
                  title: 'Confirm New Password',
                  label: 'Type New Password',
                  iconIsVisible: true,
                ),
                // const SizedBox(height: 300),
              ],
            ),
          ),

          //Update Password Button
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
