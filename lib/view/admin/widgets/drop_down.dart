import "package:flutter/material.dart";

class DropDown extends StatefulWidget{
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown>{
  // bool _isPressed = false;
  // double _ddHeight = 50;
  bool _isPressed = false;

  Widget _buttonNav(BuildContext context, String buttonText, String? route) {
    return Container(
      height:35,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child:TextButton(
        onPressed: route != null ? () => Navigator.pushNamed(context, route) : null,
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 31, 31, 31),
          overlayColor: const Color.fromARGB(158, 41, 41, 41),
          minimumSize: Size(110,15)
        ),
        child: Text(buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14
          )
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {  
    if (!_isPressed){
      return Container(
        height: 134,
        width: double.infinity,
        padding:EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 31, 31, 31),
          borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(30, 40), bottomRight: Radius.elliptical(30, 40))
        ),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:30),
              Text(
                "sonofabean.",
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 14
                )
              ),
              SizedBox(height:8),
              Container(
                width: 120,
                height:35,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                        setState((){
                          _isPressed = true;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 31, 31, 31),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text("More Actions",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        )
                      )
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      );
    }else{
      List<String> buttonTexts = ["Inventory", "Sales", "Export CSV", "User Registration", "Dashboard" , "Sign Out"];
      List<String?> routes = ["/inventory", "/transactions", '/export', "/users", "/dash" , "/"];
      return Container(
        height: 525,
        width: double.infinity,
        padding:EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 31, 31, 31),
          borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(30, 40), bottomRight: Radius.elliptical(30, 40))
        ),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "sonofabean.",
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 14
                )
              ),
              SizedBox(height:8),
              Container(
                width: 120,
                height:35,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                        setState((){
                          _isPressed = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 31, 31, 31),
                        minimumSize: Size(110,15)
                      ),
                      child: const Text("Close",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        )
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height:16),
              SizedBox(
                height: 350,
                width: 230,
                child:ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: routes.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: EdgeInsets.only(bottom:15),
                      child: _buttonNav(context, buttonTexts[index], routes[index])
                    );
                  },
                )
              ),
            ],
          )
        ),
      );
    }
  }
}