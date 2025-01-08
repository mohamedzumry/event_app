import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_app/core/configs/colors_config.dart';
import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/profile/presentation/widgets/account_details_card.dart';
import 'package:event_app/features/profile/presentation/widgets/password_change_bottom_sheet.dart';
import 'package:event_app/features/profile/presentation/widgets/username_change_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // The indicator will show up when _isLoading = true.
  bool _isLoading = false;

  // This function will be triggered when the button is pressed
  void _startLoading() async {
    setState(() {
      _isLoading = true;
    });

    // Add logout logic here

    setState(() {
      _isLoading = false;
    });
  }

  noInternetSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No Internet. Please Check the Connection.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'Profile',
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: MainBottomBar(selectedIndex: 2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Profile Picture
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color(ColorsConfig().greyBlue), width: 2.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: const CircleAvatar(
                          backgroundColor: Color(0xFFD4D4D4),
                          minRadius: 49,
                          child: ClipOval(
                            child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/dp.jpeg')),
                            // child: Image.network(
                            //   'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                            //   fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: GestureDetector(
                        onTap: () {
                          // showModalBottomSheet(
                          //     isScrollControlled: true,
                          //     backgroundColor: Colors.white,
                          //     shape: const RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.vertical(
                          //         top: Radius.circular(25.0),
                          //       ),
                          //     ),
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return SizedBox(
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.2,
                          //         // Change the PictureChangeBottomSheet Widget to actual widget
                          //         child: const PictureChangeBottomSheet(),
                          //       );
                          //     });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Color(0x20000000),
                                  blurRadius: 2,
                                ),
                              ]),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //
              const SizedBox(height: 20),

              //
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
                //setting the dataField to a hardcoded value for now to avoid errors
                dataField: "Pawan Rajapakshe",
                onTap: () {
                  debugPrint('Name Tapped');
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
                          child: UsernameChangeBottomSheet(),
                        );
                      });
                },
              ),
              AccountDetailsCard(
                title: 'Email',
                //setting the dataField to a hardcoded value for now to avoid errors
                dataField: "example@ex.com",
                onTap: () {},
              ),

              //
              const SizedBox(height: 20),

              GestureDetector(
                onTap: (() {
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
                child: Container(
                  color: Colors.white,
                  child: Text('Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(ColorsConfig().blue),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(ColorsConfig().blue),
                      )),
                ),
              ),

              //
              const Spacer(),

              // Sign Out
              GestureDetector(
                onTap: () async {
                  final connectivityResult =
                      await Connectivity().checkConnectivity();

                  if (connectivityResult.contains(ConnectivityResult.wifi) ||
                      connectivityResult.contains(ConnectivityResult.mobile)) {
                    //This function is responsible for initiating loading
                    _startLoading();
                  } else {
                    noInternetSnackBar();
                  }
                },
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Sign Out',
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 20),
                      _isLoading
                          ? SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Color(ColorsConfig().blue),
                              ),
                            )
                          : Icon(null),
                    ],
                  ),
                ),
              ),
              //
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
