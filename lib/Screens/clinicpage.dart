import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/Screens/checkout.dart';
import 'package:hospital/widgets/button.dart';

class ClinicPage extends StatelessWidget {
  const ClinicPage({ Key? key, required this.namee, required this.namea, required this.path, required this.id, required this.detailsa, required this.detailse, this.time }) : super(key: key);
  final String namee,namea,path,id,detailsa,detailse;
  final time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            Image.memory(base64Decode(path)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children:  [
                    Text("$namee",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue,),),
                    Spacer(),
                    Text("$namea",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue,),),
                  ],
                ),
              ),
              const Text("About clinic",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
            
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("$detailse",style:TextStyle(fontSize: 20,)),
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(height: 5,color: Colors.blue,),
              ),
              const SizedBox(height: 10,),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("$detailsa",textDirection: TextDirection.rtl,style:TextStyle(fontSize: 20,),),
              ),
               MainButton(width: 200, height: 40, text: "Book now",fun: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckoutPage(id: id,namee: namee,namea: namea,detailsa:detailsa,detailse:detailse,img:path ,time: time,)));

               })
            ],
        
          ),
        ),
      ),
    );
  }
}