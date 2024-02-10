// import 'package:flutter/material.dart';
// import 'package:flutter_blog_app/features/categories/category_model.dart';
// import 'package:flutter_blog_app/features/categories/widget/carousel_categories_widget.dart';
// import 'package:flutter_blog_app/features/categories/widget/skeleton_loading_carousel_categories.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class PreloadCarousel extends ConsumerStatefulWidget {
//   final List<Category>? categories;
//   final dynamic isAllLoading;

//   const PreloadCarousel({required this.categories, required this.isAllLoading, Key? key}) : super(key: key);

//   @override
//   _PreloadImagesState createState() => _PreloadImagesState();
// }

// class _PreloadImagesState extends ConsumerState<PreloadCarousel> {
//   late List<ImageProvider> _imageProviders;

//   @override
//   void initState() {
//     super.initState();
//     _imageProviders = widget.categories!.map((category) => NetworkImage(category.image)).toList();
//     _preloadImages();
//   }

//   Future<void> _preloadImages() async {
//     await Future.wait(_imageProviders.map((provider) => precacheImage(provider, context)));
//     if (mounted) {
//       setState(() {}); // Atualiza o estado para reconstruir o widget com as imagens pré-carregadas
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.isAllLoading ? const SkeletonLoadingCarouselCategories() : CarouselCategories(categories: widget.categories!, imageProviders: _imageProviders);
//   }
// }