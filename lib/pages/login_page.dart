import 'package:mychatapp/services/auth/auth_service.dart';
import 'package:mychatapp/components/my_button.dart';
import 'package:mychatapp/components/my_textfield.dart';
import 'package:mychatapp/main.dart';
import 'package:flutter/material.dart';
import 'package:mychatapp/pages/login_page.dart';

void main(){
  runApp(const MyApp());
}

class LoginPage extends StatelessWidget {

  //email and pw text controllers

  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //tap to go to register page

  final void Function()? onTap;
   LoginPage({super.key,required this.onTap});

   //login Method

  void login(BuildContext context) async{
    
    // auth service
    
    final authService =AuthService();
    //try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text, _pwController.text,);
    }
    //catch any errors
    
    catch(e){
      showDialog(context: context,
        builder: (context)=>AlertDialog(
          title: Text(e.toString()),
        ),);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [

          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),
          //welcome back message
          Text("Welcome Back! You will be missed",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),),

          const SizedBox(height: 25),



          //email textfield

          MyTextfield(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,

          ),

          //pw textfield

          MyTextfield(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
          ),

          const SizedBox(height: 25),

          //login button

          MyButton(
            text: "Login",
            onTap: () => login(context),

          ),
          //register now
          const SizedBox(height: 25),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not a member?",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text("Register Now", style: TextStyle(
                fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary
              ),),
              ),

            ],
          ),


        ],
        ),
      ),
    );

  }
}
