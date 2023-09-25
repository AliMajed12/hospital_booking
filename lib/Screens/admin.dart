import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/Screens/addclinic.dart';
import 'package:hospital/Screens/home.dart';
import 'package:hospital/widgets/bookitem.dart';

class AdminList extends StatelessWidget {
  const AdminList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin page"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProduct()));
          }, icon: Icon(Icons.add)),
           IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
          }, icon: Icon(Icons.home)),
        ],
      ),
      body: SafeArea(child: SingleChildScrollView(child: 
      Column(
        children:  [
            StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("clinics").snapshots(),
        builder: (context,snapshot){
             if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
               children: snapshot.requireData.docs.map((document) {
                  return BookingItem(namea:document['namea'], namee: document['namee'], path: document['img'] ,admin: true, id: document.id,detailsa: document['detailsa'], detailse: document['detailse'],times: document["time"],);
                }).toList(),
              ),
          );
        },
      )
        ],
      )
      ,)),
    );
  }
}
          //           BookingItem(namee: "Eye Clinic 1", namea: "عيادة العيون ١", path: "assets/eye.jpg",admin: true,),
          // BookingItem(namee: "Eye Clinic 2", namea: "عيادة العيون ٢", path: "assets/eye.jpg",admin: true,),
          // BookingItem(namee: "heart clinic 1", namea: "عيادة القلب ١", path: "assets/2.PNG",admin: true,),
          // BookingItem(namee: "heart clinic 2", namea: "عيادة القلب ٢", path: "assets/2.PNG",admin: true,),
          // BookingItem(namee: "Internal Medicine Clinic 1", namea: "عيادة الباطنية ١", path: "assets/internal.jpg",admin: true,),
          // BookingItem(namee: "Internal Medicine Clinic 2", namea: "عيادة الباطنية ٢", path: "assets/internal.jpg",admin: true,),
          // BookingItem(namee: "surgery clinic 1", namea: "عيادة الجراحة ١", path: "assets/surgery.jpg",admin: true,),
          // BookingItem(namee: "surgery clinic 2", namea: "عيادة الجراحة ٢", path: "assets/surgery.jpg",admin: true,),
          // BookingItem(namee: "Dentist 1", namea: "عيادة الاسنان ١", path: "assets/dentes.jpg",admin: true,),
          // BookingItem(namee: "Dentist 2", namea: "عيادة الاسنان ٢", path: "assets/dentes.jpg",admin: true,),
          // BookingItem(namee: "Urology Clinic", namea: "عيادة المسالك البولية", path: "assets/or.PNG",admin: true,),
          // BookingItem(namee: "dermatology clinic", namea: "عيادة الجلدية", path: "assets/ski.PNG",admin: true,),