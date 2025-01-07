import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount? user = GoogleSignIn().currentUser;
    return Drawer(
      child: ListView(
        children: <Widget>[
          user == null
              ? DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                  ),
                  child: Text('Please login to view details'),
                )
              : UserAccountsDrawerHeader(
                  accountName: Text('User Name'),
                  accountEmail: Text('user@example.com'),
                ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              context.goNamed('home');
            },
          ),
          ListTile(
            title: const Text('Events'),
            onTap: () {
              context.goNamed('allEvents');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              context.goNamed('profile');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              GoogleSignIn().signOut();
            },
          ),
        ],
      ),
    );
  }
}
