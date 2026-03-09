import 'dart:async';

import 'package:expense_tracker/presentation/home/home_model.dart';
import 'package:expense_tracker/presentation/home/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final monthProvider = StateProvider<DateTime>((ref) => DateTime.now());

final dateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final homeRepoProvider = Provider((_) => HomeRepository());

class AddExpenseAsyncNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> loadSaveData({
    required int amount,
    required String description,
  }) async {
    state = const AsyncLoading();
    final selectedDate = ref.read(dateProvider);
    final service = ref.read(homeRepoProvider);
    state = await AsyncValue.guard(() async {
      return service.addExpense(
        homeModel: HomeModel(
          id: '2',
          description: description,
          expenseDate: selectedDate,
          amount: amount,
        ),
      );
    });
    ref.read(dateProvider.notifier).state = DateTime.now();
  }
}

final saveExpenseNotifier =
    AsyncNotifierProvider<AddExpenseAsyncNotifier, bool>(
      AddExpenseAsyncNotifier.new,
    );

class GetExpenseProvider extends AsyncNotifier<List<HomeModel>> {
  @override
  FutureOr<List<HomeModel>> build() {
    final selectedMonth = ref.read(monthProvider);
    final service = ref.read(homeRepoProvider);
    return service.getExpenseData(selectedMonth: selectedMonth);
  }

  Future<void> loadGetData() async {
    state = AsyncLoading();
    final service = ref.read(homeRepoProvider);
    final selectedMonth = ref.read(monthProvider);
    state = await AsyncValue.guard(() async {
      return service.getExpenseData(selectedMonth: selectedMonth);
    });
  }
}

final getExpenseNotifier =
    AsyncNotifierProvider<GetExpenseProvider, List<HomeModel>>(
      GetExpenseProvider.new,
    );

///update providers

class UpdateExpenseNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> loadUpdate({
    required int amount,
    required String description,
    required String id,
  }) async {
    state = const AsyncLoading();
    final selectedDate = ref.read(dateProvider);
    final service = ref.read(homeRepoProvider);
    state = await AsyncValue.guard(() {
      return service.updateExpense(
        HomeModel(
          id: id,
          description: description,
          expenseDate: selectedDate,
          amount: amount,
        ),
      );
    });
  }
}

final updateExpenseProvider =
    AsyncNotifierProvider<UpdateExpenseNotifier, bool>(
      UpdateExpenseNotifier.new,
    );

class DeleteNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> loadDeleteData({required String id}) async {
    state = const AsyncLoading();
    final service = ref.read(homeRepoProvider);
    state = await AsyncValue.guard(() async {
      return service.deleteData(id: id);
    });
  }
}

final deleteProvider = AsyncNotifierProvider<DeleteNotifier, bool>(
  DeleteNotifier.new,
);
