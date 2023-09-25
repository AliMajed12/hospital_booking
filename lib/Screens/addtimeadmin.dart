import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:hospital/widgets/button.dart';

import 'admin.dart';

class AdminCheckoutPage extends StatefulWidget {
   AdminCheckoutPage({ Key? key, this.id, this.namea, this.namee, this.detailse, this.detailsa, this.img, this.time }) : super(key: key);
final namea;

final namee;

final detailse;

final detailsa;
  final img;
  final id;
  final time;
  @override
  State<AdminCheckoutPage> createState() => _AdminCheckoutPageState();
}

class _AdminCheckoutPageState extends State<AdminCheckoutPage> {

List<String> days =["Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"];

String selected2 ="Saturday";

String Times="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/pp.jpg"),
            const Text("Set available time",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.blue ),),
            const SizedBox(height: 20,),
            // const Text("Heart clinic 1",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold ),),
              const Text("Choose Day"),
              Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  alignment: Alignment.center,
                  items: days.map((e) => DropdownMenuItem<String>(child: Text(e),value: e,)).toList()
                , onChanged: (value){
                  setState(() {
                    selected2=value!;
                  });
                },value: selected2,
                ),
              ),
            const SizedBox(height:20,),

              TimePickerSpinner(
              is24HourMode: false,         
              spacing: 30,
              itemHeight: 50,
              isForce2Digits: true,
              onTimeChange: (time) {
                Times="${time.hour}:${time.minute} on ${selected2}";
              },
  ),
            const SizedBox(height:20,),
    
             MainButton(width: 200, height: 40, text: "Save Time",fun: (){
                    widget.time.add(Times);  
                    FirebaseFirestore.instance.collection("clinics").doc(widget.id).update({
                   "namee":widget.namee,
                   "namea":widget.namea,
                   "detailsa":widget.detailsa,
                   "detailse":widget.detailse,
                   "img":widget.img,
                   "time":
                     widget.time
                   
                 }).then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AdminList()));
                 });
               })
          ],
        ),
      )),
    );
  }
}