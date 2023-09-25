import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/Screens/admin.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/button.dart';


class AddProduct extends StatefulWidget {
   AddProduct({ Key? key }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
var namea = TextEditingController();

var namee = TextEditingController();

var detailse = TextEditingController();

var detailsa = TextEditingController();

var formkey = GlobalKey<FormState>();

      List<int>? imageBytes;

      XFile? image ;

      String? base64Image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child:Column(
            children:  [
              const Text("Add Clinic",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue),),
              Image.asset("assets/cli.jpg"),
              const SizedBox(height: 10,),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    InkWell(
                       onTap: () async {
                       final ImagePicker _picker = ImagePicker();
                        image = (await _picker.pickImage(source: ImageSource.gallery))!;
                        imageBytes= File(image!.path).readAsBytesSync();
                    image!.readAsBytes().then((value) { imageBytes=value;});
                  base64Image = base64Encode(imageBytes!);
                  setState(() {
                    
                  });
                  },
                      child: CircleAvatar(
                        
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.blue
                        )
                      ),
                          child:imageBytes==null? Image.asset("assets/placeholder-image.png"):Image.file(File(image!.path))),
                      ),
                    ),
                    const Text('Photo')
                  ],
                ),
              ),
        
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                   validator: (v){
                        if (v==null || v.isEmpty) {
                          return "You must input a value";
                        }
                        return null;
                      },
                  controller: namea,
                  decoration: const InputDecoration(
                    hintText: "name in Arabic",
                    prefixIcon: Icon(Icons.medical_services)
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                   validator: (v){
                        if (v==null || v.isEmpty) {
                          return "You must input a value";
                        }
                        return null;
                      },
                  controller: namee,
                  
                  decoration: const InputDecoration(
                    hintText: "name in English",
                    prefixIcon: Icon(Icons.medical_services)
                  ),
                ),
              ),
              const SizedBox(height: 30,),
         Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: detailse,
 validator: (v){
                        if (v==null || v.isEmpty) {
                          return "You must input a value";
                        }
                        return null;
                      },
                  maxLines: 4,
                  decoration: const InputDecoration(
                                        helperText: "Details in English",

                    prefixIcon: Icon(Icons.info)
                  ),
                ),
              ),
              const SizedBox(height: 30,),
         Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: detailsa,
 validator: (v){
                        if (v==null || v.isEmpty) {
                          return "You must input a value";
                        }
                        return null;
                      },
                  maxLines: 4,
                  decoration: const InputDecoration(
                    helperText: "Details in Arabic",
                
                                      // hintText: "Details in Arabic",
                    prefixIcon: Icon(Icons.info)
                  ),
                ),
              ),
              const SizedBox(height: 30,),

             MainButton(width: 200, height: 40, text: "Add clinic",fun: (){
                              if (formkey.currentState!.validate()) {
                   if (base64Image==null||base64Image!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You must choose image")));

                   }else{
                     FirebaseFirestore.instance.collection("clinics").add({
                   "namee":namee.text,
                   "namea":namea.text,
                   "detailsa":detailsa.text,
                   "detailse":detailse.text,
                   "img":base64Image,
                 }).then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AdminList()));
                 });
                   }
                   
                 }
             })
        
            ],
          ),
      )),
    );
  }
}