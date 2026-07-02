import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'details_movies.dart';
import 'favorites_page.dart';
import 'movie_service.dart';
import 'favorite_bloc.dart';
import 'movie_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final MovieService? movieService;
  const MyApp({super.key, this.movieService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(movieService ?? MovieService())..add(FetchMovies()),
      child: MaterialApp(
        title: 'Movie Catalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Movie Catalog',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoaded) {
                final movies = state.movies;
                return IconButton(
                  icon: const Icon(
                    Icons.bookmark,
                    color: Colors.indigo,
                  ),
                  tooltip: 'Film Favorit',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesPage(allMovies: movies),
                      ),
                    );
                  },
                );
              }
              return const IconButton(
                icon: Icon(
                  Icons.bookmark_border,
                  color: Colors.grey,
                ),
                onPressed: null,
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
        ),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitial || state is MovieLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.indigo),
                  const SizedBox(height: 16),
                  Text(
                    'Memuat daftar film...',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            );
          } else if (state is MovieError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 16),
                    Text(
                      'Terjadi kesalahan:\n${state.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<MovieBloc>().add(FetchMovies());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is MovieLoaded) {
            final movies = state.movies;

            if (movies.isEmpty) {
              return const Center(
                child: Text('Daftar film kosong.'),
              );
            }

            return Column(
              children: [
                if (state.isOffline)
                  Container(
                    width: double.infinity,
                    color: Colors.orange[800],
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.offline_bolt, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Mode Offline: Menampilkan data cache lokal',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: StreamBuilder<Set<String>>(
                    stream: FavoriteBloc.instance.favoritesStream,
                    initialData: FavoriteBloc.instance.currentFavorites,
                    builder: (context, favoriteSnapshot) {
                      final favorites = favoriteSnapshot.data ?? {};

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          final isFavorite = favorites.contains(movie.title);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Card(
                              color: Colors.white,
                              elevation: 2,
                              shadowColor: const Color.fromARGB(20, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                mouseCursor: SystemMouseCursors.click,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailPage(movie: movie),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Image container dengan Hero animation
                                      Hero(
                                        tag: 'movie-image-${movie.title}',
                                        child: Container(
                                          width: 80,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: movie.imageUrl.isNotEmpty
                                              ? Image.network(
                                                  movie.imageUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      color: Colors.grey[300],
                                                      child: const Icon(Icons.broken_image, color: Colors.grey),
                                                    );
                                                  },
                                                  loadingBuilder: (context, child, loadingProgress) {
                                                    if (loadingProgress == null) return child;
                                                    return Container(
                                                      color: Colors.grey[200],
                                                      child: const Center(
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2.0,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  color: Colors.grey[300],
                                                  child: const Icon(Icons.movie, color: Colors.grey),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Movie details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              movie.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              movie.genre,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  movie.rating.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.grey[400],
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  movie.date.isNotEmpty ? movie.date.split('-')[0] : 'Unknown',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Bookmark button
                                      IconButton(
                                        icon: Icon(
                                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                                          color: isFavorite ? Colors.amber[700] : Colors.grey[400],
                                        ),
                                        onPressed: () {
                                          FavoriteBloc.instance.toggleFavorite(movie.title);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
