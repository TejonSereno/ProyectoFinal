import 'package:flutter_application_1/screen/avisos.dart';
import 'package:flutter_application_1/screen/incidencias.dart';
import 'package:flutter_application_1/screen/usuarioDetalle.dart';
import 'package:flutter_application_1/screen/usuarios.dart';
import 'package:flutter_application_1/screen/viviendas.dart';
import 'package:flutter_application_1/screen/votaciones/votaciones.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/paleta/Colors.dart';
class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Pagina Principal"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.secondary,
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.secondary,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenido",
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          user.nombre,
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          user.email,
                          style: TextStyle(
                            color: AppColors.text.withOpacity(0.8),
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UsuariodetalleScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton(Icons.report, "Incidencias", IncidenciaScreen()),
              buildButton(Icons.poll, "Votaciones", VotacionScreen()),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton(Icons.person, "Usuarios", UsuarioScreen()),
              buildButton(Icons.home, "Viviendas", ViviendaScreen()),
            ],
          ),
          SizedBox(height: 20),
          buildButton(Icons.announcement, "Avisos", AvisosScreen()),
        ],
      ),
    );
  }
  
  Widget buildButton(IconData icon, String text, Widget screen) {
    return Container(
      width: 128,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.secondary, 
          width: 0.5
        ),
        boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2)
                    ),
                  ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        onPressed: () {
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => screen)
          );
        }, 
        child: Container(
          padding: EdgeInsets.only(bottom: 16.0, top: 16.0),
          child: Column(
            children: [
              Icon(icon, size: 35, color: AppColors.secondary),
              SizedBox(height: 2),
              Text(text, style: TextStyle(color: AppColors.text, fontSize: 15)),
            ],
          )
        )
      ),
    );
  }
}