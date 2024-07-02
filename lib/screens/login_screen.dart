import 'package:epharm_movil/providers/providers.dart';
import 'package:epharm_movil/services/services.dart';
import 'package:epharm_movil/ui/input_decorations.dart';
import 'package:epharm_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  
  const LoginScreen({Key? key}) : super(key: key);
  
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
                    Text('Iniciar Sesión', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),

                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(), //Esta instancia puede dibujar y redibujar el _LoginForm cuando sea necesario
                      child: _LoginForm(),  //
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
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'), 
                child: const Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)
              ),
              const SizedBox(height: 50),
            ],
          ),
        )
      )
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final loginForm = Provider.of<LoginFormProvider>(context);
    


    return Container(
      child: Form(
        
        key: loginForm.formKey, 

        autovalidateMode: AutovalidateMode.onUserInteraction, //para validar el formulario cuando el usuario interactue con el
        child: Column(
          children: [

            TextFormField(
              autocorrect: false, //para evitar la autocorrecion de los teclados de los dispositivos moviles
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'nielsroy8@gmail.com',
                labelText: 'correo electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) { //Aqui se realiza las validaciones del campo si regreso un null significa que la validacion paso sino regreso un string con el mensaje, Estas validaciones solo se realizan cuando el usuario interactua con el campo de texto
                
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
              },
            ),
            
            const SizedBox(height: 30,),

            TextFormField(
              autocorrect: false, //para evitar la autocorrecion de los teclados de los dispositivos moviles
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) { //Aqui se realiza las validaciones del campo si regreso un null significa que la validacion paso sino regreso un string con el mensaje
                
                return (value != null && value.length >= 6) 
                  ? null
                  : 'La contraseña debe ser mayor a 6 caracteres';
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
              
              
              onPressed: loginForm.isLoading ? null : () async { //si el isLoading es true entonces no se puede presionar el boton
                
                FocusScope.of(context).unfocus(); //para quitar el foco del teclado
                final authService = Provider.of<AuthService>(context, listen: false); //El listen en false si esta dentro de un metodo y solo true en el build

                if (!loginForm.isValidForm()) return; //usamos el provider para validar el formulario

                loginForm.isLoading = true;

                final String? errorMessage = await authService.login(loginForm.email, loginForm.password);

                if (errorMessage == null) {
                  Navigator.pushReplacementNamed(context, 'products'); //destruye el stack de pantallas, lo que significa que no se puede regresar a la pantalla anterior
                } else {
                  //print(errorMessage);
                  NotificationsService.showSnackbar("Usuario o contraseña incorrectos"); //para mostrar el mensaje de error en pantalla
                  loginForm.isLoading = false;
                }
              },
            
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading
                    ? 'Espere...'
                    : 'Ingresar', 
                  style: const TextStyle(color: Colors.white))
              ),
            )
          ],
        ),

      ),
    );
  }
}