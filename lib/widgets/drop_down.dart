import "package:flutter/material.dart";

class DropDown extends StatelessWidget{
  final bool _isPressed = false;
  final double _ddHeight = 50;

  DropDown({super.key});
  void _buttonPressed(){

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      width: double.infinity,
      padding:EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(25)
      ),
      child: SizedBox(
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                
              ),
              onPressed: _buttonPressed,
              child: SizedBox(
                width:80,
                height:40,
                child: Text(
                  "sonofabean.",
                  style: TextStyle(
                    color:Colors.black,
                  )),
              )
            )
          ],
        )
      ),
    );
  }
}