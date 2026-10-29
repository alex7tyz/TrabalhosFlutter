import 'package:flutter/material.dart';

const Color azulVW = Color(0xFF001E50);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volksgalerie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: azulVW,
      ),
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volksgalerie'),
        centerTitle: true,
        backgroundColor: azulVW,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/imagens/volkswagen.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Carros',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text('Pesquise um modelo pelo nome.'),
            ),
            const SizedBox(height: 24),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Buscar pelo nome',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Buscar carros'),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Carros disponíveis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text('Selecione um carro para ver os detalhes.'),
            const SizedBox(height: 12),
            cardCarro(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: azulVW,
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

  Widget cardCarro() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              color: Colors.grey.shade300,
              child: const Icon(Icons.directions_car, size: 40),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hatch',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Golf GTI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('2024 • 245 cv'),
                  Text('5 lugares'),
                ],
              ),
            ),
            const Icon(Icons.favorite_border),
          ],
        ),
      ),
    );
  }
}