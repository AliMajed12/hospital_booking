import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital/Screens/home.dart';
import 'package:hospital/Screens/login.dart';
import 'package:hospital/widgets/button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
var key = GlobalKey<FormState>();
var id = TextEditingController();
var pass = TextEditingController();
var repass = TextEditingController();
bool isarab=false;

String login="انشاء حساب";
String idd="أدخل رقم الملف الخاص بك";
String passs="أدخل رمزك السري";
String repasss="اعد أدخال رمزك السري";
String btn="انشاء حساب";

changelang(){
  
  if (isarab) {
 login="انشاء حساب";
 idd="أدخل رقم الملف الخاص بك";
 repasss="اعد أدخال رمزك السري";
 passs="أدخل رمزك السري";
 btn="انشاء حساب";
  } else {
     login="sign up";
 idd="Enter Your id";
 passs="Enter Your password";
repasss="reEnter Your password";
 btn="sign up";
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
          key:key ,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/hospital2.jpg"),
                 Text(login,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (v){
                      if (v==null || v.isEmpty) {
                        return "You must input a value";
                      }
                      return null;
                    },
                    controller: id,
                    decoration:  InputDecoration(
                      hintText: idd,
                      prefixIcon: Icon(Icons.person)
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (v){
                      if (v==null || v.isEmpty) {
                        return "You must input a value";
                      }
                      return null;
                    },
                    controller: pass,
          
                      obscureText: true,
                    decoration:  InputDecoration(
                      
                      hintText: passs,
                      prefixIcon: Icon(Icons.lock),
                      
                    ),
                ),
                  ),
                    const SizedBox(height: 30,),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (v){
                      if (v==null || v.isEmpty) {
                        return "You must input a value";
                      }
                      if (pass.text!=repass.text) {
                        return "passwords must be the same";
                      }
                      return null;
                    },
                    controller: repass,
          
                      obscureText: true,
                    decoration:  InputDecoration(
                      
                      hintText: repasss,
                      prefixIcon: Icon(Icons.lock),
                      
                    ),
                ),
                  ),
                const SizedBox(height: 30,),
                  
                  MainButton(width: 200, height: 40, text: btn, fun: (){
                    if (key.currentState!.validate()) {
                      FirebaseFirestore.instance.collection("users").add({
                        "tag":id.text,
                        "password":pass.text
                      }).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home())));
                    }
                  }),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: const Text("Have an account?",style: TextStyle(fontStyle: FontStyle.italic),))
              ],
            ),
          ),
        )
      
      ),
    );
  }
}
