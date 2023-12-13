import 'package:flutter/material.dart';
import 'hamburguer_menu.dart';

class ScreenBlank extends StatefulWidget { //stateful por que el widget puede ir variando (va a contener un menu de hamburguesa)
// al ser stateful debemos crear clases state que seran los posibles estados de esta clase
// cada estado es como un diseño unico que se da a la clase stateful
  const ScreenBlank({super.key}); //constructor por defecto de la screenBlank

  @override
  State<ScreenBlank> createState() => _ScreenBlankState();
// createState() crea una nueva intancia de la clase _ScreenBlankState
// cada vez que flutter necesite crear un ScreenBlank, creara este estado

}

class _ScreenBlankState extends State<ScreenBlank> {

  @override
  Widget build(BuildContext context) { //nos esta haciendo el menu de hamburguesa y el ACS
    return Scaffold( //context sirve para darle contexto, como por ejemplo que sepa la paleta de colores que hemos definido etc

      // "drawer: estamos indicando que para el drawer de este scaffold debemos usar el drawer de la clase TheDrawer"
      drawer: TheDrawer(context).drawer, // drawer panel que se desliza desde el border de la pantalla
      // no deja de ser una


      appBar: AppBar( //le decimos que despues del menu ponga el nombre ACS
        backgroundColor: Theme.of(context).colorScheme.primary,// el color escogido ene l main que es el azul
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("ACS"),
      ),
    );
  }
}