import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຈັດການຂໍ້ມູນພະນັກງານ'),
      ),
      body: Center(
        child: Text('ຂໍ້ມູນພະນັກງານ'),
      ),
    );
  }
}