import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hairs_and_you/api/domain/entities/review.dart';
import 'package:hairs_and_you/api/domain/entities/service.dart';
import 'package:hairs_and_you/api/domain/usecases/get_reviews.dart';
import 'package:hairs_and_you/api/domain/usecases/get_services.dart';
import 'package:hairs_and_you/features/EstablishmentScreen/widgets/DescriptionTab.dart';
import 'package:hairs_and_you/features/EstablishmentScreen/widgets/ReviewsTab.dart';
import 'package:hairs_and_you/features/EstablishmentScreen/widgets/ServicesTab.dart';
import 'package:hairs_and_you/widgets/ImageScroll.dart';
import 'package:hairs_and_you/widgets/RatingDisplay.dart';

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
  final GetServices _getServices = GetIt.I<GetServices>();
  bool _isReviewsLoading = false;
  bool _isServicesLoading = false;
  String? _reviewsError;
  String? _servicesError;

  final List<String> _imageUrls = [
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
  ];
  final String _establishmentName = "У марии";
  final String _establishmentAddress =
      "Солнечная улица, 27, Сосновый Бор, Ленинградская область";
  final double _establishmentRating = 3;
  final String _establishmentDescription =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit.";

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(_establishmentName),
            centerTitle: true,
            pinned: true,
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
                              _establishmentName,
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                          RatingDisplay(rating: _establishmentRating),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _establishmentAddress,
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
              description: _establishmentDescription,
            ),
            // Services Tab
            _isServicesLoading
                ? CircularProgressIndicator(
                    color: theme.primaryColor,
                  )
                : ServicesTab(
                    services: _services,
                  ),
            // Reviews Tab
            _isReviewsLoading
                ? CircularProgressIndicator(
                    color: theme.primaryColor,
                  )
                : ReviewsTab(
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
