import 'package:flutter/material.dart';
import 'details.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'recHome.dart';

import 'signup.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var ctrl1=TextEditingController();
  var ctrl2=TextEditingController();
  String usertype="Student";
  Color studentbuttonclr=Colors.pinkAccent;
  Color recbuttonclr=Colors.blue;
  bool hide=true;

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(title: Text("Login"),),
    body: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blueAccent.shade100,Colors.purple.shade100])
    ),
      child: SafeArea(

          child: Column(// main column of the page
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("$usertype Login",style: TextStyle(fontSize: 22.0),),//heading

              Card(
                margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),//username box
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
              ElevatedButton(onPressed: (){//submit button

                if(usertype=="Student" && data[ctrl1.text]==ctrl2.text){
                  //go to the home page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage ()),
                    );
                }
                else if(usertype=="Recruiter" && rdata[ctrl1.text]==ctrl2.text) {
                  //go to the home page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RecHome()),
                  );
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

                  Text("Not yet registered?..then"),
                  TextButton(onPressed: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );

                  }, child:
                  Text("Signup",style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),))
                ],
              )
            ],

          ),
      ),
    ),

    );
  }
}
