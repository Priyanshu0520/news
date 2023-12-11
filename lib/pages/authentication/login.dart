import 'package:flutter/material.dart';

import '../home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,
        backgroundColor: Colors.transparent,
        ),
        body: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
      
            const Text("Login Here",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight:FontWeight.bold ),),
            const SizedBox(height: 20,),
            const Text("Welcome back you've",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const Text("been missed!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 50,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(color: Colors.grey.shade200,border: Border.all(color: const Color.fromARGB(255, 54, 255, 228)),borderRadius:BorderRadius.circular(10) ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration:const InputDecoration(hintText: "Email",border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 30,),
              Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(color: Colors.grey.shade200,border: Border.all(color: const Color.fromARGB(255, 54, 255, 228)),borderRadius:BorderRadius.circular(10) ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration:const InputDecoration(hintText: "Password",border: InputBorder.none),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 220,top: 10),
              child: Text("Forgot your password?",style: TextStyle(color: Colors.black),),
            ),
            const SizedBox(height: 100,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.6,
              child: ElevatedButton(onPressed:(
              
              ) {
                  Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
                
              }, style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 54, 255, 228)),
              child: const Text("Login in",style: TextStyle(fontSize: 20, color: Colors.black),)),
            ),
            const SizedBox(height:26),
            const Text("Create new account",style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}