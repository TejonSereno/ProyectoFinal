import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/vivienda/viviendaDetalle.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/data/providers/vivienda_provider.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:provider/provider.dart';

class ViviendaDetalleScreen extends StatefulWidget{

  final int viviendaId;

  const ViviendaDetalleScreen({super.key, required this.viviendaId});

  @override
  State<ViviendaDetalleScreen> createState() => _ViviendaDetalleState();
}

class _ViviendaDetalleState extends State<ViviendaDetalleScreen>{

  @override
  void initState(){
    super.initState();

    Future.microtask(() async {
      final provider = context.read<ViviendaProvider>();
      await provider.getViviendaDetalle(widget.viviendaId);
    });
  }

  @override
  Widget build(BuildContext context){
    final provider = context.watch<ViviendaProvider>();
    final user = context.watch<UserProvider>().user;
    final ViviendaDetalle viviendaDetalle = provider.viviendaDetalle;

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
        title: Text("${viviendaDetalle.calle}, ${viviendaDetalle.numero}"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
        child: viviendaDetalle.usuarios.isEmpty 
        ? Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.secondary),
          ),
          child: ListTile(
            title: Text("No hay Residentes"),
          ),
        )
        : ListView?.builder(
          shrinkWrap: true,
          itemCount: viviendaDetalle.usuarios.length, 
          itemBuilder: (context, index) {
            final usuario = viviendaDetalle.usuarios[index];
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.secondary),
              ),
              child: ListTile(
                title: Text(usuario.nombre),
                trailing: Text(usuario.rol),
              ),
            );
          }
        ),
      ),
    );
  }
}