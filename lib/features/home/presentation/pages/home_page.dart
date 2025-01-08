import 'package:carousel_slider/carousel_slider.dart';
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
  int _selectedCarouselIndex = 0;

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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Text('Latest 10 Events',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    items: latestEvents
                        .map((event) => EventCarouselTile(event: event))
                        .toList(),
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.42,
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: false,
                      viewportFraction: 0.9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _selectedCarouselIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: latestEvents.asMap().entries.map((entry) {
                      return Container(
                        width: 7.0,
                        height: 7.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_selectedCarouselIndex == entry.key
                                  ? 0.9
                                  : 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text('Upcoming 10 Events',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  const SizedBox(height: 16),
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
