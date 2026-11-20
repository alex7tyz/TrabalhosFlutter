import 'package:flutter/material.dart';
import 'pagina_explorar.dart';
import 'pagina_favoritos.dart';
import 'tema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colher de Pau',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: terracota),
        scaffoldBackgroundColor: papel,
        appBarTheme: const AppBarTheme(
          backgroundColor: terracota,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: terracota,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int indice = 0;

  @override
  Widget build(BuildContext context) {
    final paginas = [
      const PaginaExplorar(),
      PaginaFavoritos(aoExplorar: () => setState(() => indice = 0)),
    ];

    return Scaffold(
      body: paginas[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        selectedItemColor: terracota,
        onTap: (valor) => setState(() => indice = valor),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}