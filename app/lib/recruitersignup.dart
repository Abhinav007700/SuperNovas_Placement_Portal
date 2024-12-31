import 'package:flutter/material.dart';
import 'details.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'recHome.dart';
import 'recruitersignup.dart';
import 'studentsignup.dart';

class RecSignup extends StatefulWidget {
  const RecSignup({Key? key}) : super(key: key);

  @override
  State<RecSignup> createState() => _RecSignupState();
}

class _RecSignupState extends State<RecSignup> {
  var ctrl1=TextEditingController();
  var ctrl2=TextEditingController();
  var ctrl3=TextEditingController();
  String usertype="Student";
  Color studentbuttonclr=Colors.pinkAccent;
  Color recbuttonclr=Colors.blue;
  bool hide=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Recruiter Signup"),),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueAccent.shade100,Colors.purple.shade100])
        ),
        child: SafeArea(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Card(
                margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
                child: Row(
                  children: [
                    SizedBox(width: 10.0,),
                    Icon(Icons.account_circle),
                    SizedBox(width: 30.0,),
                    Expanded(child:
                    TextField(
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: "Username/mail id",
                      ),
                      controller: ctrl1,
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Card(
                margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
                child: Row(
                  children: [
                    SizedBox(width: 10.0,),
                    Icon(Icons.lock_outline),
                    SizedBox(width: 30.0,),
                    Expanded(
                      child: TextField(
                        obscureText: hide,
                        decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          labelText: "Password",
                        ),
                        controller: ctrl2,
                      ),
                    ),
                    IconButton(onPressed: (){
                      setState(() {
                        hide=!hide;
                      });
                    }, icon: Icon(Icons.remove_red_eye_outlined),color: Colors.black,)
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Card(
                margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
                child: Row(
                  children: [
                    SizedBox(width: 10.0,),
                    Icon(Icons.lock_outline),
                    SizedBox(width: 30.0,),
                    Expanded(
                      child: TextField(
                        obscureText: hide,
                        decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          labelText: "Confirm Password",
                        ),
                        controller: ctrl3,
                      ),
                    ),
                    IconButton(onPressed: (){
                      setState(() {
                        hide=!hide;
                      });
                    }, icon: Icon(Icons.remove_red_eye_outlined),color: Colors.black,)
                  ],
                ),
              ),
              ElevatedButton(onPressed: (){

                if(ctrl1.text!= null && ctrl2.text!=null && ctrl3.text!=null){
                  if(ctrl2.text==ctrl3.text){
                    setState(() {
                      rdata.putIfAbsent(ctrl1.text, () => ctrl2.text);
                    });
                    Fluttertoast.showToast(
                        msg: "Registered!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM_LEFT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blueGrey.shade100,
                        textColor: Colors.black,
                        fontSize: 16.0);

                    Navigator.pop(context);
                  }
                }

                else{
                  //error box
                  Fluttertoast.showToast(
                      msg: "invalid credentials",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM_LEFT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blueGrey.shade100,
                      textColor: Colors.black,
                      fontSize: 16.0);
                }
              },
                child: Text("Submit"),
              ),


            ],

          ),
        ),
      ),

    );
  }
}

