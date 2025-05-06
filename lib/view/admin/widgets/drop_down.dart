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
  List<String> buttonTexts = ["Inventory", "Sales", "Export CSV", "User Registration", "Dashboard", "Sign Out"];
  List<String?> routes = ["/inventory", "/transactions", '/export', "/users", "/dash", "/"];

  return ClipRect(
    child: AnimatedSize(
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 31, 31, 31),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.elliptical(30, 40),
            bottomRight: Radius.elliptical(30, 40),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!_isPressed) const SizedBox(height: 30),
            const Text(
              "sonofabean.",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Container(
              width: 120,
              height: 35,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.white,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isPressed = !_isPressed;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
                      minimumSize: const Size(110, 15),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      _isPressed ? "Close" : "More Actions",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            if (_isPressed) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: 230,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: _buttonNav(context, buttonTexts[index], routes[index]),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
}