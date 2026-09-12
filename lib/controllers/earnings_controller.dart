import 'package:get/get.dart';
import 'package:phum_kasikor/model/earnings_model.dart';

/// Owns all state shown on the farmer earnings dashboard.
class EarningsController extends GetxController {
  final selectedPeriod = 2.obs;

  final periods = const ['Today', 'Week', 'Month', 'Year'];

  final summary = const EarningSummaryModel(
    totalEarnings: 1240,
    growth: 15.4,
    accountNumber: '**** 4523',
    ordersCompleted: 45,
    averageOrderValue: 27.55,
    pendingPayout: 340,
  );

  final weeklyIncome = <WeeklyIncomeModel>[
    const WeeklyIncomeModel(week: 'W1', amount: 450),
    const WeeklyIncomeModel(week: 'W2', amount: 700),
    const WeeklyIncomeModel(week: 'W3', amount: 1000),
    const WeeklyIncomeModel(week: 'W4', amount: 550),
  ].obs;

  final transactions = <TransactionModel>[
    const TransactionModel(title: 'Order Payout #ORD-2024-001', date: 'Today, 2:30 PM', amount: 64.50, isIncome: true),
    const TransactionModel(title: 'Withdrawn to ABA Account', date: 'Oct 20, 2024', amount: 450, isIncome: false),
    const TransactionModel(title: 'Order Payout #ORD-2024-012', date: 'Oct 18, 2024', amount: 35, isIncome: true),
  ].obs;

  void changePeriod(int index) => selectedPeriod.value = index;

  void withdraw() {
    Get.snackbar(
      'Withdraw',
      'Withdraw request sent successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
