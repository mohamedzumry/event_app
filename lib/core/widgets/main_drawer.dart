import 'package:event_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signed out successfully')),
          );
          context.pop();
        }
      },
      child: Drawer(
        backgroundColor: Colors.blue.shade900,
        child: ListView(
          children: <Widget>[
            user != null
                ? UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: user.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : null,
                    ),
                    onDetailsPressed: () => context.goNamed('profile'),
                    accountName: Text(user.displayName != null
                        ? user.displayName!
                        : 'User Name'),
                    accountEmail: Text(user.email!),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    height: 100,
                    child: Text('Eventify',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
            ListTile(
              textColor: Color(Colors.white.value),
              title: const Text('Home'),
              onTap: () {
                context.goNamed('home');
              },
            ),
            ListTile(
              textColor: Color(Colors.white.value),
              title: const Text('Events'),
              onTap: () {
                context.goNamed('allEvents');
              },
            ),
            ListTile(
              textColor: Color(Colors.white.value),
              title: const Text('Profile'),
              onTap: () {
                context.goNamed('profile');
              },
            ),
            user != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () => context.read<AuthenticationBloc>().add(
                            LogoutEvent(),
                          ),
                      child: const Text('Sign Out'),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                        onPressed: () => context.goNamed('signIn'),
                        child: const Text('Sign In')),
                  ),
          ],
        ),
      ),
    );
  }
}
