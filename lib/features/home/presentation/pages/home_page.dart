import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/features/events/domain/entities/event.dart';
import 'package:event_app/features/events/presentation/widgets/events_card.dart';
import 'package:event_app/features/home/presentation/widgets/event_craousel_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController slideController = CarouselSliderController();
  final int _selectedIndex = 0;
  int _selectedCarouselIndex = 0;

  List<Event> dummyFeaturedEventsList = [];

  List<Event> eventsList = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> eventSliders = dummyFeaturedEventsList
        .map((item) => EventCarouselTile(event: item))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'Eventify',
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: eventSliders,
            carouselController: slideController,
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
                }),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dummyFeaturedEventsList.asMap().entries.map((entry) {
              debugPrint("${_selectedCarouselIndex == entry.key}");

              return Container(
                width: 7.0,
                height: 7.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(
                            _selectedCarouselIndex == entry.key ? 0.9 : 0.4)),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: eventsList.length,
              itemBuilder: (BuildContext context, int index) {
                return EventCard(event: eventsList[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
