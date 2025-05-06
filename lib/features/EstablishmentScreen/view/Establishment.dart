import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/review.dart';
import 'package:hairs_and_you/api/domain/entities/salon.dart';
import 'package:hairs_and_you/api/domain/entities/service.dart';
import 'package:hairs_and_you/api/domain/usecases/get_reviews.dart';
import 'package:hairs_and_you/api/domain/usecases/get_salon.dart';
import 'package:hairs_and_you/api/domain/usecases/get_services.dart';
import 'package:hairs_and_you/features/EstablishmentScreen/widgets/DescriptionTab.dart';
import 'package:hairs_and_you/features/EstablishmentScreen/widgets/ReviewsTab.dart';
import 'package:hairs_and_you/features/EstablishmentScreen/widgets/ServicesTab.dart';
import 'package:hairs_and_you/widgets/ImageScroll.dart';
import 'package:hairs_and_you/widgets/RatingDisplay.dart';
import 'package:intl/intl.dart';

@RoutePage()
class EstablishmentScreen extends StatefulWidget {
  const EstablishmentScreen({super.key, @PathParam('id') required this.id});

  final String id;

  @override
  State<EstablishmentScreen> createState() => _EstablishmentScreenState();
}

class _EstablishmentScreenState extends State<EstablishmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  final GetReviews _getReviews = GetIt.I<GetReviews>();
  final GetSalons _getSalons = GetIt.I<GetSalons>();
  final GetServices _getServices = GetIt.I<GetServices>();
  bool _isReviewsLoading = false;
  bool _isSalonLoading = false;
  bool _isServicesLoading = false;
  bool favorite = false;
  String? _reviewsError;
  String? _salonError;
  String? _servicesError;

  final List<String> _imageUrls = [
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
  ];
  late Salon _salon;
  List<Review> _reviews = [];
  List<Services> _services = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _scrollToTop();
      }
    });
    _fetchReviews();
    _fetchServices();
    _fetchSalon();
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm', 'ru_RU').format(dateTime);
  }

  Future<void> _fetchReviews() async {
    setState(() {
      _isReviewsLoading = true;
      _reviewsError = null;
    });
    final result = await _getReviews(salonID: widget.id);
    result.fold(
      (failure) => setState(() {
        _reviewsError = failure.message;
        _isReviewsLoading = true;
      }),
      (reviews) => setState(() {
        _reviews = reviews;
        _isReviewsLoading = false;
      }),
    );
    if (_reviewsError != null) {
      print(_reviewsError);
    }
  }

  Future<void> _fetchServices() async {
    setState(() {
      _isServicesLoading = true;
      _servicesError = null;
    });
    final result = await _getServices(salonID: widget.id);
    result.fold(
      (failure) => setState(() {
        _servicesError = failure.message;
        _isServicesLoading = true;
      }),
      (services) => setState(() {
        _services = services;
        _isServicesLoading = false;
      }),
    );
    if (_servicesError != null) {
      print(_servicesError);
    }
  }

  Future<void> _fetchSalon() async {
    setState(() {
      _isSalonLoading = true;
      _salonError = null;
    });
    final result = await _getSalons(salonID: widget.id);
    result.fold(
      (failure) => setState(() {
        _salonError = failure.message;
        _isSalonLoading = true;
      }),
      (salon) => setState(() {
        _salon = salon[0];
        _isSalonLoading = false;
      }),
    );
    if (_salonError != null) {
      print(_salonError);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _toggleFavorite(int index) {
    setState(() {
      favorite = !favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _isSalonLoading || _isServicesLoading || _isReviewsLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            )
          : NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  title: Text(_salon.name),
                  centerTitle: true,
                  pinned: true,
                  actions: [
                    IconButton(
                      icon: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                        color: favorite
                            ? Colors.redAccent
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () => _toggleFavorite(1),
                    ),
                  ],
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: theme.scaffoldBackgroundColor,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ImageScroll(
                        imageUrls: _imageUrls,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _salon.name,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ),
                                RatingDisplay(rating: _salon.rating),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${_salon.cityName}, ${_salon.streetAddress}",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: 'Описание',
                        ),
                        Tab(
                          text: 'Услуги',
                        ),
                        Tab(
                          text: 'Отзывы',
                        ),
                      ],
                      labelColor: theme.primaryColor,
                      unselectedLabelColor: Colors.grey.shade500,
                      indicatorColor: theme.primaryColor,
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  // Description Tab
                  DescriptionTab(
                    startTime: formatTimeOfDay(_salon.startTime),
                    endTime: formatTimeOfDay(_salon.endTime),
                    description: _salon.description,
                  ),
                  // Services Tab
                  ServicesTab(
                    services: _services,
                  ),
                  // Reviews Tab
                  ReviewsTab(
                    reviews: _reviews,
                  ),
                ],
              ),
            ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return _tabBar != oldDelegate._tabBar;
  }
}
