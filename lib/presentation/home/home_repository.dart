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
      final startDate = DateTime(selectedMonth.year, selectedMonth.month, 01);
      final endDate = DateTime(selectedMonth.year,selectedMonth.month+1,0);
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final userId = AppUser.auth;
      QuerySnapshot getData =
          await db
              .collection('users')
              .doc(userId)
              .collection('expense')
              .where("expenseDate", isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
               .where('expenseDate', isLessThanOrEqualTo: Timestamp.fromDate(endDate)).orderBy('expenseDate',descending: true)
              .get();
      // print("MAPLA $endDate");
      return getData.docs
          .map((cur) {
            print("MAPLA ${cur.data()}");
            return  HomeModel.fromJson(cur.data() as Map<String, dynamic>);
          })
          .toList();
    } catch (e) {
      print("osd $e");
      throw Exception(e.toString());
    }
  }
}
