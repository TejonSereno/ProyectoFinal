import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/providers/aviso_provider.dart';
import 'package:flutter_application_1/data/providers/incidencia_provider.dart';
import 'package:flutter_application_1/data/providers/usuario_provider.dart';
import 'package:flutter_application_1/data/providers/vivienda_provider.dart';
import 'package:flutter_application_1/data/providers/votacion_provider.dart';
import 'package:flutter_application_1/data/repositories/authRepository.dart';
import 'package:flutter_application_1/data/repositories/avisoRepository.dart';
import 'package:flutter_application_1/data/repositories/incidenciaRepository.dart';
import 'package:flutter_application_1/data/repositories/usuarioRepository.dart';
import 'package:flutter_application_1/data/repositories/viviendaRepository.dart';
import 'package:flutter_application_1/data/repositories/votacionRepository.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/screen/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            Authrepository(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => ViviendaProvider(
            ViviendaRepository(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => UsuarioProvider(
            UsuarioRepository(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => IncidenciaProvider(
            IncidenciaRepository(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => VotacionProvider(
            VotacionRepository(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => AvisoProvider(
            AvisoRepository(),
          ),
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
