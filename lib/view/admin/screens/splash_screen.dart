import 'package:coffee_inventory_app/view/admin/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen ({super.key});
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  final _supabase = Supabase.instance.client;
  bool _startedPressed = false;
  bool _loggingIn = false;
  
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    if(!_startedPressed){
      return Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(color: const Color(0xFFF2F2F2)),
            child: Stack(
              children: [
                 Container(
                    width: 393,
                    height: 852,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Text(
                                  'sonofabean.',
                                  style: TextStyle(
                                    color: const Color(0xFF1E1E1E),
                                    fontSize: 14,
                                    fontFamily: 'Figtree',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 115,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 2,
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
                                      _startedPressed = true;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    fixedSize: Size(115,38),
                                    textStyle: TextStyle(fontSize: 15),
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: const Text("Get Started",
                                    style: TextStyle(
                                      color: Colors.black,
                                    )
                                  )
                                ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }else if(_startedPressed & !_loggingIn){
      return Center(
        child: Container(
          decoration: BoxDecoration(color: const Color(0xFFE7E7E9)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Container(
                child: Column(  
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 99,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                'sonofabean.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Figtree',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 627,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: const Color(0xFFE7E7E9)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                'Choose User Type:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Figtree',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Container(
                                  width: 115,
     
                                  padding: const EdgeInsets.all(10),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        strokeAlign: BorderSide.strokeAlignOutside,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 10,
                                    children: [
                                      Text(
                                        'Customer',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF1E1E1E),
                                          fontSize: 14,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 115,           
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        strokeAlign: BorderSide.strokeAlignOutside,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: TextButton(
                                        onPressed: (){
                                          setState((){
                                            _loggingIn = true;
                                          });
                                        },

                                        style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(fontSize: 14),
                                          backgroundColor: Colors.white,
                                        ),

                                        child: const Text("Admin/Staff",
                                          style: TextStyle(
                                            color: Colors.black,
                                          )
                                        )
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ); 
    } else {
      return Scaffold(
        body: Center(
        child: Container(
          decoration: BoxDecoration(color: const Color(0xFFE7E7E9)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              
              Container(
                width: 393,
                height: 726,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 99,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                'sonofabean.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Figtree',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
     
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: const Color(0xFFE7E7E9)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 170,
                        children: [
                          TextButton(
                            onPressed: (){
                              setState(() {
                                _loggingIn = false;
                              });                        
                            },

                            child:Container(
                            width: 36,
                            height: 36,
    
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Text(
                                  "<",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                  )
                                ),
                              ],
                            ),
                          ),
                          ),
                          
                          Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 16,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 10,
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Figtree',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(
                                              width: 500,
                                              height: 52,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFF525252),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextField(
                                                      controller: _emailController,
                                                      decoration: const InputDecoration(
                                                        border: InputBorder.none, // removes the Outline border entirely
                                                        hintText: "Enter Email",
                                                        hintStyle:TextStyle(
                                                          color: Color.fromARGB(255, 121, 121, 121)
                                                        ),
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                                      ),
                                                      style: TextStyle(color: Colors.white), // optional
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Figtree',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        width: 500,
                                        height: 52,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF525252),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                obscureText: true,
                                                controller: _passwordController,
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none, // removes the Outline border entirely
                                                  hintText: "Enter Password",
                                                  hintStyle:TextStyle(
                                                    color: Color.fromARGB(255, 121, 121, 121)
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                                ),
                                                style: TextStyle(color: Colors.white), // optional
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    spacing: 10,
                                    children: [
                                      Container(
                                        width: 115,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF62FF6D),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 2,
                                              strokeAlign: BorderSide.strokeAlignOutside,
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          spacing: 10,
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                final AuthResponse res = await _supabase.auth.signInWithPassword(
                                                  email: _emailController.text.trim(),
                                                  password: _passwordController.text.trim()
                                                );

                                                if(res.user != null){
                                                  Navigator.push(
                                                    context, MaterialPageRoute(builder: (context) => DashboardScreen())
                                                  );
                                                }
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: const Color(0xFF62FF6D),
                                              ),
                                              child: const Text("Sign In",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                )
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 115,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 2,
                                              strokeAlign: BorderSide.strokeAlignOutside,
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          spacing: 10,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context, "/cashier");
                                              },
                                              child: const Text("Staff",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                )
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
      );
      
    }
  }

  
}
