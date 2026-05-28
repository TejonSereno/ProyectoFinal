import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/loguin/user.dart';
import 'package:flutter_application_1/data/providers/user_provider.dart';
import 'package:flutter_application_1/data/providers/usuario_provider.dart';
import 'package:flutter_application_1/paleta/colors.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:provider/provider.dart';

class UsuariodetalleScreen extends StatefulWidget {
  const UsuariodetalleScreen({super.key});

  @override
  State<UsuariodetalleScreen> createState() => _UsuariodetalleScreenState();
}

class _UsuariodetalleScreenState extends State<UsuariodetalleScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

  final TextEditingController calleController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();

  bool _initialized = false;
  bool passwordChage = false;

  @override
  void dispose() {
    nombreController.dispose();
    emailController.dispose();
    newpasswordController.dispose();
    confirmpasswordController.dispose();
    calleController.dispose();
    numeroController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UsuarioProvider>();
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

    final hasVivienda = user.vivienda != null;

    if (!_initialized) {
      nombreController.text = user.nombre;
      emailController.text = user.email;

      if (hasVivienda) {
        calleController.text = user.vivienda!.calle;
        numeroController.text = user.vivienda!.numero;
      }

      _initialized = true;
    }

    final hasChanges =
      nombreController.text != user.nombre ||
      emailController.text != user.email ||
      newpasswordController.text.isNotEmpty;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Mi Perfil"),
      ),
      body: Column(
        children: [
          Container(
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
              children: [
                Text("Tus datos", style: TextStyle(color: AppColors.text, fontSize: 20.0)),
                SizedBox(height: 16.0),
                buildCampo(controller: nombreController, readOnly: false),
                SizedBox(height: 16.0),
                buildCampo(controller: emailController, readOnly: false),
                SizedBox(height: 16.0),
                passwordChage 
                ? Column(
                  children: [
                    buildCampo(controller: newpasswordController, readOnly: false, hint: "Nueva contraseña"),
                    SizedBox(height: 10.0),
                    buildCampo(controller: confirmpasswordController, readOnly: false, hint: "Repetir contraseña"),
                  ],
                )
                : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      passwordChage = !passwordChage;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background
                  ),
                  child: Text("Cambiar contraseña", style: TextStyle(color: AppColors.text.withOpacity(0.7), fontSize: 14.0))
                ),
                SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: !hasChanges 
                    ? null 
                    : () => _aplicarCambios(provider, user, token),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background
                    ),
                    child: Text("Aplicar Cambios", style: TextStyle(color: AppColors.text.withOpacity(0.8), fontSize: 14.0))
                  ),
                )
              ],
            )
          ),
          SizedBox(height: 16.0),
          hasVivienda
          ? Container(
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
              children: [
                Text("Tu vivivendia", style: TextStyle(color: AppColors.text, fontSize: 20.0)),
                SizedBox(height: 16.0),
                buildCampo(controller: calleController, readOnly: true),
                SizedBox(height: 16.0),
                buildCampo(controller: numeroController, readOnly: true),
              ],
            )
          )
          : Text("Sin vivienda", style: TextStyle(color: AppColors.text, fontSize: 20.0)),
          Spacer(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<UserProvider>().clearUser();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoguinScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background
              ),
              child: Text("Cerrar Sesión", style: TextStyle(color: AppColors.text.withOpacity(0.8), fontSize: 14.0))
            ),
          ),
        ],
      ),
    );
  }


  Widget buildCampo({required TextEditingController controller, required bool readOnly, String hint = ""}){
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }


  Future<void> _aplicarCambios(
    UsuarioProvider provider,
    User user,
    String token
  ) async {

    FocusScope.of(context).unfocus();

    if (newpasswordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Las contraseñas no coinciden"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    final success = await provider.updateUsuario(
      user.id,
      nombreController.text,
      emailController.text,
      newpasswordController.text.isNotEmpty
        ? newpasswordController.text
        : "",
      token
    );

    if (!mounted) return;

    if (success) {

      context.read<UserProvider>().updateUser(
        nombre: nombreController.text,
        email: emailController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario actualizado"),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        passwordChage = false;
        newpasswordController.clear();
        confirmpasswordController.clear();
        _initialized = false;
      });

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al actualizar usuario"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}