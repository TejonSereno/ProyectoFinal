import 'package:flutter/material.dart';
import 'package:flutter_application_1/paleta/Colors.dart';
import 'package:flutter_application_1/screen/registre.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/data/model/loguin/user.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/screen/home.dart';

class LoguinScreen extends StatefulWidget{
  const LoguinScreen({super.key});

  @override
  State<LoguinScreen> createState() => _LoguinState();
} 

class _LoguinState extends State<LoguinScreen>{

  String email = "";
  String password = "";
  User usuario = User(id: 0, email: "", nombre: "", rol: "");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("ProyectFinal"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Inicio Sesion", style: TextStyle(fontSize: 30)),
              Padding(
                padding: const EdgeInsetsGeometry.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder()
                  ),
                  onChanged: (text){
                    setState(() {
                      email= text;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsGeometry.all(8.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Contraseña",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text){
                    setState(() {
                      password = text;
                    });
                  },
                ),
              ),
              Consumer<UserProvider>(
                builder: (context, provider, child) {
                  if (provider.error.isEmpty) {
                    return SizedBox.shrink();
                  }

                  return Text(
                    provider.error,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: () => logIn(email, password),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.text,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 3, // sombra ligera
                      ),
                      child: Text("LogIn"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ReguistreScreen())
                        )
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: AppColors.text,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 3, // sombra ligera
                      ),
                      child: Text("Registrarse"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  void logIn(String email, String password) async {
    await Provider.of<UserProvider>(
      context,
      listen: false,
    ).login(email, password);

    if (!mounted) return;

    final provider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    if (provider.user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }
}

  

