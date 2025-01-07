import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInSignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInSignUpPage({super.key});

  // void _signInWithGoogle(BuildContext context) async {
  //   User? user = await Authentication.signInWithGoogle();
  //   if (user != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Signed in as ${user.email}')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to sign in with Google')),
  //     );
  //   }
  // }

  // void _signUpWithEmailPassword(BuildContext context) async {
  //   User? user = await Authentication.signUpWithEmailAndPassword(
  //     _emailController.text,
  //     _passwordController.text,
  //   );
  //   if (user != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Signed up as ${user.email}')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to sign up')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          context.goNamed('home');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signed in as ${state.user.displayName}')),
          );
        } else if (state is UserRegistrationSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signed up successfully')),
          );
        } else if (state is UserLoginFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is UserRegistrationFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: 'Sign In / Sign Up',
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: MainBottomBar(selectedIndex: 2),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
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
                                  AssetImage('assets/images/google-logo.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Sign Up with Email & Password")
                    ],
                  ),
                  onPressed: () => context.read<AuthenticationBloc>().add(
                        const SignUpWithGoogleUsingEmailPasswordEvent(
                          'email',
                          'password',
                        ),
                      ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "OR",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
      ),
    );
  }
}
