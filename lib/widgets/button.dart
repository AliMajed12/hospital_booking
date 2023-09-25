import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({ Key? key, required this.width, required this.height, required this.text, required this.fun }) : super(key: key);
  final double width;
  final double height;
  final String text;
  final Function() fun;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: fun, child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child:  Center(child: Text(text,style:const TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),))
                )
                ,);
  }
}