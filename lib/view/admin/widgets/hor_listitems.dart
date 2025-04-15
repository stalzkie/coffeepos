import 'package:flutter/material.dart';

class ListItem extends StatelessWidget{
  final String numToDisplay;
  final String message;
  final String mode;
  final String? prod_name;
  

  const ListItem.number({
    super.key,
    required this.numToDisplay,
    required this.message,
  }) : prod_name = null,
      mode = "number";

  const ListItem.product({
    super.key,
    required this.numToDisplay,
    required this.message,
    required this.prod_name
  }) : mode = "product";

  BoxDecoration _glassBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
    @override
  Widget build(BuildContext context) {
    if(mode == "number"){
      return Container(
        padding: EdgeInsets.all(10),
        width:150,
        decoration: _glassBoxDecoration(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child:Text(
                numToDisplay.toString(),
                style: TextStyle(
                  fontSize: 50
                )
              ),
            ),
            Row(
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize:14
                  )
                )
              ],
            )
          ],
        )
      );
    }else{
      return Container(
        padding: EdgeInsets.all(15),
        width:150,
        decoration: _glassBoxDecoration(),
        child: Column(
          children: [
            Text(
              prod_name ?? "no prod",
              style: TextStyle(
                fontSize: 14
              )
            ),
            Container(
              padding: EdgeInsets.all(28),
              child: Text(
                numToDisplay.toString(),
                style: TextStyle(
                  fontSize:35
                )
              ),
            ),
            Text(
              message,
              style: TextStyle(
                fontSize:14
              )
            )
          ]
        )
      );
    }
  }
}
