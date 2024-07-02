import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  String name = '';
  String email = '';
  String password = '';
  String passwordConfirmation = '';
  String ci = '';
  String telefono = '';
  String direccion = '';
  String sexo = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}