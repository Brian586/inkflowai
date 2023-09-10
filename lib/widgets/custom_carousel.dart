import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inkflowai/models/activity.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        CarouselSlider(
            items: List.generate(activities.length, (index) {
              Activity activity = activities[index];

              return CarouselCard(activity: activity);
            }),
            options: CarouselOptions(
              height: size.height * 0.3,
              // aspectRatio: 16 / 9,
              viewportFraction: 0.98,
              initialPage: 1,
              enableInfiniteScroll: true,
              // reverse: false,
              // autoPlay: true,
              // autoPlayInterval: Duration(seconds: 3),
              // autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) {
                setState(() {
                  selectedIndex = index;
                });
              },
              scrollDirection: Axis.horizontal,
            )),
        SizedBox(
          height: 20.0,
          width: size.width,
          child: CarouselDotsIndicator(selectedIndex: selectedIndex),
        ),
      ],
    );
  }
}

class CarouselCard extends StatelessWidget {
  final Activity activity;
  const CarouselCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    int red = activity.rgbColor![0];
    int green = activity.rgbColor![1];
    int blue = activity.rgbColor![2];

    Color color = Color.fromRGBO(red, green, blue, 1.0);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "assets/images/${activity.cardImage}",
                  height: size.height * 0.3,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10.0)),
                      gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.0)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: ListTile(
                  leading: Card(
                      surfaceTintColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Image.asset(
                        "assets/images/${activity.image}.png",
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.contain,
                      )),
                  title: Text(
                    activity.title!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    activity.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white60),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class CarouselDotsIndicator extends StatelessWidget {
  final int selectedIndex;
  const CarouselDotsIndicator({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(activities.length, (index) {
          Activity activity = activities[index];
          bool isSelected = index == selectedIndex;

          int red = activity.rgbColor![0];
          int green = activity.rgbColor![1];
          int blue = activity.rgbColor![2];

          Color color = Color.fromRGBO(red, green, blue, 1.0);

          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: AnimatedContainer(
              height: 7.0,
              width: isSelected ? 12.0 : 7.0,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.5),
                  color: isSelected ? color : Colors.grey.shade400),
            ),
          );
        }),
      ),
    );
  }
}
