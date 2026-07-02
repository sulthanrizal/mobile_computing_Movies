import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/movie_model.dart';
import 'package:flutter_application_1/movie_service.dart';

class MockMovieService extends MovieService {
  @override
  Future<(List<Movie>, bool)> fetchMovies() async {
    // Memberikan delay kecil untuk memicu state loading di widget test
    await Future.delayed(const Duration(milliseconds: 100));
    return (const [
      Movie(
        id: 1,
        title: 'Inception',
        date: '2010-07-15',
        rating: 8.4,
        imageUrl: '',
        genre: 'Sci-Fi / Action',
        duration: '148 min',
        synopsis: 'Synopsis...',
      ),
      Movie(
        id: 2,
        title: 'Interstellar',
        date: '2014-11-07',
        rating: 8.6,
        imageUrl: '',
        genre: 'Sci-Fi / Adventure',
        duration: '169 min',
        synopsis: 'Synopsis...',
      ),
    ], false);
  }
}

void main() {
  testWidgets('Movie Catalog smoke and loading test', (WidgetTester tester) async {
    final mockService = MockMovieService();
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(movieService: mockService));

    // 1. Verifikasi bahwa state loading awal FutureBuilder/Bloc berjalan
    expect(find.text('Memuat daftar film...'), findsOneWidget);
    expect(find.text('Inception'), findsNothing);

    // 2. Majukan waktu agar asynchronous loading selesai
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // 3. Verifikasi bahwa data film telah berhasil dimuat dan ditampilkan
    expect(find.text('Memuat daftar film...'), findsNothing);
    expect(find.text('Inception'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);
  });
}
