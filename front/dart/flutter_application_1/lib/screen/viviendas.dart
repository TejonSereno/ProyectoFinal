import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/data/providers/vivienda_provider.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:flutter_application_1/screen/vivienda_detalle.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';


class ViviendaScreen extends StatefulWidget{
  const ViviendaScreen({super.key});

  @override
  State<ViviendaScreen> createState() => _ViviendaState();
}

class _ViviendaState extends State<ViviendaScreen>{

  final TextEditingController calleController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async{
      final token = context.read<UserProvider>().token;

      while (token == null) {
        await Future.delayed(Duration(milliseconds: 50));
      }
      context.read<ViviendaProvider>().getViviendas(token);
    });
  }

  @override
  void dispose() {
    calleController.dispose();
    numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ViviendaProvider>();
    final user = context.watch<UserProvider>().user;
    final token = context.watch<UserProvider>().token;

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
          title: Text("Viviendas"),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.secondary
          )
          ),
      );
    }

    //
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Viviendas"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (user.rol == "ADMIN")
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(
                color: AppColors.secondary,)
              )
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
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
                  child: Column(
                    children: [
                      Text("Nueva Vivienda", style: TextStyle(fontSize: 20, color: AppColors.text)),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color:AppColors.background,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.secondary),
                                  ),
                                  child: TextField(
                                    controller: calleController,
                                    decoration: InputDecoration(
                                      hintText: "Calle",
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color:AppColors.background,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.secondary),
                                  ),
                                  child: TextField(
                                    controller: numeroController,
                                    decoration: InputDecoration(
                                      hintText: "Numero",
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.0),
                          provider.isCreating 
                            ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.secondary,
                            )
                          )
                          : IconButton(
                            icon: Icon(Icons.add),
                            color: AppColors.secondary,
                            onPressed: () async{
                              if (calleController.text.isEmpty || numeroController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Completa todos los campos"),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 3),
                                    )
                                );
                                return;
                              }
                              final ok = await provider.createVivienda(calleController.text, numeroController.text, token!);
                              if (ok) {
                                calleController.clear();
                                numeroController.clear();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Vivienda creada"),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 3),
                                    )
                                );
                              }
                            }
                          )
                        ]
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.viviendas.length,
              itemBuilder: (_, index){
                final v = provider.viviendas[index];
                return ListTile(
                  onTap: user.rol != "ADMIN" && user.vivienda?.id != v.id? null : (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViviendaDetalleScreen(viviendaId: v.id))
                    );
                  },
                  shape: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary)
                  ),
                  splashColor: AppColors.secondary,
                  leading: 
                  user.rol == "ADMIN"? Text("${v.id}", style: TextStyle(fontSize: 20),) : null,
                  title: Text("${v.calle}, ${v.numero} (${v.nUsuarios} Residentes)"),
                  trailing: user.rol == "ADMIN"? IconButton(
                        icon: Icon(Icons.delete),
                        color: AppColors.secondary,
                        onPressed: () async{
                          await provider.deleteVivienda(v.id, token!);
                        }
                      ): null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}