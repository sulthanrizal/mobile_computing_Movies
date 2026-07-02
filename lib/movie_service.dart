import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movie_model.dart';

class MovieService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YzNhZWQ3NzAwYTY4NjlhZDU0OGY5MDE3MTUxMzVjNiIsIm5iZiI6MTczMzcyMTY5MS43MTgwMDAyLCJzdWIiOiI2NzU2N2U1YjA5ODJiNDYyNjc4YTIwNTciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.GX7is4nB_NlQR8jNGu7xigLrFM3oWzM9xZyyoFGDNCQ',
      'accept': 'application/json',
    },
  ));

  static const String _cacheKey = 'cached_movies_list';

  static const Map<int, String> _genreMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Sci-Fi',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };

  String _getGenres(List<dynamic>? ids) {
    if (ids == null || ids.isEmpty) return 'General';
    final names = ids
        .map((id) => _genreMap[id] ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
    return names.isEmpty ? 'General' : names.join(' / ');
  }

  // Mengambil daftar film secara asinkron dari TMDB API
  // Mengembalikan record (List<Movie>, bool isOffline)
  Future<(List<Movie>, bool)> fetchMovies() async {
    try {
      final response = await _dio.get('movie/popular');
      if (response.statusCode == 200) {
        final List results = response.data['results'] ?? [];
        final movies = results.map((json) {
          final posterPath = json['poster_path'] as String?;
          final imageUrl = posterPath != null
              ? 'https://image.tmdb.org/t/p/w500$posterPath'
              : '';

          return Movie(
            id: json['id'] as int? ?? 0,
            title: json['title'] ?? json['original_title'] ?? 'No Title',
            date: json['release_date'] ?? '2024-01-01',
            rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
            imageUrl: imageUrl,
            genre: _getGenres(json['genre_ids']),
            duration: '120 min', // Default placeholder, runtime details fetched asynchronously
            synopsis: json['overview'] ?? '',
          );
        }).toList();

        // Simpan ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final jsonList = movies.map((m) => m.toJson()).toList();
        await prefs.setString(_cacheKey, jsonEncode(jsonList));

        return (movies, false);
      } else {
        throw Exception('Gagal memuat film dari API: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback ke data cache jika tidak ada internet
      try {
        final prefs = await SharedPreferences.getInstance();
        final cachedString = prefs.getString(_cacheKey);
        if (cachedString != null) {
          final List decoded = jsonDecode(cachedString);
          final movies = decoded.map((item) => Movie.fromJson(item)).toList();
          return (movies, true);
        }
      } catch (_) {
        // Hiraukan error cache agar error asli yang dilempar
      }
      rethrow;
    }
  }

  // Mengambil detail durasi (runtime) film dari TMDB API
  Future<String> fetchDuration(int id) async {
    if (id == 0) return '120 min';
    try {
      final response = await _dio.get('movie/$id');
      if (response.statusCode == 200) {
        final runtime = response.data['runtime'] as int?;
        if (runtime != null && runtime > 0) {
          return '$runtime min';
        }
      }
      return '120 min';
    } catch (_) {
      return '120 min'; // Fallback jika offline/gagal
    }
  }
}
