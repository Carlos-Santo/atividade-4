import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_prato_principal.dart';

/// Tela 5 — resumo do pedido. Não permite voltar às etapas anteriores.
class TelaFinalizacao extends StatelessWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;
  final String formaPagamento;

  const TelaFinalizacao({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
    required this.formaPagamento,
  });

  double get total => prato.valor + bebida.valor + sobremesa.valor;

  void novoPedido(BuildContext context) {
    // Cria uma nova TelaPratoPrincipal (estado novo = escolhas reiniciadas).
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TelaPratoPrincipal()),
      (rota) => false,
    );
  }

  Widget linhaItem(String categoria, ItemCardapio item) {
    return ListTile(
      title: Text(item.nome),
      subtitle: Text(categoria),
      trailing: Text(formatarValor(item.valor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final estiloTotal = Theme.of(context).textTheme.titleMedium
        ?.copyWith(fontWeight: FontWeight.bold);

    // Bloqueia o botão "voltar" do sistema: a única ação é "Novo pedido".
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('5. Pedido finalizado'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Column(
                children: [
                  linhaItem('Prato principal', prato),
                  linhaItem('Bebida', bebida),
                  linhaItem('Sobremesa', sobremesa),
                  const Divider(),
                  ListTile(
                    title: Text('Total', style: estiloTotal),
                    trailing: Text(formatarValor(total), style: estiloTotal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.payments_outlined),
                title: const Text('Forma de pagamento'),
                subtitle: Text(formaPagamento),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => novoPedido(context),
              child: const Text('Novo pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
