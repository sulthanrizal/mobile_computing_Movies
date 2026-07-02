class Movie {
  final int id;
  final String title;
  final String date;
  final double rating;
  final String imageUrl;
  final String genre;
  final String duration;
  final String synopsis;

  const Movie({
    required this.id,
    required this.title,
    required this.date,
    required this.rating,
    required this.imageUrl,
    required this.genre,
    required this.duration,
    required this.synopsis,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      date: json['date'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      synopsis: json['synopsis'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'rating': rating,
      'imageUrl': imageUrl,
      'genre': genre,
      'duration': duration,
      'synopsis': synopsis,
    };
  }

  Movie copyWith({
    int? id,
    String? title,
    String? date,
    double? rating,
    String? imageUrl,
    String? genre,
    String? duration,
    String? synopsis,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      genre: genre ?? this.genre,
      duration: duration ?? this.duration,
      synopsis: synopsis ?? this.synopsis,
    );
  }
}
