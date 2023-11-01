import 'package:flutter/material.dart';
import 'package:studentform/register.dart';
import 'package:studentform/show.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SELECT"),),
      body: Container(
        child: Align(
         alignment: Alignment.center,
        child: Column(children: [
          SizedBox(height: 180,),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>  RegistrationScreen(),
              ),
            );
          }, child: Text("register user in DB")),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShowDataScreen(),
              ),
            );
          }, child: Text("Show (using roll_no)")),



        ],),
      ),
      ),
    );
  }
}
