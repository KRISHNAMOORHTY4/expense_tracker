import 'package:expense_tracker/constant/app_colors.dart';
import 'package:expense_tracker/constant/responsive.dart';
import 'package:expense_tracker/presentation/home/home_viewmodel.dart';
import 'package:expense_tracker/utils/date_month_piker.dart';
import 'package:expense_tracker/widgets/base_scaffold.dart';
import 'package:expense_tracker/widgets/custom_buttons.dart';
import 'package:expense_tracker/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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

    final dateNotifierRead = ref.read(dateProvider.notifier);

    //getExpense provider
    final getExpenseProviderUi = ref.watch(getExpenseNotifier);
    final getExpenseProviderRead = ref.read(getExpenseNotifier.notifier);

    //delete provider
    final deleteProviderRead = ref.read(deleteProvider.notifier);

    ref.listen(deleteProvider, (prev, next) {
      next.whenOrNull(
        data: (data) {
          if (data) {
            ref.refresh(getExpenseNotifier);
          }
        },
      );
    });

    ref.listen(saveExpenseNotifier, (prev, next) {
      next.whenOrNull(
        data: (data) {
          if (data) {
            Navigator.pop(context);
            amountController.text = '';
            descriptionController.text = '';
            Fluttertoast.showToast(
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
              msg: "Successfully Added",
              backgroundColor: Colors.green,
            );

            ref.refresh(getExpenseNotifier);
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
              int totalAmount = 0;
              for (var newData in data) {
                totalAmount += newData.amount;
              }

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
                              getExpenseProviderRead.loadGetData();
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
                          "₹$totalAmount",
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
                  if (data.isEmpty)
                    Center(
                      heightFactor: 10,
                      child: Text(
                        "No Data for this month",
                        style: TextStyle(
                          fontSize: Responsive.isMopile(context) ? 16 : 18,
                        ),
                      ),
                    ),
                  ...data.map((cur) {
                    return InkWell(
                      onDoubleTap: () {
                        deleteProviderRead.loadDeleteData(id: cur.id);
                      },
                      child: Container(
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
                                      DateFormat(
                                        'dd MMM yyyy h:m a',
                                      ).format(cur.expenseDate),
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
                return Consumer(
                  builder: (context, refData, child) {
                    final dateNotifierUi = refData.watch(dateProvider);
                    //save providers
                    final saveNotifierUi = refData.watch(saveExpenseNotifier);
                    final saveNotifierRead = refData.read(
                      saveExpenseNotifier.notifier,
                    );
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
                                fontSize:
                                    Responsive.isMopile(context) ? 18 : 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Enter your expense details",
                              style: TextStyle(
                                fontSize:
                                    Responsive.isMopile(context) ? 15 : 17,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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

                            CustomButtons(
                              title: "SUBMIT",
                              onPressed: () async {
                                // if (globalKey.currentState!.validate()) {
                                //   saveNotifierRead.loadSaveData(
                                //     amount: int.parse(amountController.text),
                                //     description: descriptionController.text,
                                //   );
                                // }
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                        email: "karnars200@gmail.com",
                                      );
                                  print("Success mapla");
                                } catch (e) {
                                  print("MPAL:ERROR>>>$e");
                                }
                              },
                              isLoading: saveNotifierUi.when(
                                data: (data) => false,
                                error: (e, s) => false,
                                loading: () => true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
