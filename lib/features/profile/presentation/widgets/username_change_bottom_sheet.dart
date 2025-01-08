import 'package:event_app/core/configs/colors_config.dart';
import 'package:event_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameChangeBottomSheet extends StatefulWidget {
  final String? displayName;
  const UsernameChangeBottomSheet({super.key, required this.displayName});

  @override
  State<UsernameChangeBottomSheet> createState() =>
      _UsernameChangeBottomSheetState();
}

class _UsernameChangeBottomSheetState extends State<UsernameChangeBottomSheet> {
  final TextEditingController displayNameTextController =
      TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    displayNameTextController.text = widget.displayName ?? '';
  }

  @override
  void dispose() {
    displayNameTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.close_rounded,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                TextField(
                  controller: displayNameTextController,
                  focusNode: _focusNode,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Display Name',
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
                TextButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(
                          UpdateDisplayNameEvent(
                              displayNameTextController.text),
                        );
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
