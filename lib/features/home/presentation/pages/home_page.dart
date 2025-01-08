import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_app/core/widgets/main_app_bar.dart';
import 'package:event_app/core/widgets/main_bottom_bar.dart';
import 'package:event_app/core/widgets/main_drawer.dart';
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

  List<Event> dummyFeaturedEventsList = [
    Event(
      id: "1",
      title: "Tech Conference 2025",
      location: "Silicon Valley Convention Center",
      date: "10/01/2025",
      time: "09:00 AM",
      organizerId: "org_001",
      organizerName: "Tech Innovators Inc.",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Technology",
      description:
          "Join us for the largest tech conference of the year featuring keynotes, workshops, and networking opportunities.",
    ),
    Event(
      id: "2",
      title: "Music Festival",
      location: "Central Park, New York",
      date: "15/02/2025",
      time: "06:00 PM",
      organizerId: "org_002",
      organizerName: "Live Nation",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Music",
      description:
          "Experience live performances from top artists around the globe in an unforgettable musical event.",
    ),
    Event(
      id: "3",
      title: "Art Exhibition",
      location: "The Louvre, Paris",
      date: "05/03/2025",
      time: "10:00 AM",
      organizerId: "org_003",
      organizerName: "Art World Organization",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Art",
      description:
          "Discover the masterpieces of renowned and emerging artists at this exclusive art exhibition.",
    ),
    Event(
      id: "4",
      title: "Startup Pitch Night",
      location: "Downtown Business Hub, San Francisco",
      date: "20/04/2025",
      time: "05:00 PM",
      organizerId: "org_004",
      organizerName: "Venture Builders",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Business",
      description:
          "Watch startups pitch their innovative ideas to a panel of investors and industry leaders.",
    ),
    Event(
      id: "5",
      title: "Health and Wellness Retreat",
      location: "Lakeview Resort, Colorado",
      date: "10/05/2025",
      time: "07:00 AM",
      organizerId: "org_005",
      organizerName: "Wellness Ventures",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Health",
      description:
          "A weekend retreat focused on mental and physical well-being with yoga, meditation, and workshops.",
    ),
  ];

  List<Event> eventsList = [
    Event(
      id: "1",
      title: "Tech Conference 2025",
      location: "Silicon Valley Convention Center",
      date: "10/01/2025",
      time: "09:00 AM",
      organizerId: "org_001",
      organizerName: "Tech Innovators Inc.",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Technology",
      description:
          "Join us for the largest tech conference of the year featuring keynotes, workshops, and networking opportunities.",
    ),
    Event(
      id: "2",
      title: "Music Festival",
      location: "Central Park, New York",
      date: "15/02/2025",
      time: "06:00 PM",
      organizerId: "org_002",
      organizerName: "Live Nation",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Music",
      description:
          "Experience live performances from top artists around the globe in an unforgettable musical event.",
    ),
    Event(
      id: "3",
      title: "Art Exhibition",
      location: "The Louvre, Paris",
      date: "05/03/2025",
      time: "10:00 AM",
      organizerId: "org_003",
      organizerName: "Art World Organization",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Art",
      description:
          "Discover the masterpieces of renowned and emerging artists at this exclusive art exhibition.",
    ),
    Event(
      id: "4",
      title: "Startup Pitch Night",
      location: "Downtown Business Hub, San Francisco",
      date: "20/04/2025",
      time: "05:00 PM",
      organizerId: "org_004",
      organizerName: "Venture Builders",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Business",
      description:
          "Watch startups pitch their innovative ideas to a panel of investors and industry leaders.",
    ),
    Event(
      id: "5",
      title: "Health and Wellness Retreat",
      location: "Lakeview Resort, Colorado",
      date: "10/05/2025",
      time: "07:00 AM",
      organizerId: "org_005",
      organizerName: "Wellness Ventures",
      thumbnail: "https://picsum.photos/seed/picsum/1024/768",
      category: "Health",
      description:
          "A weekend retreat focused on mental and physical well-being with yoga, meditation, and workshops.",
    ),
  ];

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
        automaticallyImplyLeading: true,
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          //Image Slider
          CarouselSlider(
            items: eventSliders,
            carouselController: slideController,
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.42,
                autoPlay: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
                // aspectRatio: 1.1,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  //
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
                return GestureDetector(
                  onTap: (() {
                    //Add on tap event
                  }),
                  child: EventCard(event: eventsList[index]),
                );
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
