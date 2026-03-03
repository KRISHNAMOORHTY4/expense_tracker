import 'package:expense_tracker/constant/app_colors.dart';
import 'package:expense_tracker/constant/responsive.dart';
import 'package:expense_tracker/presentation/home/home_viewmodel.dart';
import 'package:expense_tracker/utils/date_month_piker.dart';
import 'package:expense_tracker/widgets/base_scaffold.dart';
import 'package:expense_tracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HomeView extends ConsumerWidget {
  HomeView({super.key});

  final globalKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  //krishna0753
  // Future<void> saveData(BuildContext contextData) async {
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   db
  //       .collection("users")
  //       .doc('krishna0753')
  //       .collection("expense")
  //       .add({
  //         "amount": 200,
  //         "description": "first Coffie",
  //         "date": DateTime.now(),
  //         "createdAt": FieldValue.serverTimestamp(),
  //       })
  //       .then((cur) {
  //         print("SucessMapla");
  //         return ScaffoldMessenger.of(
  //           contextData,
  //         ).showSnackBar(SnackBar(content: Text("Successfully Added")));
  //       })
  //       .catchError((e) {
  //         print("Error Mame...$e");
  //       });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //month providers
    final monthNotifierUi = ref.watch(monthProvider);
    final monthNotifierRead = ref.read(monthProvider.notifier);

    //date providers
    final dateNotifierUi = ref.watch(dateProvider);
    final dateNotifierRead = ref.read(dateProvider.notifier);

    //save providers
    final saveNotifierUi = ref.watch(saveExpenseNotifier);
    final saveNotifierRead = ref.read(saveExpenseNotifier.notifier);

    //getExpense provider
    final getExpenseProviderUi = ref.watch(getExpenseNotifier);
    final getExpenseProviderRead = ref.read(getExpenseNotifier.notifier);

    ref.listen(saveExpenseNotifier, (prev, next) {
      next.whenOrNull(
        data: (data) {
          if (data) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("SuccessFully Added")));
            ref.refresh(getExpenseNotifier);
            print("Success Mapla");
          }
        },
      );
    });

    double screenWidth = MediaQuery.of(context).size.width;
    return BaseScaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: getExpenseProviderUi.when(
            data: (data) {
              return Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 150,
                    width: screenWidth / 1.1,

                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            final _selectedMOnth =
                                await DateMonthPiker.getMonthPicker(
                                  context: context,
                                  initialDate: monthNotifierRead.state,
                                );

                            if (_selectedMOnth != null) {
                              monthNotifierRead.state = _selectedMOnth;
                              print(
                                "Mapla :${monthNotifierRead.state.lastDayOfMonth()!.day}",
                              );
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormat('MMM yyyy').format(monthNotifierUi),
                                style: TextStyle(
                                  fontSize:
                                      Responsive.isMopile(context) ? 15 : 17,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_drop_down, color: Colors.white),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "₹25000",
                          style: TextStyle(
                            fontSize: Responsive.isMopile(context) ? 35 : 37,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: screenWidth / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Expense",
                          style: TextStyle(
                            fontSize: Responsive.isMopile(context) ? 16 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text("View All"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ...data.map((cur) {
                    return Container(
                      width: screenWidth / 1.1,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),

                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.backgroundColor,
                                child: Icon(Icons.trending_down),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cur.description,
                                    style: TextStyle(
                                      fontSize:
                                          Responsive.isMopile(context)
                                              ? 15
                                              : 17,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd MMM yyyy h:m a').format(cur.expenseDate),
                                    style: TextStyle(
                                      fontSize:
                                          Responsive.isMopile(context)
                                              ? 12
                                              : 14,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "₹${cur.amount}",
                                style: TextStyle(
                                  fontSize:
                                      Responsive.isMopile(context) ? 15 : 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
            error: (e, s) => Text("$e"),
            loading:
                () => Center(
                  heightFactor: 10,
                  child: CircularProgressIndicator(),
                ),
          ),
        ),
      ),

      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 50, right: 5),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () {
            showModalBottomSheet(
              constraints: BoxConstraints(maxHeight: 450),
              backgroundColor: AppColors.backgroundColor,
              context: context,
              builder: (context) {
                return Form(
                  key: globalKey,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Container(
                          height: 8,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Add Expense",
                          style: TextStyle(
                            fontSize: Responsive.isMopile(context) ? 18 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Enter your expense details",
                          style: TextStyle(
                            fontSize: Responsive.isMopile(context) ? 15 : 17,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: screenWidth / 1.1,
                          child: CustomTextField(
                            controller: amountController,
                            iconData: Icons.currency_rupee,
                            title: "Amount",
                            keyBoardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: screenWidth / 1.1,
                          child: CustomTextField(
                            controller: descriptionController,
                            iconData: Icons.note_alt_outlined,
                            title: "description",
                            keyBoardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth / 1.1,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFFE5E7EB)),
                          ),
                          child: InkWell(
                            onTap: () async {
                              final _selectedDate =
                                  await DateMonthPiker.getDatePicker(
                                    context: context,
                                    initialDate: dateNotifierRead.state,
                                  );
                              if (_selectedDate != null) {
                                dateNotifierRead.state = _selectedDate;
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.date_range),
                                    SizedBox(width: 13),
                                    Text(
                                      DateFormat(
                                        'dd-MM-yyyy',
                                      ).format(dateNotifierUi),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),

                        Container(
                          width: screenWidth / 1.1,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                saveNotifierRead.loadSaveData(
                                  amount: int.parse(amountController.text),
                                  description: descriptionController.text,
                                );
                              }
                            },
                            child: saveNotifierUi.when(
                              data: (data) {
                                return Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                    fontSize:
                                        Responsive.isMopile(context) ? 16 : 18,
                                    color: Colors.white,
                                  ),
                                );
                              },
                              error:
                                  (e, s) => SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                              loading:
                                  () => SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
