import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/data/providers/votacion_provider.dart';
import 'package:flutter_application_1/paleta/Colors.dart';
import 'package:flutter_application_1/screen/votaciones/votacion_detalle.dart';
import 'package:provider/provider.dart';

class VotacionList extends StatefulWidget {
  const VotacionList({super.key});

  @override
  State<VotacionList> createState() => _VotacionListState();
}

class _VotacionListState extends State<VotacionList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async{
      final userProvider = context.read<UserProvider>();

      while (userProvider.token == null) {
        await Future.delayed(Duration(milliseconds: 50));
      }
      context.read<VotacionProvider>().getVotaciones(userProvider.token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VotacionProvider>();
    final user = context.watch<UserProvider>().user;
    final token = context.watch<UserProvider>().token;

    if (provider.isLoading || user == null || token == null) {
      return SliverToBoxAdapter(
        child: Center(
            child: CircularProgressIndicator(
              color: AppColors.secondary
            )
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: provider.votaciones.length,
        (context, index){
          final votacion = provider.votaciones[index];
          final diferencia = votacion.fechaFin.difference(DateTime.now());
          final tiempoRestante = diferencia.inHours < 24
              ? "${diferencia.inHours} horas"
              : "${diferencia.inDays} días";
          final haFinalizado = votacion.fechaFin.isBefore(DateTime.now());
          return Container(
            color: haFinalizado
              ? const Color.fromARGB(133, 111, 134, 144)
              : Colors.transparent,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => VotacionDetalleScreen(votacionId: votacion.id))
                );
              },
              shape: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondary)
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(votacion.titulo, style: TextStyle(fontSize: 18, color: AppColors.text)),
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.only(top: 4, left: 8.0),
                    child: Text(votacion.descripcion, style: TextStyle(fontSize: 15, color: AppColors.text)),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("(${votacion.nVotos} votos)", style: TextStyle(fontSize: 15, color: AppColors.text)),
                      haFinalizado
                      ? Text("Finalizada", style: TextStyle(fontSize: 15, color: AppColors.text))
                      : Row(
                        children: [
                          Text("Finaliza en: ", style: TextStyle(fontSize: 15, color: AppColors.text)),
                          Text(
                            tiempoRestante, 
                            //style: TextStyle(fontSize: 14, color: tiempoRestante <= 0 ? AppColors.text : tiempoRestante <= 1 ? Colors.red : tiempoRestante <= 5 ? const Color.fromARGB(255, 166, 154, 46) : Colors.green)
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              trailing: user.rol != "ADMIN" ?null :IconButton(
                icon: Icon(Icons.delete, color: AppColors.secondary),
                onPressed: () async{
                  final ok = await provider.deleteVotacion(votacion.id, token);
                  if (ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Votacion eliminada"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                        )
                    );
                  }
                },
              ),
            ),
          );
        }
      )
    );
  }
}