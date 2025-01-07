import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InvalidTicketPage extends StatefulWidget{

  InvalidTicketState createState()=>InvalidTicketState();
}
class InvalidTicketState extends State<InvalidTicketPage>{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: LayoutBuilder(builder: (context,consraint){
          double screenHeight = MediaQuery.sizeOf(context).height;

          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple)
            ),

            margin: EdgeInsets.fromLTRB(0, screenHeight*0.3, 0, 0), child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Error: Tiket ID tidak ditemukan"),
            TextButton.icon(onPressed: (){
              context.go("/tiket");
            }, icon: Icon(Icons.check,color: Colors.purple,), label: Text("OK") )
          ],),);
        }  ),
      ),
    );
  }
}