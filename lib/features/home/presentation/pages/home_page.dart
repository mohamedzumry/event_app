import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
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
  ValueNotifier<int> _selectedCarouselIndex = ValueNotifier<int>(0);

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
        title: 'Upcoming Events',
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeEventsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeEventsLoadedState) {
              final upcomingEvents = state.upcomingEventsList;
              return Column(
                children: [
                  // Carousel
                  Expanded(
                    child: StreamBuilder(
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
                                itemCount: upcomingEvents.length,
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    // setState(() {
                                    _selectedCarouselIndex.value = index;
                                    // _carouselController.jumpToPage(index);
                                    // });
                                  },
                                  height: MediaQuery.of(context).size.height,
                                  // aspectRatio: 2.0,
                                  viewportFraction: 0.85,
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
                                ),
                                carouselController: _carouselController,
                                itemBuilder: (context, index, realIndex) {
                                  final event = upcomingEvents[index];
                                  return EventCarouselTile(event: event);
                                });
                          }
                        }),
                  ),

                  const SizedBox(height: 2),

                  //Carousel indicators
                  ValueListenableBuilder<int>(
                    valueListenable: _selectedCarouselIndex,
                    builder: (context, selectedIndex, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: upcomingEvents.asMap().entries.map((entry) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: selectedIndex == entry.key ? 10.0 : 7.0,
                            height: selectedIndex == entry.key ? 10.0 : 7.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      selectedIndex == entry.key ? 0.9 : 0.4),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
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
      ),
      bottomNavigationBar: MainBottomBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
