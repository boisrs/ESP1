import 'package:flutter/material.dart';
import 'package:myapp/myHomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool obs=true;
  void showmessage(){
    setState(() {
      obs = !obs;
    });
  }


  Widget LogoDisplay(){
    return Container(
      width: 160,
      height: 160,
      child: CircleAvatar(
        child: ClipOval(
          child: Image.asset('images/logo_ic.png'),
        ),

      ),
    );
  }

  Widget showText(){
    return Text('Cafe Neverland',
    style: TextStyle(
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Lobster'
    ),
    );
  }

  Widget UserInput(){
    return Container(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          labelText: 'Username',
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.person,
          color: Colors.amber[900],
          size: 35.0,)
        ),
      ),
    );
  }

  Widget PasswordInput(){
    return Container(
      width: 300,
      child: TextField(
        obscureText: obs,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.lock,
          color: Colors.amber[900],
          size: 35.0,
          
          ),
          suffixIcon: IconButton(onPressed: () {
            showmessage();
          }, icon: obs?Icon(Icons.visibility_off):Icon(Icons.visibility))   ///ເຮັດໄອຄ້ອນປິດເປີດຕາ
          
        ),
      ),
    );
  }

  Widget LoginButton(){
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(onPressed: (){
        Navigator.of(context).pop();
        MaterialPageRoute route=MaterialPageRoute(builder: (c)=>myHomePage());
        Navigator.of(context).push(route);
      }, child: Text('Log In',
      style: TextStyle(color: Colors.white,
      fontFamily: 'Lobster',
      fontSize: 25),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black
      ),
      
      ),
    );
  }

  Widget SignUpButton(){
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(onPressed: (){
      
      }, child: Text('Sign Up',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Lobster',
      fontSize: 25),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red
      ),
      ),
    );
  }

  Widget LogSingButton(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginButton(),
        SizedBox(width: 15.0,),
        SignUpButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(                     //ໃຫ້ຮູບໂປຟາຍຢູ່ທາງກາງ
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(  
              gradient: RadialGradient(colors: [Colors.grey, Colors.blue])),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              LogoDisplay(),
              SizedBox(height: 10.0,),
              showText(),
              SizedBox(height: 10.0,),
              UserInput(),
              SizedBox(height: 10.0,),
              PasswordInput(),
              SizedBox(height: 10.0,),
              LogSingButton()
            ],
          ),
        ),
      ),
    )
    );
  }
}