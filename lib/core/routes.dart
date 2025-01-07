import 'package:event_app/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:event_app/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:event_app/features/events/presentation/pages/all_events_page.dart';
import 'package:event_app/features/events/presentation/pages/create_event_page.dart';
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
        routes: <RouteBase>[
          GoRoute(
            name: 'createEvent',
            path: '/create-event',
            pageBuilder: (context, state) {
              return MaterialPage(child: CreateEventPage());
            },
          ),
        ],
      ),
      GoRoute(
        name: 'signIn',
        path: '/sign-in',
        pageBuilder: (context, state) {
          return MaterialPage(child: SignInPage());
        },
      ),
      GoRoute(
        name: 'signUp',
        path: '/sign-up',
        pageBuilder: (context, state) {
          return MaterialPage(child: SignUpPage());
        },
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
