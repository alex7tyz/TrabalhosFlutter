import 'package:flutter/material.dart';
import 'tema.dart';

// Mostra a foto da receita; se não tiver ou falhar, mostra um ícone no lugar
class ImagemReceita extends StatelessWidget {
  final String? url;
  final double largura;
  final double altura;

  const ImagemReceita({
    super.key,
    required this.url,
    required this.largura,
    required this.altura,
  });

  @override
  Widget build(BuildContext context) {
    final alternativa = Container(
      width: largura,
      height: altura,
      color: Colors.grey.shade300,
      child: const Icon(Icons.restaurant, color: oliva),
    );
    final endereco = url;

    if (endereco == null || endereco.isEmpty) return alternativa;

    return Image.network(
      endereco,
      width: largura,
      height: altura,
      fit: BoxFit.cover,
      errorBuilder: (context, erro, pilha) => alternativa,
    );
  }
}