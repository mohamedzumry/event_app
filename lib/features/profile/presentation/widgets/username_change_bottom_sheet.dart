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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      listener: (context, state) {
        if (state is UserDisplayNameUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Name updated to ${state.displayName}')),
          );
          context.pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft, // Aligning text to the left
                child: Text(
                  "Change Name",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 54,
                child: TextField(
                  controller: displayNameTextController,
                  focusNode: _focusNode,
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
                    hintText: "Type New Name",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
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
                      if (displayNameTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter a name')),
                        );
                      } else {
                        context.read<AuthenticationBloc>().add(
                              UpdateDisplayNameEvent(
                                displayNameTextController.text,
                              ),
                            );
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(ColorsConfig().purpleBlue),
                      minimumSize: const Size.fromHeight(54),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Save Name',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
