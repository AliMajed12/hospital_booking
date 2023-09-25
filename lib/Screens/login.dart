import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/Screens/home.dart';

import '../widgets/button.dart';
import 'admin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
var key = GlobalKey<FormState>();
var id = TextEditingController();
var pass = TextEditingController();


bool isarab=false;

String login="تسجيل الدخول";
String idd="أدخل رقم الملف الخاص بك";
String passs="أدخل رمزك السري";
String btn="سجل الدخول";

changelang(){
  
  if (isarab) {
   login="تسجيل الدخول";
 idd="أدخل رقم الملف الخاص بك";
 passs="أدخل رمزك السري";
 btn="سجل الدخول";
  } else {
     login="Login";
 idd="Enter Your id";
 passs="Enter Your password";
 btn="Login";
  }
  isarab= !isarab;
  setState(() {
    
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(login),
        actions: [
          IconButton(onPressed: (){
            changelang();
          }, icon: Icon(Icons.translate))
        ],
      ),
      body: SafeArea(
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/hospital.jpg"),
                 Text(login,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: id,
                    validator: (v){
                        if (v==null || v.isEmpty) {
                          return "You must input a value";
                        }
                        return null;
                      },
                    decoration:  InputDecoration(
                      hintText: idd,
                      prefixIcon: const Icon(Icons.person)
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: pass,
                      validator: (v){
                        if (v==null || v.isEmpty) {
                          return "You must input a value";
                        }
                        return null;
                      },
                      obscureText: true,
                    decoration:  InputDecoration(
                      
                      hintText: passs,
                      prefixIcon: Icon(Icons.lock),
                      
                    ),
                ),
                  ),
                const SizedBox(height: 30,),
                  
                MainButton(width: 200, height: 40, text: btn,fun: (){
                  if (key.currentState!.validate()) {
                    if(id.text=="admin"&& pass.text=="admin"){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AdminList()));
                      }else{
                                        FirebaseFirestore.instance.collection("users").where("tag",isEqualTo: id.text).get().then((value){
                      if (value.docs.first.data()["tag"]==id.text && value.docs.first.data()["password"]==pass.text) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
                      } 
                      
                       else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Erorr in id or passwprd")));
                      }
                    });
                      }
    
                  }
                })
                  
              ],
            ),
          ),
        )
      
      ),
    );
  }
}
