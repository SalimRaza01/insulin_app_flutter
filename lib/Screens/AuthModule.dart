import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text('Login',style: TextStyle(color: const Color.fromARGB(255, 84, 84, 84)),),),

body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 100),
  child: Container(
    height: 230,
    decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(20)),
    child: Column(
      
      children: [
        TextField(
          
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: 'Enter Name',
            hintStyle: TextStyle(color: Colors.white),
          ),
          
        ),
          TextField(
          decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
            hintText: 'Phone no.',
            hintStyle: TextStyle(color: Colors.white),
          ),
          
        ),
          TextField(
          decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.white),
          ),
          
        ),
        SizedBox(height: 20,),
  
        Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(color: Color.fromARGB(255, 120, 164, 160),borderRadius: BorderRadius.circular(20),),
          child: Center(child: Text('Login')),
          
        )
      ],
    ),
  ),
),

    );
  }
}