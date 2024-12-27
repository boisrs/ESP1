import 'package:flutter/material.dart';

class CurrentExchangePage extends StatefulWidget {
  const CurrentExchangePage({super.key});

  @override
  State<CurrentExchangePage> createState() => _CurrentExchangePageState();
}

class _CurrentExchangePageState extends State<CurrentExchangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຈັດການຂໍ້ມູນອັດຕາແລກປ່ຽນ'),
      ),
      body: Center(
        child: Text('ຂໍ້ມູນອັດຕາແລກປ່ຽນ'),
      ),
    );
  }
}