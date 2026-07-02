import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc {
  // Singleton pattern untuk memastikan seluruh aplikasi menggunakan instance BLoC yang sama
  static final FavoriteBloc _instance = FavoriteBloc._internal();
  static FavoriteBloc get instance => _instance;

  FavoriteBloc._internal() {
    _loadFavorites();
  }

  static const String _favKey = 'favorites_titles';

  // Menyimpan kumpulan judul film yang disukai
  final Set<String> _favorites = {};

  // StreamController dengan tipe broadcast agar bisa didengarkan oleh banyak widget sekaligus
  // (misal: HomePage, FavoritesPage, dan MovieDetailPage)
  final StreamController<Set<String>> _favoritesController = StreamController<Set<String>>.broadcast();

  // Output: Stream yang memancarkan data set favorit terbaru
  Stream<Set<String>> get favoritesStream => _favoritesController.stream;

  // Getter untuk mendapatkan data favorit saat ini (berguna untuk initialData di StreamBuilder)
  Set<String> get currentFavorites => Set.unmodifiable(_favorites);

  // Memuat favorites dari local storage
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedFavs = prefs.getStringList(_favKey);
      if (savedFavs != null) {
        _favorites.addAll(savedFavs);
        _favoritesController.sink.add(Set.from(_favorites));
      } else {
        _favoritesController.add(_favorites);
      }
    } catch (_) {
      _favoritesController.add(_favorites);
    }
  }

  // Input/Event: Memicu aksi toggle status favorit film
  void toggleFavorite(String movieTitle) async {
    if (_favorites.contains(movieTitle)) {
      _favorites.remove(movieTitle);
    } else {
      _favorites.add(movieTitle);
    }
    // Kirim salinan set favorit terbaru ke dalam Stream
    _favoritesController.sink.add(Set.from(_favorites));

    // Simpan ke local storage
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_favKey, _favorites.toList());
    } catch (_) {}
  }

  // Menutup stream controller saat BLoC tidak lagi digunakan
  void dispose() {
    _favoritesController.close();
  }
}
