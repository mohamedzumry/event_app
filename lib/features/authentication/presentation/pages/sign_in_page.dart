import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // form key
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      listener: (context, state) {
        if (state is GoogleLoginSuccessState) {
          context.goNamed('home');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signed in as ${state.user.displayName}')),
          );
        } else if (state is GoogleLoginFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is UserLoginSuccessState) {
          context.goNamed('home');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signed in as ${state.user.displayName}')),
          );
        } else if (state is UserLoginFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          title: 'Sign In',
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: MainBottomBar(selectedIndex: 2),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please enter a valid email");
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) =>
                      value!.isEmpty ? 'Password is required' : null,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MaterialButton(
                      color: Colors.teal[100],
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/sign-in.png'),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Sign In with Email & Password")
                        ],
                      ),
                      onPressed: () {
                        // if validated
                        if (formKey.currentState!.validate()) {
                          context.read<AuthenticationBloc>().add(
                                SignInWithGoogleUsingEmailPasswordEvent(
                                  _emailController.text,
                                  _passwordController.text,
                                ),
                              );
                        }
                      }),
                ),
                const SizedBox(height: 10),
                const Text(
                  "OR",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MaterialButton(
                    color: Colors.teal[100],
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/google-logo.png'),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Sign In with Google")
                      ],
                    ),
                    onPressed: () => context.read<AuthenticationBloc>().add(
                          const SignInWithGoogleEvent(),
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.goNamed('signUp'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
