import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/categories/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarouselCategories extends ConsumerStatefulWidget {
  final List<Category> categories;
  const CarouselCategories({required this.categories, super.key});

  @override
  _CarouselCategoriesState createState() => _CarouselCategoriesState();
}

class _CarouselCategoriesState extends ConsumerState<CarouselCategories> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.categories.length,
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 1.3,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
      itemBuilder: (context, index, realIndex) {
        return Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.categories[index].image,
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                widget.categories[index].name, // Substitua isso pelo nome da categoria
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      });
  }
}
