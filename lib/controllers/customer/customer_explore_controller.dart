import 'package:get/get.dart';
import 'package:phum_kasikor/model/customer/product_model.dart';
class CustomerExploreController extends GetxController {
  final searchText = ''.obs;

  final selectedCategory = 'All'.obs;

  final categories = [
    'All',
    'Vegetables',
    'Fruits',
    'Rice',
    'Herbs',
    'Dairy',
    'Organic',
    'Spices',
  ];

  final popularProducts = <ProductModel>[
    ProductModel(
      id: '1',
      name: 'Organic Dragon Fruit',
      image: 'assets/images/dragon_fruit.jpg',
      farmName: "Sokha's Organic Farm",
      price: 3.00,
      unit: 'kg',
      rating: 4.8,
      reviewCount: 110,
    ),
    ProductModel(
      id: '2',
      name: 'Pure Palm Sugar',
      image: 'assets/images/palm_sugar.jpg',
      farmName: 'Kampong Speu Farm',
      price: 5.00,
      unit: 'jar',
      rating: 4.7,
      reviewCount: 74,
    ),
  ].obs;

  void updateSearch(String value) {
    searchText.value = value;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }
}