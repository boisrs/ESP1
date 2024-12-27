import 'package:flutter/material.dart';
import 'package:myapp/Login/LoginPage.dart';


void main(){
  runApp(myapp());
}
class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.amber[700],
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            
          ),
          iconTheme: IconThemeData(
          color: Colors.white,
          size: 33.0
          )
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(fontSize: 25,color: Colors.white),
          unselectedLabelStyle: TextStyle(fontSize: 14,color: Colors.white),

        )

      ),



      home: LoginPage(),
    );
  }
}