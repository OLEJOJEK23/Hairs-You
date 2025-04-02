import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/features/PrimaryScreen/widgets/ActiveRecordCard.dart';

import '../../../widgets/SearchWidget.dart';

@RoutePage()
class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen>
    with SingleTickerProviderStateMixin {
  final _activeRecord = false;
  final List<Map<String, String>> _specialOffers = [
    {
      'title': 'У Марии',
      "address": "Санкт-Петербург, Ленинский проспект 147",
      'description': 'Description for offer 1',
      'image': 'assets/images/google_logo.png' // Replace with actual asset path
    },
    {
      'title': 'Стрижка',
      "address": "Санкт-Петербург, Ленинский проспект 148",
      'description': 'Description for offer 2',
      'image': 'assets/images/google_logo.png' // Replace with actual asset path
    },
    {
      'title': 'Барбершоп',
      "address": "Санкт-Петербург, Ленинский проспект 149",
      'description': 'Description for offer 3',
      'image': 'assets/images/google_logo.png' // Replace with actual asset path
    },
    {
      'title': 'Подстирижися',
      "address": "Санкт-Петербург, Ленинский проспект 1410",
      'description': 'Description for offer 4',
      'image': 'assets/images/google_logo.png' // Replace with actual asset path
    }, // Add more offers as needed
  ];

  final List<Map<String, String>> _bestOffers = [
    {
      'title': 'Суперскидка',
      "address": "Санкт-Петербург, Невский проспект 10",
      'description': 'Лучшее предложение',
      'image': 'assets/images/google_logo.png'
    },
    {
      'title': 'Только сегодня!',
      "address": "Санкт-Петербург, Литейный проспект 20",
      'description': 'Скидка 50%',
      'image': 'assets/images/google_logo.png'
    },
    {
      'title': 'Эксклюзив',
      "address": "Санкт-Петербург, Каменноостровский проспект 30",
      'description': 'Лучшие мастера',
      'image': 'assets/images/google_logo.png'
    },
    {
      'title': 'Скидки 20%',
      "address": "Санкт-Петербург, Московский проспект 30",
      'description': 'Лучшие мастера',
      'image': 'assets/images/google_logo.png'
    },
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Hairs&You"),
            snap: true,
            pinned: true,
            floating: true,
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            backgroundColor: theme.scaffoldBackgroundColor,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SearchWidget(
                  establishments: _specialOffers,
                  onSearch: (_specialOffers) {},
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_activeRecord == false)
                    const ActiveRecordCard(
                      institutionName: "Барбершоп",
                      address: "Санкт-Петербург, Московский проспект 30",
                      visitDate: "10.12.2141 12:40",
                    ),
                  //* Special Offers Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Специальные предложения',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  //* Special Offers List (Horizontal Scroll)
                  SizedBox(
                    height: 250, // Adjust height as needed
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: _specialOffers.length,
                      itemBuilder: (context, index) {
                        final offer = _specialOffers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              // Handle tap on Special Offer
                              _onOfferTapped(context, offer);
                            },
                            child: OfferCard(
                              title: offer['title']!,
                              description: offer['description']!,
                              imagePath: offer['image']!,
                              address: offer['address']!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Лучшие предложения',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: _bestOffers.length,
                      itemBuilder: (context, index) {
                        final offer = _bestOffers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              _onOfferTapped(context, offer);
                            },
                            child: OfferCard(
                              title: offer['title']!,
                              description: offer['description']!,
                              imagePath: offer['image']!,
                              address: offer['address']!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onOfferTapped(BuildContext context, Map<String, String> offer) {
    context.router.pushNamed("/establishment");
  }
}

class OfferCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String address;

  const OfferCard({
    super.key,
    required this.title,
    required this.address,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: 150, // Adjust height as needed
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
