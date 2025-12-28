import 'package:flutter/material.dart';
import './view/home_page.dart';

void main() {
  runApp(const Compliance());
}

class Compliance extends StatelessWidget {
  const Compliance({super.key}); 
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: "Compliance",
        debugShowCheckedModeBanner: false,
        home:  const HomePage() 
      );

      
    
  }
}

