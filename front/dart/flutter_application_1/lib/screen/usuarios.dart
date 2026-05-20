import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/data/providers/usuario_provider.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';


class UsuarioScreen extends StatefulWidget{
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioState();
}

class _UsuarioState extends State<UsuarioScreen>{

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      context.read<UsuarioProvider>().getUsuarios()
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UsuarioProvider>();
    final user = context.watch<UserProvider>().user;

    if (user == null) {
      return Scaffold(
        body: const Center(child: CircularProgressIndicator())
      );
    }

    if (provider.isLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text("Usuarios"),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.secondary
          )
          ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Usuarios"),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: provider.usuarios.length,
          itemBuilder: (_, index){
            final u = provider.usuarios[index];
            return ListTile(
              shape: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondary)
              ),
              splashColor: AppColors.secondary,
              leading: 
              user.rol == "ADMIN"? Text("${u.id}", style: TextStyle(fontSize: 20),) : null,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(u.nombre),
                      Row(
                        children: [
                          Text("Rol: "),
                          Text(u.rol, style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                        ],
                      )
                    ],
                  ),
                  u.calle != null
                    ? Text("  ${u.calle}, ${u.numero}", style: TextStyle(fontSize: 12),) 
                    : Text("  Sin Vivienda", style: TextStyle(fontSize: 12),)
                ],
              ),
              trailing: user.rol == "ADMIN"? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.app_registration_outlined),
                    color: AppColors.secondary,
                    onPressed: () async{
                      await provider.chageRole(u.id);
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: AppColors.secondary,
                    onPressed: () async{
                      await provider.deleteUsuario(u.id);
                    }
                  ),
                ],
              ): null,
            );
          },
        ),
      ),
    );
  }
}