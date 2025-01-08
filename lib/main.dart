import 'package:event_app/core/database/database_helper.dart';
import 'package:event_app/core/routes.dart';
import 'package:event_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:event_app/features/events/data/repositories/impl_event_repository.dart';
import 'package:event_app/features/events/data/repositories/impl_offline_event_repository.dart';
import 'package:event_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:event_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:event_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:event_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(
            create: (context) => EventsBloc(
                eventRepository: ImplEventRepository(),
                offlineEventRepository: ImplOfflineEventRepository())),
      ],
      child: MaterialApp.router(
        routerConfig: EventifyRouter().router,
        debugShowCheckedModeBanner: false,
        title: 'Eventify',
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.blue.shade900,
            secondary: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
