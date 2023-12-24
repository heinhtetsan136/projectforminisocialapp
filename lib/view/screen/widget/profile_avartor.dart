import 'package:flutter/material.dart';

class ProfileAvator extends StatelessWidget {
  final String name ;
  const ProfileAvator({super.key,double this.radius=17,this.name="A"});
   final double radius;
  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey,
          child: Text(name,style: TextStyle(color: Colors.black,
          fontWeight: FontWeight.w900),),
          
         );
  }
}