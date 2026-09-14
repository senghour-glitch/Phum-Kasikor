import 'package:get/get.dart';
import 'package:phum_kasikor/model/customer_product_detail_model.dart';
import 'package:phum_kasikor/model/product_model.dart';

class CustomerProductDetailController extends GetxController {
  CustomerProductDetailController({CustomerProductDetailModel? detail})
    : detail = (detail ?? _sampleDetail).obs;

  final Rx<CustomerProductDetailModel> detail;
  final quantity = 1.obs;
  final isFavorite = false.obs;

  bool get canDecrease => quantity.value > detail.value.minimumOrder;
  double get totalPrice => detail.value.product.price * quantity.value;

  void increaseQuantity() {
    if (quantity.value < detail.value.product.stock) quantity.value++;
  }

  void decreaseQuantity() {
    if (canDecrease) quantity.value--;
  }

  void toggleFavorite() => isFavorite.toggle();

  void addToCart() {
    final product = detail.value.product;
    Get.snackbar(
      'Added to cart',
      '${quantity.value} ${product.unit} of ${product.name} added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static final _sampleDetail = CustomerProductDetailModel(
    product: ProductModel(
      id: 'jasmine-rice-1',
      farmId: 'sokha-organic-farm',
      name: 'Fresh Jasmine Rice',
      price: 2.50,
      unit: 'kg',
      stock: 125,
      description:
          'Premium organic Jasmine Rice harvested straight from fertile floodplains of Kandal. Carefully grown using ancestral organic pesticide-free methods. High fragrance and beautifully soft texture when cooked.',
    ),
    farmName: "Sokha's Organic Farm",
    rating: 4.8,
    ratingsCount: 24,
    origin: 'Kandal Province',
    method: '100% Organic',
    harvest: 'Jul 2024',
    minimumOrder: 1,
    reviews: [
      ProductReviewModel(
        name: 'Sopheap N.',
        rating: 5,
        comment:
            'The fragrance is incredibly fresh, soft texture is absolutely perfect when cooked! Will buy weekly.',
      ),
      ProductReviewModel(
        name: 'Kantha S.',
        rating: 4,
        comment:
            'Very authentic Phka Rumduol rice. Extremely clean and fast delivery from Kandal.',
      ),
    ],
  );
}
