import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/controllers/customer/product_detail_controller.dart';
import 'package:phum_kasikor/model/customer_product_detail_model.dart';

class CustomerProductDeteilScreen extends StatelessWidget {
  const CustomerProductDeteilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerProductDetailController());

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBF8),
      body: SafeArea(
        child: Obx(() {
          final detail = controller.detail.value;
          return Column(
            children: [
              _Header(controller: controller),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _RiceHero(),
                      const SizedBox(height: 18),
                      _ProductInformation(detail: detail),
                      const SizedBox(height: 12),
                      _Panel(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Description', style: _TextStyles.title),
                            const SizedBox(height: 7),
                            Text(
                              detail.product.description,
                              style: _TextStyles.body,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _Panel(
                        child: Column(
                          children: [
                            _DetailRow('Origin', detail.origin),
                            const Divider(height: 17),
                            _DetailRow('Method', detail.method),
                            const Divider(height: 17),
                            _DetailRow('Harvest', detail.harvest),
                            const Divider(height: 17),
                            _DetailRow(
                              'Min Order',
                              '${detail.minimumOrder} ${detail.product.unit}',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Reviews (${detail.ratingsCount})',
                        style: _TextStyles.title,
                      ),
                      const SizedBox(height: 9),
                      ...detail.reviews.map(
                        (review) => Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: _ReviewCard(review: review),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _CartBar(controller: controller),
            ],
          );
        }),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.controller});
  final CustomerProductDetailController controller;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
    child: Row(
      children: [
        _RoundIcon(icon: Icons.arrow_back_ios_new_rounded, onTap: Get.back),
        const Spacer(),
        const _RoundIcon(icon: Icons.share_outlined),
        const SizedBox(width: 10),
        _RoundIcon(
          icon: controller.isFavorite.value
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          iconColor: controller.isFavorite.value
              ? AppColors.error
              : AppColors.textPrimary,
          onTap: controller.toggleFavorite,
        ),
      ],
    ),
  );
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, this.iconColor, this.onTap});
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    shape: const CircleBorder(side: BorderSide(color: AppColors.border)),
    child: InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: SizedBox(
        width: 34,
        height: 34,
        child: Icon(icon, size: 17, color: iconColor),
      ),
    ),
  );
}

class _RiceHero extends StatelessWidget {
  const _RiceHero();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E3D7),
          borderRadius: BorderRadius.circular(17),
        ),
        child: const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(17)),
          child: CustomPaint(painter: _RicePainter()),
        ),
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _PageDot(active: true),
          SizedBox(width: 5),
          _PageDot(),
          SizedBox(width: 5),
          _PageDot(),
        ],
      ),
    ],
  );
}

class _PageDot extends StatelessWidget {
  const _PageDot({this.active = false});
  final bool active;

  @override
  Widget build(BuildContext context) => Container(
    width: active ? 7 : 5,
    height: active ? 7 : 5,
    decoration: BoxDecoration(
      color: active ? AppColors.primary : const Color(0xFF9CAEB0),
      shape: BoxShape.circle,
    ),
  );
}

class _ProductInformation extends StatelessWidget {
  const _ProductInformation({required this.detail});
  final CustomerProductDetailModel detail;

  @override
  Widget build(BuildContext context) => _Panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: _TextStyles.productName,
            children: [
              TextSpan(text: '${detail.product.name} '),
              TextSpan(
                text: '${detail.rating} ★',
                style: const TextStyle(color: Color(0xFFF59B23), fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'by ${detail.farmName} ✓',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    '\$${detail.product.price.toStringAsFixed(2)} / ${detail.product.unit}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              const TextSpan(
                text: '  (10,000៛/kg)',
                style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(label, style: _TextStyles.label),
      const Spacer(),
      Text(value, style: _TextStyles.value),
    ],
  );
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final ProductReviewModel review;

  @override
  Widget build(BuildContext context) => _Panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: const Color(0xFFDAB7A5),
              child: Text(
                review.initials,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(review.name, style: _TextStyles.value),
            const Spacer(),
            Text(
              '${review.rating} ★',
              style: const TextStyle(
                color: Color(0xFFF58F1F),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(review.comment, style: _TextStyles.body),
      ],
    ),
  );
}

class _CartBar extends StatelessWidget {
  const _CartBar({required this.controller});
  final CustomerProductDetailController controller;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: AppColors.border)),
    ),
    child: Row(
      children: [
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              _QuantityButton(
                icon: Icons.remove,
                onTap: controller.canDecrease
                    ? controller.decreaseQuantity
                    : null,
              ),
              SizedBox(
                width: 24,
                child: Center(
                  child: Text(
                    '${controller.quantity.value}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              _QuantityButton(
                icon: Icons.add,
                onTap: controller.increaseQuantity,
              ),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 156,
          height: 42,
          child: ElevatedButton(
            onPressed: controller.addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Add to Cart — \$${controller.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: Icon(
      icon,
      size: 16,
      color: onTap == null ? AppColors.textHint : AppColors.primary,
    ),
    constraints: const BoxConstraints.tightFor(width: 28, height: 32),
    padding: EdgeInsets.zero,
  );
}

abstract final class _TextStyles {
  static const productName = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );
  static const title = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );
  static const body = TextStyle(
    fontSize: 10,
    height: 1.35,
    color: AppColors.textSecondary,
  );
  static const label = TextStyle(fontSize: 10, color: AppColors.textSecondary);
  static const value = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
}

class _RicePainter extends CustomPainter {
  const _RicePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final window = Paint()..color = const Color(0xFFF9F8F3);
    final frame = Paint()..color = const Color(0xFFB6AD9E);
    final table = Paint()..color = const Color(0xFFD0BFA8);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * .31, size.height * .72),
      window,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * .28, 0, 8, size.height * .72),
      frame,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * .29, size.width * .31, 6),
      frame,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * .75, size.width, size.height * .25),
      table,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * .56, size.height * .79),
        width: size.width * .62,
        height: 27,
      ),
      Paint()..color = const Color(0x332A2218),
    );
    final grain = Paint()..color = const Color(0xFFF8F0D2);
    final center = Offset(size.width * .53, size.height * .43);
    for (var row = 0; row < 12; row++) {
      final count = 4 + row * 2;
      final y = center.dy + row * 9.5;
      final spread = 15.0 + row * 9.3;
      for (var i = 0; i < count; i++) {
        final x = center.dx - spread + (spread * 2 * i / (count - 1));
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(((i * 17 + row * 13) % 22 - 11) * .035);
        canvas.drawOval(
           Rect.fromCenter(center: Offset.zero, width: 15, height: 5),
          grain,
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
