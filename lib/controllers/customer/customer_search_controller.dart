import 'package:get/get.dart';
import 'package:phum_kasikor/model/customer/product_model.dart';


class CustomerSearchController extends GetxController {
  final searchQuery = ''.obs;

  final minPrice = 0.0.obs;
  final maxPrice = 50.0.obs;

  final selectedCategory = 'Organic'.obs;

  final products = <ProductModel>[
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
      name: 'Fresh Water Spinach',
      image: 'assets/images/water_spinach.jpg',
      farmName: 'Prek Leap Eco Farm',
      price: 0.90,
      unit: 'bunch',
      rating: 4.6,
      reviewCount: 80,
    ),
    ProductModel(
      id: '3',
      name: 'Organic Dragon Fruit',
      image: 'assets/images/dragon_fruit.jpg',
      farmName: "Sokha's Organic Farm",
      price: 3.00,
      unit: 'kg',
      rating: 4.8,
      reviewCount: 110,
    ),
  ].obs;

  List<ProductModel> get filteredProducts {
    return products.where((product) {
      final matchesSearch = product.name
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase());

      final matchesPrice =
          product.price >= minPrice.value &&
          product.price <= maxPrice.value;

      return matchesSearch && matchesPrice;
    }).toList();
  }

  void search(String value) {
    searchQuery.value = value;
  }

  void setPriceRange(double min, double max) {
    minPrice.value = min;
    maxPrice.value = max;
  }

  void clearFilters() {
    searchQuery.value = '';
    minPrice.value = 0;
    maxPrice.value = 50;
    selectedCategory.value = 'Organic';
  }
}