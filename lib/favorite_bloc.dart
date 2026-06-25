import 'dart:async';

class FavoriteBloc {
  // Singleton pattern untuk memastikan seluruh aplikasi menggunakan instance BLoC yang sama
  static final FavoriteBloc _instance = FavoriteBloc._internal();
  static FavoriteBloc get instance => _instance;

  FavoriteBloc._internal() {
    // Kirim data awal ke stream
    _favoritesController.add(_favorites);
  }

  // Menyimpan kumpulan judul film yang disukai
  final Set<String> _favorites = {};

  // StreamController dengan tipe broadcast agar bisa didengarkan oleh banyak widget sekaligus
  // (misal: HomePage, FavoritesPage, dan MovieDetailPage)
  final StreamController<Set<String>> _favoritesController = StreamController<Set<String>>.broadcast();

  // Output: Stream yang memancarkan data set favorit terbaru
  Stream<Set<String>> get favoritesStream => _favoritesController.stream;

  // Getter untuk mendapatkan data favorit saat ini (berguna untuk initialData di StreamBuilder)
  Set<String> get currentFavorites => Set.unmodifiable(_favorites);

  // Input/Event: Memicu aksi toggle status favorit film
  void toggleFavorite(String movieTitle) {
    if (_favorites.contains(movieTitle)) {
      _favorites.remove(movieTitle);
    } else {
      _favorites.add(movieTitle);
    }
    // Kirim salinan set favorit terbaru ke dalam Stream
    _favoritesController.sink.add(Set.from(_favorites));
  }

  // Menutup stream controller saat BLoC tidak lagi digunakan
  void dispose() {
    _favoritesController.close();
  }
}
