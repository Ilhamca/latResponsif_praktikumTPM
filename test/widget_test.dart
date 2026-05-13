// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:lat_responsif_prak_tpm/main.dart';

void main() {
  setUpAll(() async {
    final Directory tempDir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(tempDir.path);
    await Hive.openBox<String>('users');
    await Hive.box<String>('users').put('Username', 'admin123');
    Get.testMode = true;
  });

  testWidgets('menampilkan login dan bisa masuk ke home', (WidgetTester tester) async {
    await tester.pumpWidget(const InfoHubApp());

    expect(find.text('Login Info Hub'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Username');
    await tester.enterText(find.byType(TextFormField).at(1), 'admin123');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Hai, Username!'), findsOneWidget);
    expect(find.text('News'), findsOneWidget);
    expect(find.text('Blog'), findsOneWidget);
    expect(find.text('Report'), findsOneWidget);
  });
}
