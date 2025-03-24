import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/theme/theme.dart';

@RoutePage()
class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  final TextEditingController _searchController = TextEditingController();
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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body:  CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("Hairs&You"),
              snap: true,
              pinned: true,
              floating: true,
              centerTitle: true,
              surfaceTintColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: boxDecoration,
                  child: const Row(
                    children: [
                       Icon(Icons.search),
                       SizedBox(width: 12),
                      Text(
                        "Поиск заведений",
                      ),
                    ],
                  )
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.topLeft,
                        width: double.infinity,
                        height: 150,
                        decoration: boxDecoration,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Активная запись",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.green
                                  ),
                                ),
                                const Text(" 13.12.2043 12:13 "),
                              ],
                            ),
                             const Text(
                              "У марии",
                            ),
                            const Text(
                                "Санкт-Петербург, Каменноостровский проспект 30"
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Special Offers Title
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child:  Text(
                        'Специальные предложения',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Special Offers List (Horizontal Scroll)
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
                      padding:  const EdgeInsets.symmetric(horizontal: 16),
                      child:  Text(
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
                  ]
                )
              )
            )
          ],
        ),
    );
  }

  void _onOfferTapped(BuildContext context, Map<String, String> offer) {
    // Implement navigation or other actions when an offer is tapped.
    // For example, you can navigate to a new screen with offer details.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(offer['title'] ?? "Offer"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(offer['description'] ?? ""),
              const SizedBox(height: 8),
              Text(offer['address'] ?? ""),
              const SizedBox(height: 8),
              Image.asset(offer['image']!, width: 100, height: 100,)
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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