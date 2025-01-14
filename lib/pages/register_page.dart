import 'package:flutter/material.dart';
import 'package:mychatapp/services/auth/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {

  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final void Function()? onTap;


  RegisterPage({super.key,required this.onTap});

  //register method

  void register(BuildContext context){
    //get auth service

    final _auth = AuthService();

    // passwords match then create user
    if (_pwController.text == _confirmPwController.text){
      try{
        _auth.signUpEmailPassword(_emailController.text,
        _pwController.text,
        );
      } catch(e){
        showDialog(context: context,
          builder: (context)=>AlertDialog(
            title: Text(e.toString()),
          ),);

      }
    }

    // if passwords dont match show error

    else{
      showDialog(context: context,
        builder: (context)=>AlertDialog(
          title: Text("Passwords don't match!"),
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
            Text("Let's create an account for you",
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

            // confirm pw textfield

            MyTextfield(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),

            MyTextfield(
              hintText: "Confirm Passoword",
              obscureText: true,
              controller: _confirmPwController,
            ),

            const SizedBox(height: 25),

            //login button

            MyButton(
              text: "Register",
              onTap: () => register(context),

            ),
            //register now
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                child: Text("Login now", style: TextStyle(
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
