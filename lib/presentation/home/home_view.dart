import 'package:expense_tracker/constant/app_colors.dart';
import 'package:expense_tracker/presentation/home/home_viewmodel.dart';
import 'package:expense_tracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeView extends ConsumerWidget {
  HomeView({super.key});

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final dateNotifierUi=ref.watch(monthProvider);
    final dateNotifierRead=ref.read(monthProvider.notifier);

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                      onTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('dd MMM').format(dateNotifierUi),
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_drop_down, color: Colors.white),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "₹25000",
                      style: TextStyle(fontSize: 35, color: Colors.white),
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              ...[1, 2, 3, 4, 5, 7].map((cur) {
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
                              Text("coofie", style: TextStyle(fontSize: 15)),
                              Text(
                                "12 Mar 2026 05:30 PM",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹25",
                            style: TextStyle(
                              fontSize: 15,
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Enter your expense details",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: screenWidth / 1.1,
                          child: CustomTextField(
                            iconData: Icons.currency_rupee,
                            title: "Amount",
                            keyBoardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: screenWidth / 1.1,
                          child: CustomTextField(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.date_range),
                                  SizedBox(width: 13,),
                                  Text("22-03-2026"),
                                ],
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
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
                                print("Suucess Mame");
                              }
                            },
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
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
