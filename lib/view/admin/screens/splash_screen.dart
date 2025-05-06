import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen ({super.key});
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  final _supabase = Supabase.instance.client;
  bool _startedPressed = false;
  bool _loggingIn = false;

  @override
  Widget build(BuildContext context){
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    if(!_startedPressed){
      return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero
                ),
                onPressed: (){
                  setState((){
                    _startedPressed = true;
                  });
                },
                child: Container(
                  width:115,
                  height:45,
                  decoration: BoxDecoration(
                    border: Border.all(width:2),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.black
                      )
                    )
                  )
                )
              )
            ],
          ),
        )
      );
    }else if(_startedPressed & !_loggingIn){
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height:99,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                  ),
                  color: Colors.black
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "sonofabean.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
                      )
                    ),
                    SizedBox(height:10)
                  ],
                )
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Choose User Type:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, "/menu");
                          },
                          child: Container(
                            width: 115,
                            height:45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width:2)
                            ),
                            child:Center(
                              child: Text(
                                "Guest",
                                style: TextStyle(
                                  color: Colors.black
                                )  
                              )
                            )
                          )
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero
                          ),
                          onPressed: (){
                            setState(() {
                              _loggingIn = true;
                            });
                          },
                          child: Container(
                            width: 115,
                            height:45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width:2)
                            ),
                            child:Center(
                              child: Text(
                                "Staff",
                                style: TextStyle(
                                  color: Colors.black
                                )  
                              )
                            )
                          )
                        )
                      ],
                    )
                  ],
                )
              )
            ],
          )
        )
      ); 
    } else {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 233),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height:99,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)
                    ),
                    color: Colors.black
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "sonofabean.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        )
                      ),
                      SizedBox(height:10)
                    ],
                  )
                ),
                SizedBox(height:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero
                        ),
                        onPressed: (){
                          setState((){
                            _loggingIn = false;
                          });
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        )
                      )
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height:500,
                  child: Padding(
                    padding: EdgeInsets.only(left: 35, right: 45),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          )
                        ),
                        SizedBox(height:5),
                        SizedBox(
                          height: 60,
                          child:TextFormField(
                            controller: _emailController,
                            cursorColor: Colors.white60,
                            decoration: InputDecoration(
                              hintText: "Enter Email...",
                              hintStyle: TextStyle(
                                color: Colors.white60
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 83, 83, 83),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height:10),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          )
                        ),
                        SizedBox(height:5),
                        SizedBox(
                          height: 60,
                          child:TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            cursorColor: Colors.white60,
                            decoration: InputDecoration(
                              hintText: "Enter Password...",
                              hintStyle: TextStyle(
                                color: Colors.white60
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 83, 83, 83),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height:5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero
                            ),
                            onPressed: () async {
                              final AuthResponse res = await _supabase.auth.signInWithPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim()
                              );

                              if(res.user != null){
                                Navigator.pushNamed(
                                  context, "/dash"
                                );
                              }
                            },
                            child: Container(
                              width:115,
                              height:45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.green[400],
                                border: Border.all(width:1)
                              ),
                              child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.black
                                  )
                                )
                              )
                            )
                          )
                        ),
                      ],
                    )
                  ) 
                )
              ],
            )
          )
        )
        
        
        // Center(
        // child: SingleChildScrollView(
        //   child:Container(
        //     decoration: BoxDecoration(color: const Color(0xFFE7E7E9)),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       spacing: 10,
        //       children: [
        //         Container(
        //           width: 393,
        //           height: 726,
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             spacing: 10,
        //             children: [
        //               Container(
        //                 width: double.infinity,
        //                 height: 99,
        //                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        //                 clipBehavior: Clip.antiAlias,
        //                 decoration: ShapeDecoration(
        //                   color: const Color(0xFF1E1E1E),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.only(
        //                       bottomLeft: Radius.circular(50),
        //                       bottomRight: Radius.circular(50),
        //                     ),
        //                   ),
        //                 ),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   spacing: 10,
        //                   children: [
        //                     Row(
        //                       mainAxisSize: MainAxisSize.min,
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       spacing: 10,
        //                       children: [
        //                         Text(
        //                           'sonofabean.',
        //                           style: TextStyle(
        //                             color: Colors.white,
        //                             fontSize: 14,
        //                             fontFamily: 'Figtree',
        //                             fontWeight: FontWeight.w600,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Container(
        //                 width: double.infinity,
      
        //                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        //                 clipBehavior: Clip.antiAlias,
        //                 decoration: BoxDecoration(color: const Color(0xFFE7E7E9)),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.end,
        //                   spacing: 170,
        //                   children: [
        //                     TextButton(
        //                       onPressed: (){
        //                         setState(() {
        //                           _loggingIn = false;
        //                         });                        
        //                       },

        //                       child:Container(
        //                       width: 36,
        //                       height: 36,
      
        //                       clipBehavior: Clip.antiAlias,
        //                       decoration: ShapeDecoration(
        //                         shape: RoundedRectangleBorder(
        //                           side: BorderSide(
        //                             width: 2,
        //                             strokeAlign: BorderSide.strokeAlignOutside,
        //                           ),
        //                           borderRadius: BorderRadius.circular(100),
        //                         ),
        //                       ),
        //                       child: Column(
        //                         mainAxisSize: MainAxisSize.min,
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         crossAxisAlignment: CrossAxisAlignment.center,
        //                         spacing: 10,
        //                         children: [
        //                           Text(
        //                             "<",
        //                             style: TextStyle(
        //                               color: Colors.black,
        //                               fontSize: 24,
        //                             )
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                     ),
                            
        //                     Container(
        //                       width: double.infinity,
        //                       child: Column(
        //                         mainAxisSize: MainAxisSize.min,
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         spacing: 16,
        //                         children: [
        //                           Container(
        //                             width: double.infinity,
        //                             child: Column(
        //                               mainAxisSize: MainAxisSize.min,
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               crossAxisAlignment: CrossAxisAlignment.start,
        //                               spacing: 10,
        //                               children: [
        //                                 Container(
        //                                   width: double.infinity,
        //                                   child: Column(
        //                                     mainAxisSize: MainAxisSize.min,
        //                                     mainAxisAlignment: MainAxisAlignment.start,
        //                                     crossAxisAlignment: CrossAxisAlignment.start,
        //                                     spacing: 10,
        //                                     children: [
        //                                       Text(
        //                                         'Email',
        //                                         style: TextStyle(
        //                                           color: Colors.black,
        //                                           fontSize: 14,
        //                                           fontFamily: 'Figtree',
        //                                           fontWeight: FontWeight.w600,
        //                                         ),
        //                                       ),
        //                                       Container(
        //                                         width: 500,
        //                                         height: 52,
        //                                         clipBehavior: Clip.antiAlias,
        //                                         decoration: ShapeDecoration(
        //                                           color: const Color(0xFF525252),
        //                                           shape: RoundedRectangleBorder(
        //                                             borderRadius: BorderRadius.circular(10),
        //                                           ),
        //                                         ),
        //                                         child: Row(
        //                                           children: [
        //                                             Expanded(
        //                                               child: TextField(
        //                                                 controller: _emailController,
        //                                                 decoration: const InputDecoration(
        //                                                   border: InputBorder.none, // removes the Outline border entirely
        //                                                   hintText: "Enter Email",
        //                                                   hintStyle:TextStyle(
        //                                                     color: Color.fromARGB(255, 121, 121, 121)
        //                                                   ),
        //                                                   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        //                                                 ),
        //                                                 style: TextStyle(color: Colors.white), // optional
        //                                               ),
        //                                             ),
        //                                           ],
        //                                         ),
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                           Container(
        //                             width: double.infinity,
        //                             child: Column(
        //                               mainAxisSize: MainAxisSize.min,
        //                               mainAxisAlignment: MainAxisAlignment.start,
        //                               crossAxisAlignment: CrossAxisAlignment.start,
        //                               spacing: 10,
        //                               children: [
        //                                 Text(
        //                                   'Password',
        //                                   style: TextStyle(
        //                                     color: Colors.black,
        //                                     fontSize: 14,
        //                                     fontFamily: 'Figtree',
        //                                     fontWeight: FontWeight.w600,
        //                                   ),
        //                                 ),
        //                                 Container(
        //                                   width: 500,
        //                                   height: 52,
        //                                   clipBehavior: Clip.antiAlias,
        //                                   decoration: ShapeDecoration(
        //                                     color: const Color(0xFF525252),
        //                                     shape: RoundedRectangleBorder(
        //                                       borderRadius: BorderRadius.circular(10),
        //                                     ),
        //                                   ),
        //                                   child: Row(
        //                                     children: [
        //                                       Expanded(
        //                                         child: TextField(
        //                                           obscureText: true,
        //                                           controller: _passwordController,
        //                                           decoration: const InputDecoration(
        //                                             border: InputBorder.none, // removes the Outline border entirely
        //                                             hintText: "Enter Password",
        //                                             hintStyle:TextStyle(
        //                                               color: Color.fromARGB(255, 121, 121, 121)
        //                                             ),
        //                                             contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        //                                           ),
        //                                           style: TextStyle(color: Colors.white), // optional
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 )
        //                               ],
        //                             ),
        //                           ),
        //                           Container(
        //                             width: double.infinity,
        //                             padding: const EdgeInsets.all(10),
        //                             clipBehavior: Clip.antiAlias,
        //                             decoration: BoxDecoration(),
        //                             child: Row(
        //                               mainAxisSize: MainAxisSize.min,
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               crossAxisAlignment: CrossAxisAlignment.center,
        //                               spacing: 10,
        //                               children: [
        //                                 Container(
        //                                   width: 115,
        //                                   clipBehavior: Clip.antiAlias,
        //                                   decoration: ShapeDecoration(
        //                                     color: const Color(0xFF62FF6D),
        //                                     shape: RoundedRectangleBorder(
        //                                       side: BorderSide(
        //                                         width: 2,
        //                                         strokeAlign: BorderSide.strokeAlignOutside,
        //                                       ),
        //                                       borderRadius: BorderRadius.circular(30),
        //                                     ),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisSize: MainAxisSize.min,
        //                                     mainAxisAlignment: MainAxisAlignment.center,
        //                                     crossAxisAlignment: CrossAxisAlignment.center,
        //                                     spacing: 10,
        //                                     children: [
        //                                       TextButton(
        //                                         onPressed: () async {
        //                                           final AuthResponse res = await _supabase.auth.signInWithPassword(
        //                                             email: _emailController.text.trim(),
        //                                             password: _passwordController.text.trim()
        //                                           );

        //                                           if(res.user != null){
        //                                             Navigator.pushNamed(
        //                                               context, "/dash"
        //                                             );
        //                                           }
        //                                         },
        //                                         style: TextButton.styleFrom(
        //                                           backgroundColor: const Color(0xFF62FF6D),
        //                                         ),
        //                                         child: const Text("Sign In",
        //                                           style: TextStyle(
        //                                             color: Colors.black,
        //                                           )
        //                                         )
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                                 Container(
        //                                   width: 115,
        //                                   clipBehavior: Clip.antiAlias,
        //                                   decoration: ShapeDecoration(
        //                                     shape: RoundedRectangleBorder(
        //                                       side: BorderSide(
        //                                         width: 2,
        //                                         strokeAlign: BorderSide.strokeAlignOutside,
        //                                       ),
        //                                       borderRadius: BorderRadius.circular(30),
        //                                     ),
        //                                   ),
        //                                   child: Row(
        //                                     mainAxisSize: MainAxisSize.min,
        //                                     mainAxisAlignment: MainAxisAlignment.center,
        //                                     crossAxisAlignment: CrossAxisAlignment.center,
        //                                     spacing: 10,
        //                                     children: [
        //                                       TextButton(
        //                                         onPressed: () {
        //                                           Navigator.pushNamed(context, "/cashier");
        //                                         },
        //                                         child: const Text("Staff",
        //                                           style: TextStyle(
        //                                             color: Colors.black,
        //                                           )
        //                                         )
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ),
        // )
      );
    }
  }
}
