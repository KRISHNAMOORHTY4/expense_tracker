import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),

      body: Center(
        child: Column(
          children: [
            Container(
              height: 150,
              width: screenWidth / 1.1,

              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "25000",
                style: TextStyle(fontSize: 35, color: Colors.white),
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
            Container(
                  width: screenWidth / 1.1,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade400,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 50, color: Colors.red, height: 20),
                      Text("coofie"),
                      Text("25"),
                    ],
                  ),
                ),
                 Container(
                  width: screenWidth / 1.1,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade400,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 50, color: Colors.red, height: 20),
                      Text("coofie"),
                      Text("25"),
                    ],
                  ),
                ),
                 Container(
                  width: screenWidth / 1.1,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade400,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 50, color: Colors.red, height: 20),
                      Text("coofie"),
                      Text("25"),
                    ],
                  ),
                ),
                 Container(
                  width: screenWidth / 1.1,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade400,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 50, color: Colors.red, height: 20),
                      Text("coofie"),
                      Text("25"),
                    ],
                  ),
                ),
                 Container(
                  width: screenWidth / 1.1,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade400,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 50, color: Colors.red, height: 20),
                      Text("coofie"),
                      Text("25"),
                    ],
                  ),
                ),
           
          ],
        ),
      ),
    );
  }
}
