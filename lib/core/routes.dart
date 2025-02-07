import 'package:event_app/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:event_app/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/domain/entities/offline_event.dart';
import 'package:event_app/features/events/presentation/pages/all_events_page.dart';
import 'package:event_app/features/events/presentation/pages/create_event_page.dart';
import 'package:event_app/features/events/presentation/pages/event_details_page.dart';
import 'package:event_app/features/events/presentation/pages/my_events_page.dart';
import 'package:event_app/features/events/presentation/pages/offline_event_details_page.dart';
import 'package:event_app/features/events/presentation/pages/saved_events_page.dart';
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
        name: 'profile',
        path: '/profile',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ProfilePage());
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'savedEvents',
            path: '/saved-events',
            pageBuilder: (context, state) {
              return MaterialPage(child: SavedEventsPage());
            },
            routes: <RouteBase>[
              GoRoute(
                name: 'offlineEventDetails',
                path: '/offline-event-details',
                pageBuilder: (context, state) {
                  final OfflineEvent event = state.extra as OfflineEvent;
                  return MaterialPage(
                      child: OfflineEventDetailsPage(
                    event: event,
                  ));
                },
              )
            ],
          ),
          GoRoute(
            name: 'myEvents',
            path: '/my-events',
            pageBuilder: (context, state) {
              return MaterialPage(child: MyEventsPage());
            },
            routes: <RouteBase>[
              GoRoute(
                name: 'createEvent',
                path: '/create-event',
                pageBuilder: (context, state) {
                  final Map<String, dynamic>? extra =
                      state.extra as Map<String, dynamic>?;
                  final Event? event = extra?['event'];
                  final bool isEditable = extra?['isEditable'] ?? false;
                  return MaterialPage(
                    child: CreateEventPage(
                      isEditable: isEditable,
                      event: event,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'allEvents',
        path: '/all-events',
        pageBuilder: (context, state) {
          return MaterialPage(child: AllEventsPage());
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'eventDetails',
            path: '/event-details',
            pageBuilder: (context, state) {
              final Event event = state.extra as Event;
              return MaterialPage(
                  child: EventDetailsPage(
                event: event,
              ));
            },
          ),
          GoRoute(
            name: 'myEventsFromAllEvents',
            path: '/my-events-from-all-events',
            pageBuilder: (context, state) {
              return MaterialPage(child: MyEventsPage());
            },
            routes: <RouteBase>[
              GoRoute(
                name: 'createEventFromAllEvents',
                path: '/create-event-from-all-events',
                pageBuilder: (context, state) {
                  final Map<String, dynamic>? extra =
                      state.extra as Map<String, dynamic>?;
                  final Event? event = extra?['event'];
                  final bool isEditable = extra?['isEditable'] ?? false;
                  return MaterialPage(
                    child: CreateEventPage(
                      isEditable: isEditable,
                      event: event,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
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
