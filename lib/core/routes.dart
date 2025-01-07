import 'package:event_app/features/authentication/presentation/pages/sign_in_sign_up_page.dart';
import 'package:event_app/features/events/presentation/pages/all_events_page.dart';
import 'package:event_app/features/home/presentation/pages/home_page.dart';
import 'package:event_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventifyRouter {
  GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'home',
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: 'profile',
        path: '/profile',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ProfilePage());
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: 'auth',
        path: '/auth',
        pageBuilder: (context, state) {
          return MaterialPage(child: SignInSignUpPage());
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        name: 'allEvents',
        path: '/all-events',
        pageBuilder: (context, state) {
          return MaterialPage(child: AllEventsPage());
        },
        routes: const <RouteBase>[],
      ),
    ],
    // errorPageBuilder: (context, state) {
    //   return const MaterialPage(
    //       child: ErrorPage(
    //     title: 'Error',
    //   ));
    // },
  );
}
