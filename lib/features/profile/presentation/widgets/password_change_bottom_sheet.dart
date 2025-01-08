import 'package:event_app/core/configs/colors_config.dart';
import 'package:event_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordChangeBottomSheet extends StatefulWidget {
  const PasswordChangeBottomSheet({super.key});

  @override
  State<PasswordChangeBottomSheet> createState() =>
      _PasswordChangeBottomSheetState();
}

class _PasswordChangeBottomSheetState extends State<PasswordChangeBottomSheet> {
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  @override
  void dispose() {
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      listener: (context, state) {
        if (state is UserPasswordUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully')),
          );
          Navigator.of(context).pop();
        } else if (state is UserPasswordUpdateFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: formKey,
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
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New Password",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 54,
                            child: TextFormField(
                              controller: passwordTextController,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(left: 20.0),
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
                                hintText: "Type New Password",
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Confirm Password",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 54,
                            child: TextFormField(
                              controller: confirmPasswordTextController,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(left: 20.0),
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
                                hintText: "Type Confirm Password",
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20,
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 10),
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (passwordTextController.text ==
                                confirmPasswordTextController.text) {
                              context.read<AuthenticationBloc>().add(
                                    UpdatePasswordEvent(
                                      passwordTextController.text,
                                    ),
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords do not match'),
                                ),
                              );
                            }
                          }
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
