import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'login.dart';
import 'details.dart';



class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> items=["Home","Profile","Placement Record","Contact us","Settings"];
  int selectedIndex = 0;

  List<Widget> views=  [
  Expanded(
    child:Column(
      children: [
        Text("Welcome Nithin.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
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
          Text("Your Profile.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
          SizedBox(height: 6.0,),
          SizedBox(
            width: double.infinity,
            child: Card(child: Text("Name:"),),),
          SizedBox(height: 6.0,),
      SizedBox(
        width: double.infinity,
        child: Card(child: Text("Dept:"),),
      ),
          SizedBox(height: 6.0,),
      SizedBox(
        width: double.infinity,
        child: Card(child: Text("Rollno:"),),
      ),
          SizedBox(height: 6.0,),
      SizedBox(
        width: double.infinity,
        child: Card(child: Text("Degree:"),),
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
              Card(child: Text("  Company  "),color: Colors.pinkAccent.shade100,),
              Card(child: Text("  Round    "),color: Colors.pinkAccent.shade100,),
              Card(child: Text("  Status   "),color: Colors.pinkAccent.shade100,),
            ],
          ),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text("Microsoft"),),
              Card(child: Text("     1   "),),
              Card(child: Text("  Pass   "),),
            ],
          ),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text("  Amazon  "),),
              Card(child: Text("     2   "),),
              Card(child: Text("  Pending"),),
            ],
          ),
          SizedBox(height: 6.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(child: Text("  Apple   "),),
              Card(child: Text("    1     "),),
              Card(child: Text(" Pending  "),),
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
          Card(child: Text("  Change Password:  "),color: Colors.pinkAccent.shade100,),
          SizedBox(height: 16.0,),
          Card(child: Text("   Edit Resume:     "),color: Colors.pinkAccent.shade100,),
          SizedBox(height: 16.0,),
          Card(child: Text("   Edit Profile:    "),color: Colors.pinkAccent.shade100,),


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
                    icon: Icons.account_circle,
                    label: 'Profile',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.receipt,
                    label: 'Placement Record',
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


