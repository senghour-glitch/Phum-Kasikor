import 'package:get/get.dart';

import '../model/crop_model.dart';
import '../model/product_model.dart';

class FarmerController extends GetxController {
  final crops = <CropModel>[
    CropModel(
      id: 'crop-1',
      farmId: 'farm-1',
      name: 'Jasmine Rice',
      plantedAt: DateTime(2026, 8, 12),
      expectedHarvestAt: DateTime(2026, 11, 20),
    ),
    CropModel(
      id: 'crop-2',
      farmId: 'farm-1',
      name: 'Organic Morning Glory',
      plantedAt: DateTime(2026, 8, 28),
      expectedHarvestAt: DateTime(2026, 10, 4),
    ),
  ].obs;

  final products = <ProductModel>[
    const ProductModel(id: 'product-1', farmId: 'farm-1', name: 'Premium Jasmine Rice', price: 2.50, unit: 'kg', stock: 125, categoryId: 'grains'),
    const ProductModel(id: 'product-2', farmId: 'farm-1', name: 'Organic Morning Glory', price: 1.00, unit: 'bunch', stock: 40, categoryId: 'vegetables'),
    const ProductModel(id: 'product-3', farmId: 'farm-1', name: 'Fresh Mangoes', price: 3.00, unit: 'kg', stock: 28, categoryId: 'fruits'),
    const ProductModel(id: 'product-4', farmId: 'farm-1', name: 'Seasonal Vegetables', price: 1.50, unit: 'kg', stock: 0, categoryId: 'vegetables', isAvailable: false),
  ].obs;
  final orders = <FarmerOrder>[
    const FarmerOrder(
      id: 'ORD-1024',
      customer: 'Dara Sovan',
      total: 16.50,
      status: 'New',
      itemCount: 2,
    ),
    const FarmerOrder(
      id: 'ORD-1023',
      customer: 'Srey Mom',
      total: 8.00,
      status: 'Preparing',
      itemCount: 1,
    ),
    const FarmerOrder(
      id: 'ORD-1022',
      customer: 'Buntha Chea',
      total: 24.00,
      status: 'Ready',
      itemCount: 3,
    ),
  ].obs;

  void addCrop({
    required String name,
    required DateTime plantedAt,
    required DateTime expectedHarvestAt,
  }) {
    crops.insert(
      0,
      CropModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        farmId: 'farm-1',
        name: name,
        plantedAt: plantedAt,
        expectedHarvestAt: expectedHarvestAt,
      ),
    );
  }

  void addProduct({
    required String name,
    required double price,
    required int stock,
    required String unit,
    required String description,
  }) {
    products.insert(
      0,
      ProductModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        farmId: 'farm-1',
        name: name,
        price: price,
        stock: stock,
        unit: unit,
        description: description,
      ),
    );
  }

  void advanceOrder(FarmerOrder order) {
    const stages = ['New', 'Preparing', 'Ready', 'Completed'];
    final index = stages.indexOf(order.status);
    if (index >= stages.length - 1) return;
    final replacement = order.copyWith(status: stages[index + 1]);
    orders[orders.indexWhere((item) => item.id == order.id)] = replacement;
  }
}

class FarmerOrder {
  const FarmerOrder({
    required this.id,
    required this.customer,
    required this.total,
    required this.status,
    required this.itemCount,
  });
  final String id;
  final String customer;
  final double total;
  final String status;
  final int itemCount;
  FarmerOrder copyWith({String? status}) => FarmerOrder(
    id: id,
    customer: customer,
    total: total,
    status: status ?? this.status,
    itemCount: itemCount,
  );
}
