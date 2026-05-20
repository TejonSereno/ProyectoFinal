
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/votacion/votacion_detalle.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/data/providers/votacion_provider.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:provider/provider.dart';

class VotacionDetalleScreen extends StatefulWidget {

  final int votacionId;

  const VotacionDetalleScreen({super.key, required this.votacionId});

  @override
  State<VotacionDetalleScreen> createState() => _VotacionDetalleState();
}

class _VotacionDetalleState extends State<VotacionDetalleScreen> {

  String opcionSeleccionada = '';

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final userProvider = context.read<UserProvider>();

      while (userProvider.user == null) {
        await Future.delayed(Duration(milliseconds: 50));
      }

      final provider = context.read<VotacionProvider>();

      await provider.getVotacionDetalle(widget.votacionId);

      await provider.hasVoted(
        context.read<UserProvider>().user!.id,
        widget.votacionId,
      );

      if (provider.voto != null) {
      setState(() {
        opcionSeleccionada = provider.voto!.opcion;
      });
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VotacionProvider>();
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
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.secondary
          )
          ),
      );
    }
    final VotacionDetalle votacionDetalle = provider.votaciondetalle;
    final voto = provider.voto;
    final finalizada = provider.votaciondetalle.fechaFin.isBefore(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(votacionDetalle.titulo),
        backgroundColor: AppColors.background,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(votacionDetalle.descripcion, style: TextStyle(fontSize: 18.0))),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: votacionDetalle.votos.length,
              itemBuilder: (context, index) {
                final opcion = votacionDetalle.votos.entries.toList()[index];
                final opcionTexto = opcion.key.trim();
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: opcionTexto == opcionSeleccionada ? AppColors.secondary.withOpacity(0.5) : AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.secondary),
                  ),
                  child: ListTile(
                    onTap: () => setState(() => opcionSeleccionada = opcionTexto),
                    style: ListTileStyle.list,
                    title: Text(opcionTexto),
                    trailing: Text(opcion.value.toString(), style: TextStyle(fontSize: 14.0)),
                  ),
                );
              }
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: opcionSeleccionada.isEmpty || opcionSeleccionada == voto?.opcion || finalizada
                  ? null 
                  : () async {
                    await provider.votar(user.id, widget.votacionId, opcionSeleccionada);
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background
                ),
                child: finalizada ? Text("Votacion Finalizada", style: TextStyle(color: AppColors.text.withOpacity(0.7), fontSize: 14.0))
                  : voto == null ? Text("Votar", style: TextStyle(color: AppColors.text, fontSize: 14.0)) 
                  : voto.opcion == opcionSeleccionada ? Text("Votado", style: TextStyle(color: AppColors.text.withOpacity(0.7), fontSize: 14.0)) 
                  : Text("Cambiar Voto", style: TextStyle(color: AppColors.text, fontSize: 14.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}