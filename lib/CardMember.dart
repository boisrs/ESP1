import 'package:flutter/material.dart';

class CardMember extends StatefulWidget {
  const CardMember({super.key});

  @override
  State<CardMember> createState() => _CardMemberState();
}

class _CardMemberState extends State<CardMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ລະຫັດບັດ'
              ),
            )
          ],),
      ),
    );
  }
}