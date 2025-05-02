import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/shortSalon.dart';
import 'package:hairs_and_you/api/domain/entities/special_offer.dart';
import 'package:hairs_and_you/api/domain/usecases/get_short_salons.dart';
import 'package:hairs_and_you/api/domain/usecases/get_special_offers.dart';
import 'package:hairs_and_you/features/PrimaryScreen/widgets/ActiveRecordCard.dart';
import 'package:hairs_and_you/widgets/RatingDisplay.dart';

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
  final GetShortSalons _getShortSalons = GetIt.I<GetShortSalons>();
  final GetSpecialOffers _getSpecialOffers = GetIt.I<GetSpecialOffers>();
  List<ShortSalon> _bestOffers = [];
  List<SpecialOffer> _specialOffers = [];
  bool _isSalonsLoading = false;
  String? _salonsError;
  bool _isOffersLoading = false;
  String? _offersError;

  @override
  void initState() {
    super.initState();
    _fetchSalons();
    _fetchSpecialOffers();
  }

  Future<void> _fetchSalons() async {
    setState(() {
      _isSalonsLoading = true;
      _salonsError = null;
    });
    final result = await _getShortSalons(
      sortBy: "rating",
    );
    result.fold(
      (failure) => setState(() {
        _salonsError = failure.message;
        _isSalonsLoading = true;
      }),
      (services) => setState(() {
        _bestOffers = services;
        _isSalonsLoading = false;
      }),
    );
    if (_salonsError != null) {
      print(_salonsError);
    }
  }

  Future<void> _fetchSpecialOffers() async {
    setState(() {
      _isOffersLoading = true;
      _offersError = null;
    });
    final result = await _getSpecialOffers();
    result.fold(
      (failure) => setState(() {
        _offersError = failure.message;
        _isOffersLoading = true;
      }),
      (offers) => setState(() {
        _specialOffers = offers;
        _isOffersLoading = false;
      }),
    );
    if (_offersError != null) {
      print(_offersError);
    }
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
                  establishments: _bestOffers,
                  onSearch: (_bestOffers) {},
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
                    ActiveRecordCard(
                      institutionName: "Барбершоп",
                      address: "Санкт-Петербург, Московский проспект 30",
                      visitDate: "10.12.2141 12:40",
                      onTap: () {},
                    ),
                  //* Special Offers Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Лучшие предложения',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  //* Special Offers List (Horizontal Scroll)
                  _isSalonsLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: theme.primaryColor),
                        )
                      : SizedBox(
                          height: 250, // Adjust height as needed
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _bestOffers.length,
                            itemBuilder: (context, index) {
                              final offer = _bestOffers[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    _onOfferTapped(context, offer.id);
                                  },
                                  child: OfferCard(
                                    title: offer.name,
                                    description: offer.description,
                                    imagePath: "assets/images/google_logo.png",
                                    address: offer.address,
                                    rating: offer.rating,
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
                      'Специальные предложения',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isOffersLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: theme.primaryColor),
                        )
                      : SizedBox(
                          height: 250,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _specialOffers.length,
                            itemBuilder: (context, index) {
                              final offer = _specialOffers[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: OfferCard(
                                    title: offer.title,
                                    description: offer.description,
                                    imagePath: "assets/images/google_logo.png",
                                    address: offer.address,
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

  void _onOfferTapped(BuildContext context, String id) {
    context.router.pushNamed("/establishment/$id");
  }
}

class OfferCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String address;
  final double? rating;

  const OfferCard({
    super.key,
    required this.title,
    required this.address,
    required this.description,
    required this.imagePath,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 150, // Adjust height as needed
                fit: BoxFit.contain,
              ),
              rating == null ? const SizedBox() : RatingDisplay(rating: rating!)
            ],
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
