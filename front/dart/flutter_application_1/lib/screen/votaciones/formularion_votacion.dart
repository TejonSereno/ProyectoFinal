import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/data/providers/votacion_provider.dart';
import 'package:flutter_application_1/paleta/Colors.dart';
import 'package:flutter_application_1/utils/selector_fecha.dart';
import 'package:provider/provider.dart';

class FormularioVotacion extends StatefulWidget{
  const FormularioVotacion({super.key});

  @override
  State<FormularioVotacion> createState() => _FormularioVotacionState();
}

class _FormularioVotacionState extends State<FormularioVotacion> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  DateTime? selectedDate;
  List<TextEditingController> opcionesController = [];

  @override
  void dispose() {
    tituloController.dispose();
    descripcionController.dispose();
    for (var controller in opcionesController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VotacionProvider>();
    final token = context.watch<UserProvider>().token;

    return Container(
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
                Text("Crear Votacion", style: TextStyle(fontSize: 20, color: AppColors.text)),
                SizedBox(height: 8.0),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                        color:AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.secondary),
                      ),
                      child: TextField(
                        controller: tituloController,
                        decoration: InputDecoration(
                          hintText: "Titulo",
                          border: InputBorder.none,
                        ),
                      ),
                    ),                              
                    SizedBox(height: 8.0),
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
                    ),
                    SizedBox(height: 12),
                    InkWell(
                      onTap: () async {
                        final piked = await pickDateTime(context);

                        if (piked != null) {
                          setState(() {
                            selectedDate = piked;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          border: Border.all(color: AppColors.secondary),                                      
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedDate == null
                              ? "fecha y hora de finalizacion"
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}T"
                                "${selectedDate!.hour.toString().padLeft(2, '0')}:"
                                "${selectedDate!.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(color: AppColors.text),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Column(
                      children: [
                        ...List.generate(opcionesController.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      border: Border.all(color: AppColors.secondary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextField(
                                      controller: opcionesController[index],
                                      decoration: InputDecoration(
                                        hintText: "Opción ${index + 1}",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      opcionesController[index].dispose();
                                      opcionesController.removeAt(index);
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        }),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                opcionesController.add(TextEditingController());
                              });
                            },
                            icon: Icon(Icons.add),
                            label: Text("Añadir opción"),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    if (tituloController.text.isEmpty || selectedDate == null || opcionesController.length < 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Quedan campos sin completar"),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                          )
                      );
                      return;
                    }
                    final ok = await provider.createVotacion(tituloController.text, descripcionController.text, selectedDate!, opcionesController.map((e) => e.text.trim()).toList(), token!);
                    if (ok) {
                      tituloController.clear();
                      descripcionController.clear();
                      selectedDate = null;
                      opcionesController.forEach((controller) => controller.clear());
                      opcionesController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Votacion creada"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                          )
                      );
                    }
                  }
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}