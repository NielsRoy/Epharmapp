import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

class Debouncer<T> {  //* Este debouncer es Generico ya que puede emitir un tipo de dato que yo le indique (String, objeto, etc)

  Debouncer({ 
    required this.duration,  //* Cantidad de tiempo que quiero esperar antes de emitir un valor
    this.onValue //* Un metodo que voy a disparar cuando ya haya pasado el tiempo que le indique
  });

  final Duration duration;

  void Function(T value)? onValue; //* Es opcional porque la inicializo despues

  T? _value;
  Timer? _timer;  //* Viene del paquete dart:async
  
  T get value => _value!;

  set value(T val) {  //* Si recibimos un valor, mandaremos a llamar el metodo onValue despues de que pase la duracion indicada
    _value = val;
    _timer?.cancel(); //* Siempre que el usuario siga escribiendo (cambiando el value), cancelamos el timer
    //* Para volverlo a iniciar
    _timer = Timer(duration, () => onValue!(_value!)); //* Cuando pase la duracion indicada, mando a llamar la funcion del onValue
  }  
}