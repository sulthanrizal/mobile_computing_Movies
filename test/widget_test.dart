import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Movie Catalog smoke and loading test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // 1. Verifikasi bahwa state loading awal FutureBuilder berjalan
    expect(find.text('Memuat daftar film...'), findsOneWidget);
    expect(find.text('Inception'), findsNothing);

    // 2. Majukan waktu agar Future selesai (delay 1.5 detik di MovieService)
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    // 3. Verifikasi bahwa data film telah berhasil dimuat dan ditampilkan
    expect(find.text('Memuat daftar film...'), findsNothing);
    expect(find.text('Inception'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);
  });
}
