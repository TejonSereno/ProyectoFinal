import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/providers/aviso_provider.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:flutter_application_1/utils/selector_fecha.dart';
import 'package:provider/provider.dart';

class AvisosScreen extends StatefulWidget {
    const AvisosScreen({super.key});

    @override
    State<AvisosScreen> createState() => _AvisosScreenState();
}

class _AvisosScreenState extends State<AvisosScreen> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
      tituloController.dispose();
      descripcionController.dispose();
      super.dispose();
  }

  @override
  void initState() {
      super.initState();
      Future.microtask(() async{
        final userProvider = context.read<UserProvider>();

        while (userProvider.token == null) {
          await Future.delayed(Duration(milliseconds: 50));
        }

        context.read<AvisoProvider>().getAvisos(userProvider.token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AvisoProvider>();
    final user = context.watch<UserProvider>().user;
    final token = context.watch<UserProvider>().token;

    if (provider.isLoading || user == null || token == null) {
        return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
                backgroundColor: AppColors.background,
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
          title: const Text("Avisos"),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (user.rol == "ADMIN")
            SliverToBoxAdapter(
              child: Container(
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
                          Text("Crear Aviso", style: TextStyle(fontSize: 20, color: AppColors.text)),
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
                                  final picked = await pickDateTime(context);
                                  
                                  if (picked != null) {
                                    setState(() {
                                        selectedDate = picked;
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
                              if (tituloController.text.isEmpty || selectedDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                    content: Text("Quedan campos sin completar"),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 3),
                                    )
                                );
                                return;
                              }
                              
                              final ok = await provider.createAviso(tituloController.text, descripcionController.text, selectedDate!, token);
                              if (ok) {
                                setState(() {
                                  tituloController.clear();
                                descripcionController.clear();
                                  selectedDate = null;
                                });
          
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                  content: Text("Aviso Creado"),
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
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: provider.avisos.length,
                (context, index){
                  final aviso = provider.avisos[index];
                  final diferencia = aviso.fechaFin.difference(DateTime.now());
                  final tiempoRestante = diferencia.inHours < 24
                      ? "${diferencia.inHours} horas"
                      : "${diferencia.inDays} días";
                  final haFinalizado = aviso.fechaFin.isBefore(DateTime.now());
                  return ListTile(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondary)
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(aviso.titulo, style: TextStyle(fontSize: 18, color: AppColors.text)),
                        SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.only(top: 4, left: 8.0),
                          child: Text(aviso.descripcion, style: TextStyle(fontSize: 15, color: AppColors.text)),
                        ),
                        SizedBox(height: 6),
                        haFinalizado
                        ? Text("Finalizada", style: TextStyle(fontSize: 15, color: AppColors.text))
                        : Row(
                          children: [
                            Text("Finaliza en: ", style: TextStyle(fontSize: 15, color: AppColors.text)),
                            Text(tiempoRestante),
                          ],
                        ),
                      ],
                    ),
                    
                    trailing: user.rol != "ADMIN" ?null :IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.secondary),
                      onPressed: () async {
                        final ok = await provider.deleteAviso(aviso.id, token);
                        if (ok) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                            content: Text("Aviso Eliminado"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                            )
                          );
                        }
                      }
                    ),
                  );
                },
              )
            ),
          ]
        ),
      ),
    );
  }
}