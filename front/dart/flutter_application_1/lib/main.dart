import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/providers/aviso_provider.dart';
import 'package:flutter_application_1/data/providers/incidencia_provider.dart';
import 'package:flutter_application_1/data/providers/usuario_provider.dart';
import 'package:flutter_application_1/data/providers/vivienda_provider.dart';
import 'package:flutter_application_1/data/providers/votacion_provider.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/screen/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),

        Provider(
          create: (_) => Repository(),
        ),
        
        ChangeNotifierProxyProvider<Repository, ViviendaProvider>(
          create: (context) => ViviendaProvider(
            context.read<Repository>(),
          ),
          update: (_, repo, previous) => ViviendaProvider(repo),
        ),
        
        ChangeNotifierProxyProvider<Repository, UsuarioProvider>(
          create: (context) => UsuarioProvider(
            context.read<Repository>(),
          ),
          update: (_, repo, previous) => UsuarioProvider(repo),
        ),

        ChangeNotifierProxyProvider<Repository, IncidenciaProvider>(
          create: (context) => IncidenciaProvider(
            context.read<Repository>(),
          ),
          update: (_, repo, previous) => IncidenciaProvider(repo),
        ),

        ChangeNotifierProxyProvider<Repository, VotacionProvider>(
          create: (context) => VotacionProvider(
            context.read<Repository>(),
          ),
          update: (_, repo, previous) => VotacionProvider(repo),
        ),

        ChangeNotifierProxyProvider<Repository, AvisoProvider>(
          create: (context) => AvisoProvider(
            context.read<Repository>(),
          ), 
          update: (_, repo, previous) => AvisoProvider(repo),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoguinScreen()
    );
  }
}
