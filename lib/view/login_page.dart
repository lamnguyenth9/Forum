import 'package:flutter/material.dart';
import 'package:forumapp/controller/authenlitication.dart';
import 'package:forumapp/view/register_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/input_widget.dart';
import 'package:get/get.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passlController = TextEditingController();
    final AuthenticationController _authenticationController=Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 236, 242),
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 201, 236, 242),
        centerTitle: true,
        toolbarHeight: 50,
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Welcome ',style: GoogleFonts.poppins(color: Colors.black, fontSize: size*0.08)
              ),
              TextSpan(
                text: 'back',style: GoogleFonts.poppins(color: Color.fromARGB(255, 48, 189, 217), fontSize: size*0.08)
              )
            ]
          ),
          )
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login Page",style: GoogleFonts.poppins(fontSize: size*0.080),),
              SizedBox(height: 15,),
              InputWidget(
                controller: _usernameController,
                hintText: 'username',
                obscureText: false,
                ),
              SizedBox(height: 30,),
              InputWidget(
                hintText: 'password', 
                controller: _passlController, 
                obscureText: true),
                SizedBox(height: 30,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(horizontal: 50)
                  ),
                  onPressed: ()async{
                    await _authenticationController.login(
                      username: _usernameController.text.trim(), 
                      password: _passlController.text.trim());
                  }, 
                  child: Obx(() {
                    return _authenticationController.isLoading.value
                    ? const Center(child: CircularProgressIndicator(color: Colors.white,),)
                    :Text('Login',
                  style: GoogleFonts.poppins(
                    fontSize: size*0.04,
                    color: Colors.white
                  ),
                  );
                  },)),
                  Padding(
                    padding: EdgeInsets.only(top:100),
                    child: Column(children: [
                      Text("You don't have account"),
                      Padding(
                        padding: EdgeInsets.only(top:10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(221, 57, 57, 57),
                    padding: EdgeInsets.symmetric(horizontal: 50)
                  ),
                          onPressed: (){
                           Get.to(()=>RegisterPage());
                          },
                          child: Text("Register",style: GoogleFonts.poppins(fontSize: size*0.02,color: Colors.white),),
                        ),
                        )
                    ]),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
