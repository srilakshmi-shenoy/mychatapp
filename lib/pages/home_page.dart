import 'package:flutter/material.dart';
import 'package:mychatapp/components/my_drawer.dart';
import 'package:mychatapp/components/user_tile.dart';
import 'package:mychatapp/services/auth/auth_service.dart';
import 'package:mychatapp/pages/chat_page.dart';
import 'package:mychatapp/services/chat/chat_services.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat & auth service

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,

      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        //error

        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading...

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        //return list view
        return ListView(
          children: snapshot.data!
                .map<Widget>((userData) =>
              _buildUserListItem(userData,context)).toList(),

        );
      },
    );
  }

    // build individual list tile for user

    Widget _buildUserListItem(
  Map<String, dynamic> userData, BuildContext context)
    {
      //display all user except current user
      if( userData["email"]!= _authService.getCurrentUser()!.email){
        return UserTile(
          text: userData["email"],
          onTap: () {
          //tapped on a user -> go to chat page

            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
                ),
            ),);
          },
        );
      }
      else{
        return Container();

      }

      }
  }

