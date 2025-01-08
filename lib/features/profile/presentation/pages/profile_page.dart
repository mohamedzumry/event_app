import 'package:event_app/core/configs/colors_config.dart';
import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:event_app/features/profile/presentation/widgets/account_details_card.dart';
import 'package:event_app/features/profile/presentation/widgets/password_change_bottom_sheet.dart';
import 'package:event_app/features/profile/presentation/widgets/username_change_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signed out successfully')),
          );
          context.goNamed('home');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          title: 'Profile',
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        bottomNavigationBar: MainBottomBar(selectedIndex: 2),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Profile Picture
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Color(ColorsConfig().greyBlue), width: 2.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFD4D4D4),
                      minRadius: 49,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.fill,
                          image: user.photoURL != null
                              ? NetworkImage(user.photoURL!)
                              : AssetImage('assets/images/dp.jpeg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text('Tap on the name to change',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0x80000000),
                    )),
              ),
              AccountDetailsCard(
                title: 'Name',
                dataField: user.displayName != null ? user.displayName! : '',
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom +
                              MediaQuery.of(context).size.height * 0.4,
                          child: UsernameChangeBottomSheet(
                              displayName: user.displayName),
                        );
                      });
                },
              ),
              AccountDetailsCard(
                title: 'Email',
                //setting the dataField to a hardcoded value for now to avoid errors
                dataField: user.email != null ? user.email! : '',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.blue.shade900),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  icon: Icon(Icons.event_available_sharp),
                  onPressed: () => context.goNamed('myEvents'),
                  label: Text('My Events',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.password),
                  onPressed: (() {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.86,
                            child: PasswordChangeBottomSheet(),
                          );
                        });
                  }),
                  label: Text('Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.logout),
                  onPressed: () => context.read<AuthenticationBloc>().add(
                        LogoutEvent(),
                      ),
                  label: Text('Sign Out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
