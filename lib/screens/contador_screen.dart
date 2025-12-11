import 'package:flutter/material.dart';

class ContadorScreen extends StatefulWidget {
  @override
  _ContadorScreenState createState() => _ContadorScreenState();
}

class _ContadorScreenState extends State<ContadorScreen> {
  int contador = 0;
  String mensajeMotivacional = '¡Sigue explorando!';

  @override
  void initState() {
    super.initState();
    print("La pantalla ContadorScreen se ha creado.");
  }

  @override
  void dispose() {
    print("La pantalla ContadorScreen se ha cerrado.");
    super.dispose();
  }

  void aumentarContador() {
    setState(() {
      contador++;
      
      // Mensajes motivacionales según el contador
      if (contador >= 10) {
        mensajeMotivacional = '¡Eres un explorador experto! 🌟';
      } else if (contador >= 5) {
        mensajeMotivacional = '¡Vas por buen camino! ⭐';
      } else if (contador >= 3) {
        mensajeMotivacional = '¡Sigue así! 👍';
      } else {
        mensajeMotivacional = '¡Comienza tu aventura! 🚀';
      }
    });
  }

  void reiniciarContador() {
    setState(() {
      contador = 0;
      mensajeMotivacional = '¡Comienza tu aventura! 🚀';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contador reiniciado'),
        backgroundColor: Colors.green.shade600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ciclo de vida y estado'),
        backgroundColor: Colors.green.shade600,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade50, Colors.green.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_events,
                size: 80,
                color: Colors.green.shade700,
              ),
              SizedBox(height: 30),
              Text(
                'Has presionado el botón:',
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
              SizedBox(height: 10),
              Text(
                '$contador veces',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              SizedBox(height: 20),
              Text(
                mensajeMotivacional,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.green.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: aumentarContador,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Aumentar'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: reiniciarContador,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Reiniciar'),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '¿Qué está pasando?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Cada vez que presionas "Aumentar", el método setState() '
                        'vuelve a dibujar la pantalla con el nuevo valor.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}