import 'package:epharm_movil/providers/providers.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/ui/input_decorations.dart';
import 'package:epharm_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),

              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Crear una cuenta', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),

                    ChangeNotifierProvider(
                      create: ( _ ) => RegisterFormProvider(), //Esta instancia puede dibujar y redibujar el _LoginForm cuando sea necesario
                      child: _RegisterForm(),  //
                    ),                    
                  ],
                ),
              ),

              const SizedBox(height: 50),
              TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(const Color.fromRGBO(157, 157, 157, 0.2)),
                  shape:  WidgetStateProperty.all(const StadiumBorder())
                ),
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
                child: const Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)
              ),
              const SizedBox(height: 50),

            ],
          ),
        )
      )
    );
  }
}

class _RegisterForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final registerForm = Provider.of<RegisterFormProvider>(context);
    
    return Container(
      child: Form(
        
        key: registerForm.formKey, 

        autovalidateMode: AutovalidateMode.onUserInteraction, //para validar el formulario cuando el usuario interactue con el
        child: Column(
          children: [

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Niels Roy Chambi Gonzales',
                labelText: 'Nombre Completo',
                prefixIcon: Icons.account_circle_rounded
              ),
              onChanged: (value) => registerForm.name = value,
              validator: (value) { 
                String pattern = r'^[a-zA-Z\ñ\Ñ\s]+$';
                RegExp regExp  = RegExp(pattern);

                if (value == null){
                  return 'Este campo es obligatorio.';
                }

                return regExp.hasMatch(value)
                  ? null
                  : 'El nombre solo puede contener letras del abecedario español.';
              },
            ),
            const SizedBox(height: 20,),

            TextFormField(
              autocorrect: false, 
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'nielsroy8@gmail.com',
                labelText: 'correo electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value) => registerForm.email = value,
              validator: (value) { 
                
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                if (value == null){
                  return 'Este campo es obligatorio.';
                }

                return regExp.hasMatch(value)
                  ? null
                  : 'El valor ingresado no luce como un correo';
              },
            ),
            const SizedBox(height: 20,),

            TextFormField(
              autocorrect: false, 
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => registerForm.password = value,
              validator: (value) { 
                if (value == null){
                  return 'Este campo es obligatorio.';
                }

                return (value.length >= 6) 
                  ? null
                  : 'La contraseña debe ser mayor a 6 caracteres';
              },
            ),
            const SizedBox(height: 20,),

            TextFormField(
              autocorrect: false, 
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Confirmar contraseña',
                prefixIcon: Icons.lock
              ),
              onChanged: (value) => registerForm.passwordConfirmation = value,
              validator: (value) {
                if (value == null){
                  return 'Este campo es obligatorio.';
                }

                return (value == registerForm.password) 
                  ? null
                  : 'La contraseña no coincide con la anterior';
              },
            ),
            const SizedBox(height: 20,),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '13173531',
                labelText: 'Cédula de Identidad',
                prefixIcon: Icons.contact_mail
              ),
              onChanged: (value) => registerForm.ci = value,
              validator: (value) { 
                String pattern = r'^\d+$';
                RegExp regExp  = RegExp(pattern);

                if (value == null){
                  return 'Este campo es obligatorio.';
                }

                return regExp.hasMatch(value)
                  ? null
                  : 'Este campo solo acepta números.';
              },
            ),
            const SizedBox(height: 20,),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.authInputDecoration(
                hintText: '72474541',
                labelText: 'Celular',
                prefixIcon: Icons.phone
              ),
              onChanged: (value) => registerForm.telefono = value,
              validator: (value) { 
                String pattern = r'^\d+$';
                RegExp regExp  = RegExp(pattern);

                if (value == null){
                  return 'Este campo es obligatorio.';
                }

                return regExp.hasMatch(value)
                  ? null
                  : 'Este campo solo acepta números.';
              },
            ),
            const SizedBox(height: 20,),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Av. Soberania Calle 11',
                labelText: 'Dirección',
                prefixIcon: Icons.home
              ),
              onChanged: (value) => registerForm.direccion = value,
              validator: (value) { 
                if (value == null){
                  return 'Este campo es obligatorio.';
                }

                return (value.length >= 10) 
                  ? null
                  : 'La direccion debe ser mayor a 10 caracteres';
              },
            ),
            const SizedBox(height: 20,),

            DropdownButtonFormField<String>(
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Eliga una opción',
                labelText: 'Seleccione su genero',
                prefixIcon: Icons.wc
              ),
              items: const [
                DropdownMenuItem(value: 'M', child: Text('Masculino')),
                DropdownMenuItem(value: 'F', child: Text('Femenino'))
              ], 
              onChanged: (value) => registerForm.sexo = value ?? '',
              validator: (value) {
                if (value == null){
                  return 'Este campo es obligatorio.';
                }

                return (value == 'M' || value == 'F')
                  ? null
                  : 'Debe seleccionar una opción';
              },
            ),

            const SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromRGBO(4, 120, 87, 1),
              
              onPressed: registerForm.isLoading ? null : () async { //si el isLoading es true entonces no se puede presionar el boton
                
                FocusScope.of(context).unfocus(); //para quitar el foco del teclado
                final authService = Provider.of<AuthService>(context, listen: false); //El listen en false si esta dentro de un metodo y solo true en el build

                if (!registerForm.isValidForm()) return; //usamos el provider para validar el formulario

                registerForm.isLoading = true;

                final String? errorMessage = await authService.createUser(
                  registerForm.name,
                  registerForm.email, 
                  registerForm.password,
                  registerForm.ci,
                  registerForm.telefono,
                  registerForm.direccion,
                  registerForm.sexo
                );

                if (errorMessage == null) {
                  Navigator.pushReplacementNamed(context, 'products'); //destruye el stack de pantallas, lo que significa que no se puede regresar a la pantalla anterior
                } else {
                  //print(errorMessage);
                  NotificationsService.showSnackbar("Error al registrar, Intente de nuevo."); //para mostrar el mensaje de error en pantalla
                  registerForm.isLoading = false;
                }
              },
            
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  registerForm.isLoading
                    ? 'Espere...'
                    : 'Registrar', 
                  style: const TextStyle(color: Colors.white))
              ),
            )
          ],
        ),

      ),
    );
  }
}