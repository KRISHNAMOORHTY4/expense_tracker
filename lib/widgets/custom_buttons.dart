import 'package:expense_tracker/constant/responsive.dart';
import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButtons({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isLoading,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: height ?? 50,
      width: width ?? screenWidth / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child:
            isLoading
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Please wait",style: TextStyle(color: Colors.white),),
                    SizedBox(width: 10,),
                    SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
                  ],
                )
                : Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.isMopile(context) ? 16 : 18,
                    color: Colors.white,
                  ),
                ),
      ),
    );
  }
}
