import 'package:flutter/material.dart';
import 'details_movies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<String> _favorites = {};

  final List<Movie> _movies = const [
    Movie(
      title: 'Inception',
      date: '2010-07-15',
      rating: 8.4,
      imageUrl: 'https://image.tmdb.org/t/p/w92/bvYjhsbxOBwpm8xLE5BhdA3a8CZ.jpg',
      genre: 'Sci-Fi / Action',
      duration: '148 min',
      synopsis: 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O. as redemption for his past crimes.',
    ),
    Movie(
      title: 'Interstellar',
      date: '2014-11-07',
      rating: 8.6,
      imageUrl: 'https://image.tmdb.org/t/p/w185/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg',
      genre: 'Sci-Fi / Adventure',
      duration: '169 min',
      synopsis: 'In Earth\'s future, a global crop blight and second Dust Bowl are slowly rendering the planet uninhabitable. A team of explorers travels through a wormhole in space in an attempt to ensure humanity\'s survival.',
    ),
    Movie(
      title: 'Tenet',
      date: '2020-08-22',
      rating: 7.3,
      imageUrl: 'https://image.tmdb.org/t/p/w500/laMM4lpQSh5z6KIBPwWogkjzBVQ.jpg',
      genre: 'Action / Sci-Fi',
      duration: '150 min',
      synopsis: 'Armed with only one word, Tenet, and fighting for the survival of the entire world, a protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.',
    ),
    Movie(
      title: 'The Dark Knight Rises',
      date: '2012-07-16',
      rating: 7.8,
      imageUrl: 'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
      genre: 'Action / Thriller',
      duration: '164 min',
      synopsis: 'Eight years after the Joker\'s reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane.',
    ),
    Movie(
      title: 'Avatar: The Way of Water',
      date: '2022-12-14',
      rating: 7.6,
      imageUrl: 'https://image.tmdb.org/t/p/original/oDKbJFvnPyCk7pDX2xttSxXEWXW.jpg',
      genre: 'Sci-Fi / Action',
      duration: '192 min',
      synopsis: 'Jake Sully lives with his newfound family formed on the extraterrestrial planet of Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
    ),
  ];

  void _toggleFavorite(String movieTitle) {
    setState(() {
      if (_favorites.contains(movieTitle)) {
        _favorites.remove(movieTitle);
      } else {
        _favorites.add(movieTitle);
      }
    });
  }

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
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          final isFavorite = _favorites.contains(movie.title);
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
                      builder: (context) => MovieDetailPage(
                        movie: movie,
                        isFavoriteInitially: isFavorite,
                        onFavoriteToggle: () => _toggleFavorite(movie.title),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image container with Hero animation
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
                      // Bookmark button
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          color: isFavorite ? Colors.amber[700] : Colors.grey[400],
                        ),
                        onPressed: () => _toggleFavorite(movie.title),
                      ),
                    ],
                  ),
                ),
              ),
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
  final String genre;
  final String duration;
  final String synopsis;

  const Movie({
    required this.title,
    required this.date,
    required this.rating,
    required this.imageUrl,
    required this.genre,
    required this.duration,
    required this.synopsis,
  });
}
