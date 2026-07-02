import 'package:flutter/material.dart';
import 'movie_model.dart';
import 'favorite_bloc.dart';
import 'movie_service.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Flexible Movie Banner
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: Colors.indigo,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black38,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
                child: StreamBuilder<Set<String>>(
                  stream: FavoriteBloc.instance.favoritesStream,
                  initialData: FavoriteBloc.instance.currentFavorites,
                  builder: (context, snapshot) {
                    final favorites = snapshot.data ?? {};
                    final isFavorite = favorites.contains(movie.title);

                    return CircleAvatar(
                      backgroundColor: Colors.black38,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          color: isFavorite ? Colors.amber : Colors.white,
                        ),
                        onPressed: () {
                          FavoriteBloc.instance.toggleFavorite(movie.title);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'movie-image-${movie.title}',
                    child: Image.network(
                      movie.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 64, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                        ],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Movie Detail Content
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.genre,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo[600],
                  ),
                ),
                const SizedBox(height: 20),
                // Metadata cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetaCard(
                      icon: Icons.star,
                      iconColor: Colors.amber,
                      label: 'Rating',
                      value: '${movie.rating} / 10',
                    ),
                    _buildMetaCard(
                      icon: Icons.calendar_month,
                      iconColor: Colors.blueAccent,
                      label: 'Rilis',
                      value: movie.date,
                    ),
                    FutureBuilder<String>(
                      future: MovieService().fetchDuration(movie.id),
                      initialData: movie.duration,
                      builder: (context, snapshot) {
                        return _buildMetaCard(
                          icon: Icons.timer,
                          iconColor: Colors.deepPurpleAccent,
                          label: 'Durasi',
                          value: snapshot.data ?? movie.duration,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(height: 1),
                const SizedBox(height: 20),
                const Text(
                  'Sinopsis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  movie.synopsis,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

