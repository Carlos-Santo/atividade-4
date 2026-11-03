import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pedidos_restaurante/main.dart';

Future<void> tocar(WidgetTester tester, String texto) async {
  await tester.ensureVisible(find.text(texto));
  await tester.tap(find.text(texto));
  await tester.pumpAndSettle();
}

bool habilitado(WidgetTester tester, String texto) {
  final botao = tester.widget<ButtonStyleButton>(
    find.ancestor(
      of: find.text(texto),
      matching: find.byWidgetPredicate((w) => w is ButtonStyleButton),
    ),
  );
  return botao.onPressed != null;
}

void main() {
  testWidgets('monta o pedido, mantém escolhas ao voltar e reinicia', (
    tester,
  ) async {
    await tester.pumpWidget(const RootApp());

    expect(habilitado(tester, 'Avançar'), isFalse);
    await tocar(tester, 'Lasanha à bolonhesa');
    expect(habilitado(tester, 'Avançar'), isTrue);
    await tocar(tester, 'Avançar');

    await tocar(tester, 'Suco natural de laranja');
    await tocar(tester, 'Avançar');

    // Volta para a bebida: a escolha continua marcada.
    await tocar(tester, 'Voltar à bebida');
    expect(find.text('2. Bebida'), findsOneWidget);
    expect(habilitado(tester, 'Avançar'), isTrue);
    await tocar(tester, 'Avançar');

    await tocar(tester, 'Pudim de leite');
    await tocar(tester, 'Avançar');

    await tocar(tester, 'Pix');
    await tocar(tester, 'Finalizar pedido');

    expect(find.text('5. Pedido finalizado'), findsOneWidget);
    expect(find.text('R\$ 38,00'), findsOneWidget);
    expect(find.text('R\$ 9,80'), findsOneWidget);
    expect(find.text('R\$ 12,00'), findsOneWidget);
    expect(find.text('R\$ 59,80'), findsOneWidget);
    expect(find.text('Pix'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);

    await tocar(tester, 'Novo pedido');
    expect(find.text('1. Prato principal'), findsOneWidget);
    expect(habilitado(tester, 'Avançar'), isFalse);
  });

  testWidgets('voltar ao início mantém o prato escolhido', (tester) async {
    await tester.pumpWidget(const RootApp());
    await tocar(tester, 'Risoto de cogumelos');
    await tocar(tester, 'Avançar');
    await tocar(tester, 'Água mineral');
    await tocar(tester, 'Avançar');
    await tocar(tester, 'Voltar ao início');

    expect(find.text('1. Prato principal'), findsOneWidget);
    expect(habilitado(tester, 'Avançar'), isTrue);
  });
}
