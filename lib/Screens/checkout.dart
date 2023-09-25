import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/Screens/home.dart';
import 'package:hospital/widgets/button.dart';

class CheckoutPage extends StatefulWidget {
   CheckoutPage({ Key? key, this.namea, this.namee, this.detailse, this.detailsa, this.img, this.id, this.time }) : super(key: key);
final namea;

final namee;

final detailse;

final detailsa;
  final img;
  final id;
  final time;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
var name = TextEditingController();

var id = TextEditingController();

var sel="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/rec.jpg"),
            const Text("Book an available time",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.blue ),),
            const SizedBox(height: 10,),
            const Text("Heart clinic 1",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold ),),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: id,
                  decoration: const InputDecoration(
                    hintText: "Student Id",
                    prefixIcon: Icon(Icons.numbers)
                  ),
                ),
              ), 
                   Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon:  Icon(Icons.person)
                  ),
                ),
              ),
            const SizedBox(height:20,),
      
              const Text("Choose available Time"),
            StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("clinics").snapshots(),
        builder: (context,snapshot){
             if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Widget> l =[];
        snapshot.requireData.docs.forEach((document) {
                 if (document.id==widget.id) {
                   for (var item in document["time"]) {
                     print(item);
                    
                    l.add(GestureDetector(
                      child: Container(
                        child: ListTile(title: Text(item),trailing: IconButton(onPressed: (){
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("$item is choosen")));
                        sel=item;
                        }, icon: Icon(Icons.thumb_up)),),
                      ),
                    ));
                   }
                 }
                });
                // return Container();
          return Container(
            height: MediaQuery.of(context).size.height/4,
            child: ListView(
               children: l
              ),
          );
        },
      ),
               MainButton(width: 200, height: 40, text: "Book Now",fun: (){
                 if (name.text==""&&name.text.isEmpty&&id.text==""&&id.text.isEmpty) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Your data")));

                 }else if (sel==""){
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Your time")));
                   
                 }else{
                                List l = widget.time;
                   l.remove(sel);
                    FirebaseFirestore.instance.collection("clinics").doc(widget.id).update({
                   "namee":widget.namee,
                   "namea":widget.namea,
                   "detailsa":widget.detailsa,
                   "detailse":widget.detailse,
                   "img":widget.img,
                   "time":
                     l
                   
                 }).then((value){
                    FirebaseFirestore.instance.collection("books").add({
                      "name":name.text,
                      "id":id.text,
                      "time":sel,
                    }).then((value){
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                    });
                 });
                 }
               })
          ],
        ),
      )),
    );
  }
}