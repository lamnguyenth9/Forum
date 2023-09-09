import 'package:flutter/material.dart';
import 'package:forumapp/controller/authenlitication.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/input_widget.dart';
class   RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passlController = TextEditingController();
  final AuthenticationController _authenticationController =Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 201, 236, 242),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Register Page",style: GoogleFonts.poppins(fontSize: size*0.080),),
              SizedBox(height: 15,),
              InputWidget(
                controller: _nameController,
                hintText: 'name',
                obscureText: false,
                ),
              SizedBox(height: 30,),
              InputWidget( 
                hintText: 'username', 
                controller: _usernameController, 
                obscureText: false),
                SizedBox(height: 30,),
                InputWidget(
                hintText: 'email', 
                controller: _emailController, 
                obscureText: false),
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
                    await _authenticationController.register(
                      name: _nameController.text.trim(), 
                      username: _usernameController.text.trim(), 
                      email: _emailController.text.trim(), 
                      password: _passlController.text.trim());
                  }, 
                  child: Obx(() {
                    return _authenticationController.isLoading.value?
                  const  Center(child: CircularProgressIndicator(
                    color: Colors.white,
                  ),):
                    Text('Sign in',
                  style: GoogleFonts.poppins(
                    fontSize: size*0.04,
                    color: Colors.white
                  ),
                  );
                  })),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: TextButton(
                      child: Text('Login',style: GoogleFonts.poppins(color: Colors.black, fontSize: size*0.04),),
                      onPressed: (){},
                    ),
                    )
                  
            ],
          ),
        ),
      ),
    );
  }
}
