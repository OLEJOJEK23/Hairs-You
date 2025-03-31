import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EstablishmentScreen extends StatefulWidget {
  const EstablishmentScreen({super.key});

  @override
  State<EstablishmentScreen> createState() => _EstablishmentScreenState();
}

class _EstablishmentScreenState extends State<EstablishmentScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isExpanded = false; // Track whether the description is expanded

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
  final double _establishmentRating = 4.5;
  final String _establishmentDescription =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit.";

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
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
            snap: true,
            floating: true,
            surfaceTintColor: Colors.transparent,
            backgroundColor: theme.scaffoldBackgroundColor,
          ),
          //* photos
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
          //* name, description
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(
              children: [
                // Establishment Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _establishmentName,
                      style: theme.textTheme.titleLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          _establishmentRating.toString(),
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _establishmentAddress,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),

                const SizedBox(height: 16),
                // Collapsible Description
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _establishmentDescription,
                      style: theme.textTheme.bodyMedium,
                      maxLines: _isExpanded ? null : 5,
                      // Limit lines when collapsed
                      overflow: _isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.fade,
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            _isExpanded ? "Скрыть" : "Показать полностью ",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
