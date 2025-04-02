import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/widgets/RatingDisplay.dart';

@RoutePage()
class EstablishmentScreen extends StatefulWidget {
  const EstablishmentScreen({super.key});

  @override
  State<EstablishmentScreen> createState() => _EstablishmentScreenState();
}

class _EstablishmentScreenState extends State<EstablishmentScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;
  int _currentPage = 0;
  bool _isExpanded = false;

  final List<String> _imageUrls = [
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
    'assets/images/google_logo.png',
  ];
  final String _establishmentName = "Название заведения";
  final String _establishmentAddress =
      "Солнечная улица, 27, Сосновый Бор, Ленинградская область";
  final double _establishmentRating = 3;
  final String _establishmentDescription =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit.";

  // Sample reviews
  final List<Map<String, dynamic>> _reviews = [
    {
      'author': 'Алексей П.',
      'rating': 4.5,
      'text': 'Отличное место! Еда вкусная, персонал дружелюбный. Рекомендую!',
      'date': '01.04.2025'
    },
    {
      'author': 'Мария К.',
      'rating': 5.0,
      'text': 'Лучший сервис в городе, вернемся еще не раз!',
      'date': '30.03.2025'
    },
    {
      'author': 'Дмитрий С.',
      'rating': 4.0,
      'text': 'Хорошая атмосфера, но цены немного высокие.',
      'date': '28.03.2025'
    },
    {
      'author': 'Елена В.',
      'rating': 3.5,
      'text': 'Неплохо, но обслуживание могло бы быть быстрее.',
      'date': '25.03.2025'
    },
    {
      'author': 'Игорь М.',
      'rating': 4.8,
      'text': 'Прекрасное место для ужина с семьей!',
      'date': '20.03.2025'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(_establishmentName),
            centerTitle: true,
            pinned: true,
            surfaceTintColor: Colors.transparent,
            backgroundColor: theme.scaffoldBackgroundColor,
          ),
          // Photos
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    itemCount: _imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _imageUrls[index],
                        fit: BoxFit.contain,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _imageUrls.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? theme.primaryColor
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Name, address, and tab bar
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _establishmentName,
                      style: theme.textTheme.titleLarge,
                    ),
                    RatingDisplay(
                      rating: _establishmentRating,
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _establishmentAddress,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                // TabBar
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Описание'),
                    Tab(text: 'Отзывы'),
                  ],
                  labelColor: theme.primaryColor,
                  unselectedLabelColor: Colors.grey[500],
                  indicatorColor: theme.primaryColor,
                ),
                const SizedBox(height: 16),
                // TabBarView content
                SizedBox(
                  height: 600, // Adjust height as needed
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Description Tab
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSize(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                              child: Text(
                                _establishmentDescription,
                                style: theme.textTheme.bodyMedium,
                                maxLines: _isExpanded ? null : 5,
                                overflow: _isExpanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    _isExpanded
                                        ? "Скрыть"
                                        : "Показать полностью",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                  Icon(
                                    _isExpanded
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: theme.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Reviews Tab
                      SingleChildScrollView(
                        child: Column(
                          children: _reviews
                              .map(
                                (review) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            review['author'],
                                            style: theme.textTheme.titleMedium,
                                          ),
                                          Row(
                                            children: [
                                              RatingDisplay(
                                                rating: review["rating"],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        review['text'],
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        review['date'],
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
