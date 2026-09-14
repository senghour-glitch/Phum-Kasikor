import 'package:get/get.dart';
import 'package:phum_kasikor/model/customer/category_model.dart';
import 'package:phum_kasikor/model/customer/farm_model.dart';
import 'package:phum_kasikor/model/customer/product_model.dart';

class CustomerHomeController extends GetxController {
  // Current category
  final selectedCategory = 'All'.obs;

  // Categories
  final categories = <CategoryModel>[
    CategoryModel(
      name: 'Vegetables',
      icon: '🥬',
      image: 'assets/images/vegetables.jpg',
    ),
    CategoryModel(
      name: 'Fruits',
      icon: '🍎',
      image: 'assets/images/fruits.jpg',
    ),
    CategoryModel(
      name: 'Rice',
      icon: '🌾',
      image: 'assets/images/rice.jpg',
    ),
    CategoryModel(
      name: 'Herbs',
      icon: '🌿',
      image: 'assets/images/herbs.jpg',
    ),
  ].obs;

  // Featured farms
  final featuredFarms = <FarmModel>[
    FarmModel(
      id: '1',
      name: "Sokha's Organic Farm",
      image: 'assets/images/farm1.jpg',
      location: 'Kandal Province',
      rating: 4.8,
      reviews: 156,
      followers: 89,
      distance: 2.3,
    ),
    FarmModel(
      id: '2',
      name: 'Battambang Sweet Farm',
      image: 'assets/images/farm2.jpg',
      location: 'Battambang',
      rating: 4.7,
      reviews: 98,
      followers: 65,
      distance: 4.5,
    ),
  ].obs;

  // Fresh products
  final freshProducts = <ProductModel>[
    ProductModel(
      id: '1',
      name: 'Organic Morning Glory',
      image: 'assets/images/morning_glory.jpg',
      farmName: "Sokha's Organic Farm",
      price: 1.00,
      unit: 'bunch',
      rating: 4.8,
      reviewCount: 120,
    ),
    ProductModel(
      id: '2',
      name: 'Kampot Black Pepper',
      image: 'assets/images/pepper.jpg',
      farmName: 'Kampot Farm',
      price: 8.50,
      unit: 'jar',
      rating: 4.9,
      reviewCount: 86,
    ),
  ].obs;

  final isLoading = false.obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  Future<void> refreshHome() async {
    isLoading.value = true;

    await Future.delayed(
      const Duration(seconds: 1),
    );

    isLoading.value = false;
  }
}