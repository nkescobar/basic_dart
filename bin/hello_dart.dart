void main() {
  var apodo = 'MakingAppers';
  String saludo = 'Hola $apodo';
  double estatura = 1.53;
  bool esFalso = false;
  List<int> edades = [20, 21, 22, 24];
  print(apodo);

  print(saludo);
  print(estatura);
  print(esFalso);
  print(edades);

  // Existe un tiempo para todo
  // Las variables constantes no cambian
  const estoNoCambia = 'MakingApp';

  final estoSeAsignaEnEjecucion = funcionNoDevuelveNada();
  print(estoNoCambia);
  print(estoSeAsignaEnEjecucion);
  funcionNoDevuelveNada();

  // dart es un lenguaje que te proteje de valores nulos por ejemplo
  int edad = 29;
  late final String nombreEstudiante;
  nombreEstudiante = obtenerNombreEstudiante();
  print(nombreEstudiante);
  print(edad + 5);

  // Sin embargo en ciertas ocasiones podremos tener valores que probablemente sean vacios
  String? comidaFavorita;

  print('comida favorita ees : $comidaFavorita');
  print(deprontoNoDevuelveNada(20));
  print(deprontoNoDevuelveNada(15));

  for (var i = 0; i < 20; i++) {
    print('Estamos en la interacion $i');
  }

  int contador = 0;
  String todoAndaBien = 'todo super bien';
  while (todoAndaBien == 'todo super bien') {
    print('vamos por otra repeticion');
    contador++;

    if (contador > 5) {
      print('Ahora todo anda exageradamente bien');
      todoAndaBien = 'todo anda exageradamente bien';
    }
  }

  // Operadores ternarios

  bool todoContoBien = contador > 5 ? true : false;
  print(todoContoBien);

  //Por otro lado en dart no Existe las interfaces sino clases abstractas
  var nuevoIngeniero = Ingeniero(
      name: 'Nasly',
      edad: 1000,
      estatura: estatura,
      profesion: 'Ingeniera de Sistemas',
      software: 'Dart');

  nuevoIngeniero.saludar();
  nuevoIngeniero.programar();

  //En Dart existe un tema muy interesante y son los futuros y los Streams
  //Podemos entender los futuros como un valor que se lo podremos obtener en un futuro,
  // Es similar a las promesas en  JavaScript
  mostrarMensajeDelFuturo();
}

Future<void> mostrarMensajeDelFuturo() async {
  // enUnFuturoCercano().then((value) => print(value));
  // enUnFuturoAunMasCercano().then((value) => print(value));
  enUnFuturoCercano().then(
    (mensajeDeUnFuturoLejano) {
      medirMensajeDelFuturo(mensajeDeUnFuturoLejano)
          .then((value) => print('El tamaño del mensaje es $value'));
    },
  );
  //Esto comienza a verse enredado, no creen?
  // enUnFuturoCercano().then(
  //   (mensajeDeUnFuturoLejano) {
  //     medirMensajeDelFuturo(mensajeDeUnFuturoLejano).then(
  //       (value) {
  //         print(value);
  //         enUnFuturoAunMasCercano().then(
  //           (mensajeDeUnFuturoCercano) {
  //             medirMensajeDelFuturo(mensajeDeUnFuturoCercano)
  //                 .then((segundoMensaje) => print(segundoMensaje));
  //           },
  //         );
  //       },
  //     );
  //   },
  // );

  //esto es mucho más claro!!!!
  String primerMensaje = await enUnFuturoCercano();
  String mensajePrimerConteo = await medirMensajeDelFuturo(primerMensaje);
  print(mensajePrimerConteo);
  String segundoMensaje = await enUnFuturoAunMasCercano();
  String mensajeSegundoConteo = await medirMensajeDelFuturo(segundoMensaje);
  print(mensajeSegundoConteo);

  print('por ahora no ha llegado el mensaje');
  print('se demora un poco en llegar el mensaje del futuro');
  //podemos escuchar cada uno de los retornos de un stream de forma que podamos ejecutar una acción ante
  //un valor nuevo
  countDown(10, 0).listen((event) {
    print(event);
  });
  print('sin embargo esto no boloquea el código 🥸');
  showNames().listen((nombre) {
    print(nombre);
  });
  //esto es muy poderozo por ende debemos utilizar de forma correcta los futuros y los streams
  // pues harán a nuestras aplicaciones no bloqueantes

  //Veamos unos puntos adicionales

  //al igual que en otros lenguajes tenemos las funciones anónimas, de hecho ya las hemos usado
  //durante el video
  const listOfNames = ['makingapp', 'dash', 'mafer'];
  listOfNames.map((name) {
    return name.toUpperCase();
  }).forEach((name) {
    print('$name: ${name.length}');
  });
}

// En flutter también existen los streams, que los podemos ver como un flujo de datos

//por ejemplo que tal el siguiente reto mostrar en pantalla dos numeros y un nombre pro segundo
Stream<int> countDown(int start, int end) async* {
  //esta función devolverá un flujo de datos dependiendo de unos datos de inicio y final
  for (var i = start; i >= end; i--) {
    await Future.delayed(Duration(milliseconds: 500));
    //el yield indica que devolvera por iteración
    yield i;
  }
}

//hacemos lo mismos para los nombres
Stream<String> showNames() async* {
  List nombres = ['Daniel', 'Mafer', 'Esteban', 'Ana', 'Pepito'];

  for (String name in nombres) {
    await Future.delayed(Duration(seconds: 1));
    yield name;
  }
}

Future<String> medirMensajeDelFuturo(String mensaje) async {
  await Future.delayed(Duration(milliseconds: 2000));
  print('perdonen que me demoro mucho contando');
  return Future.value(
      'el mensaje del futuro mide lo siguiente ${mensaje.length}');
}

Future<String> enUnFuturoCercano() async {
  await Future.delayed(Duration(milliseconds: 500));

  return Future.value('Todo terminó de forma exitosa');
}

Future<String> enUnFuturoAunMasCercano() async {
  await Future.delayed(Duration(milliseconds: 200));

  return Future.value('Todo terminó de forma exitosa en el futuro cercano 🤯');
}

// En dart no existe las interfaces sino clases abstratas
abstract class Humano {
  final String name;
  final int edad;
  final double estatura;

  Humano({required this.name, required this.edad, required this.estatura});

  void saludar() {
    print('Hola mi nombre es $name ');
  }
}

abstract class Programador {
  final String software;

  Programador(this.software);

  void programar() {}
}

//Solo se puede extender de una clase abstracta
class Ingeniero extends Humano implements Programador {
  final String profesion;
  @override
  final String software;
  Ingeniero({
    required super.name,
    required super.edad,
    required super.estatura,
    required this.profesion,
    required this.software,
  });

  @override
  void programar() {
    print('Hola soy $name y voy a programar en $software');
  }
}

// Las funciones tambien pueden ser nulas

String? deprontoNoDevuelveNada(int edad) {
  return (edad > 18) ? 'Puede entrar' : null;
}

String obtenerNombreEstudiante() {
  return 'No es nulo';
}

String funcionNoDevuelveNada() {
  return 'nada';
}
