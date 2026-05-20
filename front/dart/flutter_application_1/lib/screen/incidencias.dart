import 'package:flutter_application_1/data/providers/incidencia_provider.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';


class IncidenciaScreen extends StatefulWidget{
  const IncidenciaScreen({super.key});

  @override
  State<IncidenciaScreen> createState() => _IncidenciaState();
}

class _IncidenciaState extends State<IncidenciaScreen>{

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      context.read<IncidenciaProvider>().getActiveIncidencias()
    );
  }

  @override
  void dispose() {
    tituloController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IncidenciaProvider>();
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
          title: Text("Incidencias"),
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
        title: Text("Incidencias"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                      Text("Enviar Incidencia", style: TextStyle(fontSize: 20, color: AppColors.text)),
                      SizedBox(height: 8.0),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              border: Border.all(color: AppColors.secondary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: tituloController,
                              decoration: InputDecoration(
                                hintText: "Asunto",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Container(
                            height: 100,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              border: Border.all(color: AppColors.secondary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: descripcionController,
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              maxLength: 400,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: "Descripcion",
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8.0),
                      provider.isCreating 
                      ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.secondary,
                        )
                      )
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                        ),
                        onPressed: () async{
                          if (tituloController.text.isEmpty || descripcionController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Completa todos los campos"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                                )
                            );
                            return;
                          }
                          final ok = await provider.createIncidencia(tituloController.text, descripcionController.text, user.id);
                          if (ok) {
                            tituloController.clear();
                            descripcionController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Incidencia creada"),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 3),
                                )
                            );
                          }
                        },
                        child: Text("Enviar", style: TextStyle(color: AppColors.text)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.incidencias.length,
              itemBuilder: (_, index){
                final i = provider.incidencias[index];
                return Container(
                  color: i.estado == "FINALIZADA"
                    ? const Color.fromARGB(133, 111, 134, 144)
                    : Colors.transparent,
                  child: ListTile(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondary)
                    ),
                    splashColor: AppColors.secondary,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(i.titulo, style: TextStyle(fontSize: 18, color: AppColors.text)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Text(i.descripcion)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 8.0),
                            Text(
                              i.estado, 
                              style: 
                              TextStyle(
                                fontSize: 16, 
                                color: i.estado == "PENDIENTE"
                                  ? const Color.fromARGB(255, 124, 137, 40)
                                  : i.estado == "EN PROCESO"
                                    ? const Color.fromARGB(255, 51, 117, 53)
                                    : AppColors.text)),
                            user.rol == "ADMIN"? Row(
                              children: [
                                IconButton(
                                  icon: Icon(getIcon(i.estado)),
                                  color: AppColors.secondary,
                                  onPressed: () async{
                                    await provider.changeState(i.id);
                                  }
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: AppColors.secondary,
                                  onPressed: () async{
                                    await provider.deleteIncidencia(i.id);
                                  }
                                ),
                              ],
                            ): Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData getIcon(String estado) {
    switch(estado) {
      case "PENDIENTE": return Icons.arrow_right;
      case "EN PROCESO": return Icons.check_circle;
      default: return Icons.loop;
    }
  }
}