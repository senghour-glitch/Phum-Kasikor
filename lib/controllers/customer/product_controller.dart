import 'package:get/get.dart';
import 'package:phum_kasikor/model/customer/product_model.dart';

class ProductController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;

  final RxString selectedCategory = 'All'.obs;

  final RxString searchText = ''.obs;

  final List<String> categories = ['All', 'Vegetables', 'Fruits', 'Grains'];

  final Map<String, String> _categoryByProductId = {};

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    _categoryByProductId
      ..clear()
      ..addAll({
        'p001': 'Grains',
        'p002': 'Vegetables',
        'p003': 'Vegetables',
        'p004': 'Fruits',
        'p005': 'Grains',
        'p006': 'Grains',
      });

    products.assignAll([
      ProductModel(
        id: 'p001',
        name: 'Fresh Jasmine Rice',
        farmName: "Sokha's Organic Farm",
        image: 'assets/images/rice.jpg',
        price: 2.50,
        unit: 'kg',
        rating: 4.8,
        reviewCount: 24,
      ),

      ProductModel(
        id: 'p002',
        name: 'Organic Morning Glory',
        farmName: "Sokha's Organic Farm",
        image: 'assets/images/morning_glory.jpg',
        price: 1.00,
        unit: 'bunch',
        rating: 4.7,
        reviewCount: 18,
      ),

      ProductModel(
        id: 'p003',
        name: 'Water Spinach',
        farmName: "Sokha's Organic Farm",
        image: 'assets/images/water_spinach.jpg',
        price: 0.90,
        unit: 'bunch',
        rating: 4.6,
        reviewCount: 12,
      ),

      ProductModel(
        id: 'p004',
        name: 'Organic Dragon Fruit',
        farmName: "Sokha's Organic Farm",
        image: 'assets/images/dragon_fruit.jpg',
        price: 3.00,
        unit: 'kg',
        rating: 4.9,
        reviewCount: 31,
      ),

      ProductModel(
        id: 'p005',
        name: 'Pure Palm Sugar',
        farmName: "Sokha's Organic Farm",
        image: 'assets/images/palm_sugar.jpg',
        price: 5.00,
        unit: 'kg',
        rating: 4.8,
        reviewCount: 20,
      ),

      ProductModel(
        id: 'p006',
        name: 'Kampot Pepper',
        farmName: "Sokha's Organic Farm",
        image: 'assets/images/pepper.jpg',
        price: 8.50,
        unit: 'kg',
        rating: 4.9,
        reviewCount: 42,
      ),
    ]);
  }

  List<ProductModel> get filteredProducts {
    List<ProductModel> result = products.toList();

    // Category filter
    if (selectedCategory.value != 'All') {
      result = result.where((product) {
        return _categoryByProductId[product.id] == selectedCategory.value;
      }).toList();
    }

    // Search filter
    final keyword = searchText.value.trim().toLowerCase();

    if (keyword.isNotEmpty) {
      result = result.where((product) {
        return product.name.toLowerCase().contains(keyword) ||
            (_categoryByProductId[product.id] ?? '').toLowerCase().contains(
              keyword,
            ) ||
            product.farmName.toLowerCase().contains(keyword);
      }).toList();
    }

    return result;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void search(String value) {
    searchText.value = value;
  }

  void clearSearch() {
    searchText.value = '';
  }

  void resetFilter() {
    selectedCategory.value = 'All';
    searchText.value = '';
  }

  // =====================================================
  // GET PRODUCT BY ID
  // =====================================================

  ProductModel? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
