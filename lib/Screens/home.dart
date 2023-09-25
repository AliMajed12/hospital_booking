import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/widgets/bookitem.dart';


class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        SingleChildScrollView(
          child: Column(
            children: [
            Image.asset("assets/booking.jpg"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                     Text("Book your clinic now",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    Spacer(),
                     Text("أحجز عيادتك الان",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
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
                  return BookingItem(namea:document['namea'], namee: document['namee'], path: document['img'] , id: document.id,detailsa: document['detailsa'], detailse: document['detailse'],times: document["time"],);
                }).toList(),
              ),
          );
        },
      )
            ],
          ),
        )
      ),
    );
  }
}
          // const BookingItem(namee: "Eye Clinic 1", namea: "عيادة العيون ١", path: "assets/eye.jpg"),
          // const BookingItem(namee: "Eye Clinic 2", namea: "عيادة العيون ٢", path: "assets/eye.jpg"),
          // const BookingItem(namee: "heart clinic 1", namea: "عيادة القلب ١", path: "assets/2.PNG"),
          // const BookingItem(namee: "heart clinic 2", namea: "عيادة القلب ٢", path: "assets/2.PNG"),
          // const BookingItem(namee: "Internal Medicine Clinic 1", namea: "عيادة الباطنية ١", path: "assets/internal.jpg"),
          // const BookingItem(namee: "Internal Medicine Clinic 2", namea: "عيادة الباطنية ٢", path: "assets/internal.jpg"),
          // const BookingItem(namee: "surgery clinic 1", namea: "عيادة الجراحة ١", path: "assets/surgery.jpg"),
          // const BookingItem(namee: "surgery clinic 2", namea: "عيادة الجراحة ٢", path: "assets/surgery.jpg"),
          // const BookingItem(namee: "Dentist 1", namea: "عيادة الاسنان ١", path: "assets/dentes.jpg"),
          // const BookingItem(namee: "Dentist 2", namea: "عيادة الاسنان ٢", path: "assets/dentes.jpg"),
          // const BookingItem(namee: "Urology Clinic", namea: "عيادة المسالك البولية", path: "assets/or.PNG"),
          // const BookingItem(namee: "dermatology clinic", namea: "عيادة الجلدية", path: "assets/ski.PNG"),