import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'login.dart';
import 'details.dart';



class RecHome extends StatefulWidget {

  RecHome({Key? key}) : super(key: key);

  @override
  State<RecHome> createState() => _RecHomeState();
}

class _RecHomeState extends State<RecHome> {

  List<String> items=["Home","Applications","Recruited Candidates","Contact us","Settings"];
  int selectedIndex = 0;


  List<Widget> views=  [
    Expanded(
      child:Column(
        children: [
          Text("Welcome Google.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
          SizedBox(height: 30.0,),
          Expanded(flex: 3,
            child: Container(
              color: Colors.white54,
            ),
          )
        ],
      ),
    ),
    Expanded(
      child:Column(
        children: [
          Text("Applications.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text(" Name  "),color: Colors.pinkAccent.shade100,),
              Card(child: Text(" CGPA  "),color: Colors.pinkAccent.shade100,),
              Card(child: Text(" Resume"),color: Colors.pinkAccent.shade100,),
              Card(child: Text(" Status"),color: Colors.pinkAccent.shade100,),
            ],
          ),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text("Nithin"),),
              Card(child: Text(" 9.5  "),),
              Card(child: Text("106121086.pdf"),),
              Card(child: Text("Pending"),color: Colors.amber,),
            ],
          ),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text("Abhinav"),),
              Card(child: Text(" 9.8  "),),
              Card(child: Text("106121030.pdf"),),
              Card(child: Text(" Approved   "),color: Colors.green,),
            ],
          ),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text("Nawfal"),),
              Card(child: Text(" 8.5  "),),
              Card(child: Text("106121078.pdf"),),
              Card(child: Text("  Rejected   "),color: Colors.red.shade200,),
            ],
          ),


        ],
      ),
    ),
    Expanded(
      child:Column(
        children: [
          Text("Your Profile.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text("  Name  "),color: Colors.pinkAccent.shade100,),
              //Card(child: Text("  Round    "),),
              Card(child: Text(" View Resume"),color: Colors.pinkAccent.shade100,),
            ],
          ),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text(" Nithin"),),
              Card(child: Text("106121086.pdf"),),
            ],
          ),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text("Abhinav"),),

              Card(child: Text("106121030.pdf"),),

            ],
          ),


        ],
      ),
    ),
    Expanded(
        child:Column(
          children: [
            Text("Contact Us.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
            SizedBox(height: 6.0,),
            Card(child: Row(
              children: [
                Icon(Icons.call),
                Text("+91 90909 09090"),
              ],
            ),),
            SizedBox(height: 6.0,),
            Card(child: Row(
              children: [
                Icon(Icons.mail),
                Text("placements@nitt.edu"),
              ],
            ),
            ),
          ],
        )
    ),
    Expanded(
      child:Column(
        children: [
          Text("Settings.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
          SizedBox(height: 16.0,),
          Card(child: Text("  Change Password:  "),),
          SizedBox(height: 16.0,),
          Card(child: Text("   Edit Resume:     "),),
          SizedBox(height: 16.0,),
          Card(child: Text("   Edit Profile:    "),),


        ],
      ),
    ),
  ];
  String uid='106121086';
  String Name=studentName['106121086'];


  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text (items[selectedIndex]),),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueAccent.shade100,Colors.purple.shade100])
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Pretty similar to the BottomNavigationBar!
            SideNavigationBar(
              selectedIndex: selectedIndex,
              items:  [
                SideNavigationBarItem(

                  icon: Icons.home,
                  label: 'Home',
                ),
                SideNavigationBarItem(
                  icon: Icons.receipt,
                  label: 'Applications',
                ),
                SideNavigationBarItem(
                  icon: Icons.account_circle,
                  label: 'Recruited Candidates',
                ),
                SideNavigationBarItem(
                  icon: Icons.phone,
                  label: 'Contact Us',
                ),
                SideNavigationBarItem(
                  icon: Icons.settings,
                  label: 'Settings',
                ),
                SideNavigationBarItem(
                  icon: Icons.logout,
                  label: 'LogOut',
                ),

              ],
              onTap: (index) {
                setState(() {
                  if(index==5){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage ()));
                  }
                  else{
                    selectedIndex = index;
                  }
                });
              },
            ),

            //expanded wid
            views.elementAt(selectedIndex),

          ],
        ),
      ),
    );
  }
}


