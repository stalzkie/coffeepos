import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../viewmodels/user_vm.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen ({super.key});
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  final _supabase = Supabase.instance.client;
  bool _startedPressed = false;
  bool _loggingIn = false;
  final _loginFormKey = GlobalKey<FormState>();
  late UserViewModel _userVM;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _userVM = context.read<UserViewModel>();
    },);
  }

  void _handleLogin(String uuid) async{
    final role = await _userVM.getUserTypeByID(uuid);

    if(role == "Admin"){
      Navigator.pushNamed(context, '/dash');
    }else if(role == "Cashier"){
      Navigator.pushNamed(context, '/cashier');
    }
  }

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
                Form(
                  key: _loginFormKey,
                  child: Container(
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
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please enter your email";
                                }
                              },
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
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please enter your password";
                                }
                              },
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
                                if(_loginFormKey.currentState!.validate()){
                                  final AuthResponse res = await _supabase.auth.signInWithPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim()
                                  );

                                  if(res.user != null){
                                    final userID = res.user!.id;
                                    _handleLogin(userID);
                                  }
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
                  ),
                )
              ],
            )
          )
        )
      );
    }
  }
}
