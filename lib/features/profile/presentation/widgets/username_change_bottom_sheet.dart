import 'package:event_app/core/configs/colors_config.dart';
import 'package:event_app/features/profile/presentation/widgets/password_card.dart';
import 'package:flutter/material.dart';

class UsernameChangeBottomSheet extends StatefulWidget {
  const UsernameChangeBottomSheet({super.key});

  @override
  State<UsernameChangeBottomSheet> createState() =>
      _UsernameChangeBottomSheetState();
}

class _UsernameChangeBottomSheetState extends State<UsernameChangeBottomSheet> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
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

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: PasswordCard(
                title: 'Username',
                //Add the current username here
                passwordText: 'Pawan Rajapakshe',
                passwordTextReadOnly: false,
                label: '',
                iconIsVisible: false,
              ),
            ),
          ),

          //Save Name Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: TextButton(
                onPressed: () {
                  //Add the logic to update the name here

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
                      Text('Save Name',
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
