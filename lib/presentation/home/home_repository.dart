import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/constant/app_user.dart';
import 'package:expense_tracker/presentation/home/home_model.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HomeRepository {
  Future<bool> addExpense({required HomeModel homeModel}) async {
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final userId = AppUser.auth;
      await db
          .collection('users')
          .doc(userId)
          .collection('expense')
          .add(homeModel.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<HomeModel>> getExpenseData({
    required DateTime selectedMonth,
  }) async {
    try {
      final startDate = DateTime(selectedMonth.day, selectedMonth.month, 01);
      final endDate = DateTime(
        selectedMonth.lastDayOfMonth()!.day,
        selectedMonth.month,
        selectedMonth.year,
      );
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final userId = AppUser.auth;
      QuerySnapshot getData =
          await db
              .collection('users')
              .doc(userId)
              .collection('expense')
              .where("expenseDate", isGreaterThanOrEqualTo: startDate)
              // .where('expenseDate', isLessThanOrEqualTo: endDate)
              .get();

      return getData.docs
          .map((cur) {
            print("VANTHA DATA ${cur}");
            return  HomeModel.fromJson(cur as Map<String, dynamic>);
          })
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
