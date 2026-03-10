import 'package:expense_tracker/constant/app_colors.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final PreferredSizeWidget ? appBar;
  final Widget body;
  final Widget ? floatingActionButton;
  final bool ? resizeToAvoidBottomInset;
  const BaseScaffold( {super.key,  this.appBar, required this.body, this.floatingActionButton,this.resizeToAvoidBottomInset,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      backgroundColor: AppColors.backgroundColor,
      appBar:appBar ,
      body: SafeArea(child: body),
      floatingActionButton: SafeArea(child: floatingActionButton ?? SizedBox()),

    );
  }
}