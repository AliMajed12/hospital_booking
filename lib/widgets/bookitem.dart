import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/Screens/addtimeadmin.dart';
import 'package:hospital/Screens/clinicpage.dart';
import 'package:hospital/Screens/udate.dart';

import 'button.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({ Key? key, required this.namee, required this.namea, required this.path, this.admin=false, required this.id, required this.detailsa, required this.detailse, this.times }) : super(key: key);
  final String namee,namea,path,id,detailsa,detailse;
  final times;
  final bool admin;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
  
                  leading:Image.memory(base64Decode(path)),
                  title:  Text(namee),
                  subtitle:  Text(namea),
                  trailing:admin?SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: Row(
                children: [
                    IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Update(id: id,namee: namee,namea: namea,detailsa:detailsa,detailse:detailse,img:path ,)));
                    }, icon: Icon(Icons.edit,color: Colors.green,)),
                    IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminCheckoutPage(id: id,namee: namee,namea: namea,detailsa:detailsa,detailse:detailse,img:path ,time: times,)));
                    }, icon: Icon(Icons.timer,color: Colors.blue,)),
                    IconButton(onPressed: () async {
                       await FirebaseFirestore.instance.collection("clinics").doc(id).delete();
                    }, icon: Icon(Icons.remove_circle_outline,color: Colors.red,)),
                ],
              ),
                  ) : MainButton(width: 100, height: 40, text: "Book now",fun: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ClinicPage(id: id,namee: namee,namea: namea,detailsa:detailsa,detailse:detailse,path:path ,time: times,)));

                  }),
                ),
              ), const SizedBox(height: 20,),
      ],
    );
         
  }
}