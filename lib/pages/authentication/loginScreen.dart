import 'package:flutter/material.dart';
import 'package:news/pages/authentication/login.dart';

import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx5dnFBCK78swO-EwXjV_7ClXxJlVkpE9a9Q&usqp=CAU"),
          ),
      SizedBox(height: 30,
          ),
           const Text("Aaj ki taja khabar",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
           const SizedBox(height: 10,),
           const Text("Desh duniya ki sabse badi khabre ",style: TextStyle(fontSize: 20,color: Colors.black),),
           const SizedBox(height: 170,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 130,
                child: ElevatedButton(onPressed:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const LoginPage() ));
                }, style: ElevatedButton.styleFrom(backgroundColor:  Color.fromARGB(255, 54, 255, 228)),
                child: const Text("Login",style:TextStyle(fontSize: 17,color: Colors.black),)),
              ),

              TextButton(onPressed:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const Home() ));
              }, child: const Text("Skip",style: TextStyle(fontSize: 17,color: Colors.black),)),
            ],
           )
        ],
      )

    ));
  }
}