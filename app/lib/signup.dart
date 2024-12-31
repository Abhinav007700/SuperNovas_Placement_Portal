import 'package:flutter/material.dart';
import 'details.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'recHome.dart';


import 'login.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var ctrl1=TextEditingController();
  var ctrl2=TextEditingController();
  var name=TextEditingController();
  var ctrl3=TextEditingController();
  String usertype="Student";
  Color studentbuttonclr=Colors.pinkAccent;
  Color recbuttonclr=Colors.blue;
  bool hide=true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(title: Text("Student Signup"),),
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
              Text("$usertype Signup",style: TextStyle(fontSize: 22.0),),//heading
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
                        labelText: "Username",
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
                    Icon(Icons.contact_page_outlined),
                    SizedBox(width: 30.0,),
                    Expanded(child:
                    TextField(
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: "Name",
                      ),
                      controller: name,
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

                if(ctrl1.text!= null && ctrl2.text!=null && ctrl3.text!=null && name.text!=null){
                  if(ctrl2.text==ctrl3.text){
                    setState(() {
                      if(usertype=='Student'){
                        data.putIfAbsent(ctrl1.text, () => ctrl2.text);
                        studentName[ctrl1.text]=name.text;
                      }
                      else{
                        rdata.putIfAbsent(ctrl1.text, () => ctrl2.text);
                        rName[ctrl1.text]=name.text;
                      }
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


              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  ElevatedButton(

                    onPressed: (){

                      setState(() {
                        usertype="Student";
                        studentbuttonclr=Colors.pinkAccent;
                        recbuttonclr=Colors.blue;
                      });
                    },
                    child: Text("Im a Student"),
                    style: ButtonStyle( backgroundColor: MaterialStateProperty.all(studentbuttonclr)),),
                  SizedBox(width: 10.0,),

                  ElevatedButton(

                    onPressed: (){

                      setState(() {
                        usertype="Recruiter";
                        recbuttonclr=Colors.pinkAccent;
                        studentbuttonclr=Colors.blue;
                      });
                    },
                    child: Text("Im a Recruiter"),
                    style: ButtonStyle( backgroundColor: MaterialStateProperty.all(recbuttonclr)),
                  ),

                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Already registered?..then "),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child:
                  Text("Login",style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),))
                ],
              )
            ],

          ),
        ),
      ),

    );
  }
}

