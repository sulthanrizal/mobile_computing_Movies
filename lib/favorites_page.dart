import 'package:flutter/material.dart';
import 'movie_model.dart';
import 'details_movies.dart';
import 'favorite_bloc.dart';

class FavoritesPage extends StatelessWidget {
  final List<Movie> allMovies;

  const FavoritesPage({
    super.key,
    required this.allMovies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Film Favorit',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
        ),
      ),
      // StreamBuilder: Mendengarkan perubahan status favorit film secara real-time dari BLoC
      body: StreamBuilder<Set<String>>(
        stream: FavoriteBloc.instance.favoritesStream,
        initialData: FavoriteBloc.instance.currentFavorites,
        builder: (context, snapshot) {
          final favorites = snapshot.data ?? {};
          
          // Memfilter film berdasarkan data set favorit terbaru
          final favoriteMovies = allMovies
              .where((movie) => favorites.contains(movie.title))
              .toList();

          if (favoriteMovies.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
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
                              child: Image.network(
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
                                      movie.date.split('-')[0],
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
                          // Bookmark button: Mengirim event toggle langsung ke BLoC
                          IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              color: Colors.amber[700],
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
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_border_rounded,
                size: 80,
                color: Colors.indigo[300],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Data Favorite tidak ada',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Belum ada film yang kamu tandai sebagai favorit. Mulai jelajahi film dan tandai film favoritmu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

