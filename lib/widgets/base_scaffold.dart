import 'package:expense_tracker/constant/app_colors.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget ? appBar;
  final Widget body;
  final Widget ? floatingActionButton;
  const BaseScaffold({super.key,  this.appBar, required this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:appBar ,
      body: SafeArea(child: body),
      floatingActionButton: SafeArea(child: floatingActionButton ?? SizedBox()),

    );
  }
}