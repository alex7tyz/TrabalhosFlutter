import 'package:flutter/material.dart';
import 'tema.dart';

// Tela com ícone, título, texto e botões (erro, sem resultado, sem favoritos)
class TelaMensagem extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String texto;
  final List<Widget> botoes;

  const TelaMensagem({
    super.key,
    required this.icone,
    required this.titulo,
    required this.texto,
    required this.botoes,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 64, color: terracota),
            const SizedBox(height: 12),
            Text(titulo, textAlign: TextAlign.center, style: estiloTitulo),
            const SizedBox(height: 8),
            Text(texto, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ...botoes,
          ],
        ),
      ),
    );
  }
}

class TelaCarregando extends StatelessWidget {
  const TelaCarregando({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Carregando receitas…'),
          ],
        ),
      ),
    );
  }
}

class TelaErro extends StatelessWidget {
  final VoidCallback aoTentar;

  const TelaErro({super.key, required this.aoTentar});

  @override
  Widget build(BuildContext context) {
    return TelaMensagem(
      icone: Icons.error_outline,
      titulo: 'Não foi possível carregar as receitas.',
      texto: 'Verifique sua conexão e tente novamente.',
      botoes: [
        ElevatedButton(
          onPressed: aoTentar,
          child: const Text('Tentar novamente'),
        ),
      ],
    );
  }
}