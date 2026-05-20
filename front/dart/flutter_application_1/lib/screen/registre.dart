import 'package:flutter/material.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:flutter_application_1/screen/login.dart';

import 'package:flutter_application_1/data/model/user.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';

class ReguistreScreen extends StatefulWidget{
  const ReguistreScreen({super.key});

  @override
  State<ReguistreScreen> createState() => _ReguistreState();
} 

class _ReguistreState extends State<ReguistreScreen>{

  Repository repository = Repository();
  String password = "";
  String message = "";
  int viviendaId = 0;
  User usuario = User(id: 0, email: "", nombre: "", password: "", rol: "");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("ProyectoFinal"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Nuevo Usuario", style: TextStyle(fontSize: 30)),
              Padding(
                padding: const EdgeInsetsGeometry.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text){
                    usuario.nombre = text;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsGeometry.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder()
                  ),
                  onChanged: (text){
                    usuario.email = text;
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
                    password = text;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsGeometry.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Codigo de vivienda",
                    border: OutlineInputBorder()
                  ),
                  onChanged: (text){
                    viviendaId = int.parse(text);
                  },
                ),
              ),
              errorMessage(message),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () => registre(usuario, password, viviendaId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.text,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3, // sombra ligera
                  ),
                  child: Text("Registrar"),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


  void registre(User user, String password, int viviendaId) async{
    final response = await repository.getRegistre(user, password, viviendaId);

    if (!mounted) return; // 🔥 clave

    if(response is User){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registro exitoso"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoguinScreen())
      );

    }else if(response is String){
      setState(() {
        message = response.toString();
      }); 
    }
  }

  Column errorMessage(String message) => Column(
    children: [
      Text(message)  
    ],
  );
}

  

