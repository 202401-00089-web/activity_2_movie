class Film {
  final String id;
  final String title;
  final String romanisedTitle;
  final String description;
  final String director;
  final String releaseYear;
  final int runningTime; // minutes
  final int rtScore; // Rotten Tomatoes score
  final String posterUrl;
  final String bannerUrl;

  const Film({
    required this.id,
    required this.title,
    required this.romanisedTitle,
    required this.description,
    required this.director,
    required this.releaseYear,
    required this.runningTime,
    required this.rtScore,
    required this.posterUrl,
    required this.bannerUrl,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'] as String,
      title: json['title'] as String,
      romanisedTitle: (json['original_title_romanised'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      director: (json['director'] ?? 'Unknown') as String,
      releaseYear: '${json['release_date'] ?? ''}',
      runningTime: int.tryParse('${json['running_time']}') ?? 0,
      rtScore: int.tryParse('${json['rt_score']}') ?? 0,
      posterUrl: (json['image'] ?? '') as String,
      bannerUrl: (json['movie_banner'] ?? '') as String,
    );
  }
}
