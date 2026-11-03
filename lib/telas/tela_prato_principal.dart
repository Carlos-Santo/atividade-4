import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_bebida.dart';

const List<ItemCardapio> pratosPrincipais = [
  ItemCardapio('Filé à parmegiana', 42.90),
  ItemCardapio('Frango grelhado com legumes', 34.50),
  ItemCardapio('Lasanha à bolonhesa', 38.00),
  ItemCardapio('Risoto de cogumelos', 45.75),
];

/// Tela 1 — primeira tela da pilha (início do pedido).
class TelaPratoPrincipal extends StatefulWidget {
  const TelaPratoPrincipal({super.key});

  @override
  State<TelaPratoPrincipal> createState() => _TelaPratoPrincipalState();
}

class _TelaPratoPrincipalState extends State<TelaPratoPrincipal> {
  // Fica guardado no State: ao voltar das próximas telas (pop),
  // esta tela continua na pilha e a escolha permanece selecionada.
  ItemCardapio? pratoSelecionado;

  void avancar() {
    final prato = pratoSelecionado;
    if (prato == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaBebida(prato: prato)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. Prato principal')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Escolha o prato principal:'),
          ),
          Expanded(
            child: RadioGroup<ItemCardapio>(
              groupValue: pratoSelecionado,
              onChanged: (item) => setState(() => pratoSelecionado = item),
              child: ListView(
                children: [
                  for (final item in pratosPrincipais)
                    RadioListTile<ItemCardapio>(
                      value: item,
                      title: Text(item.nome),
                      subtitle: Text(formatarValor(item.valor)),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: pratoSelecionado == null ? null : avancar,
              child: const Text('Avançar'),
            ),
          ),
        ],
      ),
    );
  }
}
