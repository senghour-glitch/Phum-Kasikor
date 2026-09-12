import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/earnings_controller.dart';
import 'package:phum_kasikor/model/earnings_model.dart';

class EarningsScreen extends StatelessWidget {
  EarningsScreen({super.key});

  final EarningsController controller = Get.isRegistered<EarningsController>()
      ? Get.find<EarningsController>()
      : Get.put(EarningsController());

  static const _green = Color(0xFF2E8436);
  static const _ink = Color(0xFF29363B);
  static const _muted = Color(0xFF607A87);

  @override
  Widget build(BuildContext context) {
    final summary = controller.summary;
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(21, 24, 21, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Earnings Dashboard',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 11),
                    _periodPicker(),
                    const SizedBox(height: 9),
                    _earningsCard(summary),
                    const SizedBox(height: 14),
                    _incomeFlow(),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _MetricCard(
                            label: 'Orders Completed',
                            value: '${summary.ordersCompleted}',
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: _MetricCard(
                            label: 'Avg Order Val',
                            value: _money(summary.averageOrderValue),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: _MetricCard(
                            label: 'Pending Payout',
                            value: _money(summary.pendingPayout, decimals: 0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'RECENT TRANSACTIONS',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Obx(
                      () => Column(
                        children: controller.transactions
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _TransactionTile(transaction: item),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _periodPicker() => Obx(
    () => Container(
      height: 35,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDCE1E2)),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: List.generate(controller.periods.length, (index) {
          final selected = controller.selectedPeriod.value == index;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => controller.changePeriod(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? _green : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.periods[index],
                  style: TextStyle(
                    color: selected ? Colors.white : _muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );

  Widget _earningsCard(EarningSummaryModel summary) => Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(18, 17, 18, 17),
    decoration: BoxDecoration(
      color: _green,
      borderRadius: BorderRadius.circular(19),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Total Monthly Earnings',
              style: TextStyle(
                color: Color(0xFFD7EED9),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.trending_up, color: Colors.white, size: 15),
            const SizedBox(width: 3),
            Text(
              '+${summary.growth.toStringAsFixed(1)}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _money(summary.totalEarnings),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 31,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Text(
              'ABA Account: ${summary.accountNumber}',
              style: const TextStyle(color: Color(0xFFD7EED9), fontSize: 11),
            ),
            const Spacer(),
            InkWell(
              onTap: controller.withdraw,
              borderRadius: BorderRadius.circular(7),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  'Withdraw',
                  style: TextStyle(
                    color: _green,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _incomeFlow() => Obx(() {
    final incomes = controller.weeklyIncome;
    final maxAmount = incomes.fold<double>(
      0,
      (max, item) => item.amount > max ? item.amount : max,
    );
    return Container(
      height: 142,
      padding: const EdgeInsets.fromLTRB(17, 14, 17, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E4E3)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Income Flow (USD)',
            style: TextStyle(
              color: _muted,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(incomes.length, (index) {
                final income = incomes[index];
                final height = maxAmount == 0
                    ? 0.0
                    : income.amount / maxAmount * 100;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 18,
                      height: height,
                      decoration: BoxDecoration(
                        color: index == 2 ? _green : const Color(0xFFE5F1E7),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      income.week,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  });

  String _money(double value, {int decimals = 2}) {
    final parts = value.toStringAsFixed(decimals).split('.');
    final digits = parts.first;
    final formatted = StringBuffer();
    for (var index = 0; index < digits.length; index++) {
      if (index > 0 && (digits.length - index) % 3 == 0) formatted.write(',');
      formatted.write(digits[index]);
    }
    return '\$${formatted.toString()}${decimals == 0 ? '' : '.${parts.last}'}';
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    height: 52,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE1E4E4)),
      borderRadius: BorderRadius.circular(11),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF78909A),
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF29363B),
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});
  final TransactionModel transaction;
  @override
  Widget build(BuildContext context) => Container(
    height: 49,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE0E4E3)),
      borderRadius: BorderRadius.circular(11),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                transaction.title,
                style: const TextStyle(
                  color: Color(0xFF303B40),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                transaction.date,
                style: const TextStyle(color: Color(0xFF78909A), fontSize: 10),
              ),
            ],
          ),
        ),
        Text(
          '${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: transaction.isIncome
                ? const Color(0xFF2E8436)
                : const Color(0xFF303B40),
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}
