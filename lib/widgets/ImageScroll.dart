import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hairs_and_you/api/domain/entities/photo.dart';

class ImageScroll extends StatefulWidget {
  final List<Photo> imageUrls;

  const ImageScroll({super.key, required this.imageUrls});

  @override
  State<ImageScroll> createState() => _ImageScrollState();
}

class _ImageScrollState extends State<ImageScroll> {
  final PageController _pageController =
      PageController(initialPage: 1); // Начинаем с 1
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = (_pageController.page?.round() ?? 1) -
            1; // Корректируем для индикатора
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange(int page) {
    if (page == 0) {
      // Переход с первой страницы на последнюю
      Future.delayed(const Duration(milliseconds: 200), () {
        _pageController.animateToPage(
          widget.imageUrls.length,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      });
    } else if (page == widget.imageUrls.length + 1) {
      // Переход с последней страницы на первую
      Future.delayed(const Duration(milliseconds: 200), () {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      });
    }
    setState(() {
      _currentPage = (page - 1)
          .clamp(0, widget.imageUrls.length - 1); // Ограничиваем для индикатора
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: widget.imageUrls.length + 2,
            // Добавляем 2 фиктивных элемента
            itemBuilder: (context, index) {
              if (index == 0 || index == widget.imageUrls.length + 1) {
                // Фиктивные элементы для перехода
                return const SizedBox.shrink();
              }
              return CachedNetworkImage(
                imageUrl: widget.imageUrls[index - 1].photoURL,
                // Сдвигаем индекс из-за фиктивного начала
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
            onPageChanged: _handlePageChange,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imageUrls.length,
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
    );
  }
}
