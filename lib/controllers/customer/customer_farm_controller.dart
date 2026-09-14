import 'package:get/get.dart';
import 'package:phum_kasikor/model/customer/farm_model.dart';
import 'package:phum_kasikor/model/customer/product_model.dart';
class CustomerFarmController extends GetxController {
  final selectedFarm = Rxn<FarmModel>();

  final isFollowing = false.obs;

  final farmProducts = <ProductModel>[
    ProductModel(
      id: '1',
      name: 'Fresh Jasmine Rice',
      image: 'assets/images/rice.jpg',
      farmName: "Sokha's Organic Farm",
      price: 2.50,
      unit: 'kg',
      rating: 4.8,
      reviewCount: 120,
    ),
    ProductModel(
      id: '2',
      name: 'Organic Morning Glory',
      image: 'assets/images/morning_glory.jpg',
      farmName: "Sokha's Organic Farm",
      price: 1.00,
      unit: 'bunch',
      rating: 4.8,
      reviewCount: 120,
    ),
    ProductModel(
      id: '3',
      name: 'Organic Dragon Fruit',
      image: 'assets/images/dragon_fruit.jpg',
      farmName: "Sokha's Organic Farm",
      price: 3.00,
      unit: 'kg',
      rating: 4.8,
      reviewCount: 120,
    ),
    ProductModel(
      id: '4',
      name: 'Kampot Black Pepper',
      image: 'assets/images/pepper.jpg',
      farmName: "Sokha's Organic Farm",
      price: 8.50,
      unit: 'jar',
      rating: 4.9,
      reviewCount: 86,
    ),
  ].obs;

  void setFarm(FarmModel farm) {
    selectedFarm.value = farm;
  }

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }

  void addProduct(ProductModel product) {
    Get.snackbar(
      'Added',
      '${product.name} added to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}