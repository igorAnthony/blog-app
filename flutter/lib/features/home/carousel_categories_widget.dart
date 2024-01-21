import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/features/categories/category_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarouselCategories extends ConsumerWidget {
  CarouselCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesStoreProvider);

    return categories.when(data: (data) {
      return CarouselSlider.builder(
          itemCount: data.length,
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
                      data[index].image,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    data[index].name, // Substitua isso pelo nome da categoria
                    style: TextStyle(
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
          },
          options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 1.3,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ));
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, error: (error, stack) {
      return const Center(
        child: Text('Error'),
      );
    });
  }
}
