import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/events/presentation/widgets/events_card.dart';
import 'package:event_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:event_app/features/home/presentation/widgets/event_craousel_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadEventsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(
        title: 'Eventify',
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeEventsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeEventsLoadedState) {
            final latestEvents = state.latestEventsList;
            final upcomingEvents = state.upcomingEventsList;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('events')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return Text('No data available.');
                        } else {
                          return CarouselSlider.builder(
                              itemCount: latestEvents.length,
                              options: CarouselOptions(
                                height: 400,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 10),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 1600),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                // onPageChanged: (index, reason) {
                                //   setState(() {
                                //     _carouselController.jumpToPage(index);
                                //   });
                                // },
                              ),
                              carouselController: _carouselController,
                              itemBuilder: (context, index, realIndex) {
                                final event = latestEvents[index];
                                return EventCarouselTile(event: event);
                              });
                        }
                      }),
                  const SizedBox(height: 16),
                  // Upcoming Events
                  Text(
                    'Upcoming Events',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: upcomingEvents.length,
                    itemBuilder: (context, index) {
                      return EventCard(event: upcomingEvents[index]);
                    },
                  ),
                ],
              ),
            );
          } else if (state is HomeEventsLoadingError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(
                child: Text(
                    'Some error occurred from our end, please try again later...'));
          }
        },
      ),
      bottomNavigationBar: MainBottomBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
