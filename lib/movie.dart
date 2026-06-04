import 'package:flutter/material.dart';

class MoviesCatalog extends StatelessWidget {
  const MoviesCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = [
      const Movie(
        title: 'Inception',
        date: '2010-07-15',
        rating: 8.4,
        imageUrl: 'https://image.tmdb.org/t/p/w92/bvYjhsbxOBwpm8xLE5BhdA3a8CZ.jpg',
      ),
      const Movie(
        title: 'Interstellar',
        date: '2014-11-07',
        rating: 8.6,
        imageUrl: 'https://image.tmdb.org/t/p/w185/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg',
      ),
      const Movie(
        title: 'Tenet',
        date: '2020-08-22',
        rating: 7.3,
        imageUrl: 'https://image.tmdb.org/t/p/w500/laMM4lpQSh5z6KIBPwWogkjzBVQ.jpg',
      ),
      const Movie(
        title: 'The Dark Knight Rises',
        date: '2012-07-16',
        rating: 7.8,
        imageUrl: 'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
      ),
      const Movie(
        title: 'Avatar: The Way of Water',
        date: '2022-12-14',
        rating: 7.6,
        imageUrl: 'https://image.tmdb.org/t/p/original/oDKbJFvnPyCk7pDX2xttSxXEWXW.jpg',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[200],
            height: 1.0,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image container using lib/img1.jpeg
                Container(
                  width: 80,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
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
                const SizedBox(width: 16),
                // Movie details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        movie.date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Movie {
  final String title;
  final String date;
  final double rating;
  final String imageUrl;

  const Movie({
    required this.title,
    required this.date,
    required this.rating,
    required this.imageUrl,
  });
}