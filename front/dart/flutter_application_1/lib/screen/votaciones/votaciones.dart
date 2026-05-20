import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:flutter_application_1/screen/votaciones/formularion_votacion.dart';
import 'package:flutter_application_1/screen/votaciones/votacion_list.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';


class VotacionScreen extends StatelessWidget{
  const VotacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Votaciones"),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (user.rol == "ADMIN")
              const SliverToBoxAdapter(
                child: FormularioVotacion(),
              ),

            const VotacionList(),
          ],
        ),
      ),
    );
  }
}

