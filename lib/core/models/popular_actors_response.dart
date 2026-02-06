class PopularActorsResponse {
  final int page;
  final List<Actor> results;
  final int totalPages;
  final int totalResults;

  PopularActorsResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularActorsResponse.fromJson(Map<String, dynamic> json) =>
      PopularActorsResponse(
        page: json["page"],
        results: List<Actor>.from(
          json["results"].map((x) => Actor.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Actor {
  final bool adult;
  final int gender;
  final int id;
  final List<KnownFor> knownFor;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String? profilePath;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    this.profilePath,
  });

  String get fullProfilePath {
    if (profilePath == null) return '';
    return 'https://image.tmdb.org/t/p/w500$profilePath';
  }

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        adult: json["adult"] ?? false,
        gender: json["gender"] ?? 0,
        id: json["id"],
        knownFor: json["known_for"] != null
            ? List<KnownFor>.from(
                json["known_for"].map((x) => KnownFor.fromJson(x)),
              )
            : [],
        knownForDepartment: json["known_for_department"] ?? "",
        name: json["name"] ?? "",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for": List<dynamic>.from(knownFor.map((x) => x.toJson())),
        "known_for_department": knownForDepartment,
        "name": name,
        "popularity": popularity,
        "profile_path": profilePath,
      };
}

class KnownFor {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String? title;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final String? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final String? name;
  final String? originalName;
  final String? firstAirDate;
  final List<String>? originCountry;

  KnownFor({
    required this.adult,
    this.backdropPath,
    required this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    required this.mediaType,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: json["media_type"] ?? "",
        genreIds: json["genre_ids"] != null
            ? List<int>.from(json["genre_ids"].map((x) => x))
            : null,
        popularity: json["popularity"]?.toDouble(),
        releaseDate: json["release_date"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
        firstAirDate: json["first_air_date"],
        originCountry: json["origin_country"] != null
            ? List<String>.from(json["origin_country"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "genre_ids": genreIds != null
            ? List<dynamic>.from(genreIds!.map((x) => x))
            : null,
        "popularity": popularity,
        "release_date": releaseDate,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "first_air_date": firstAirDate,
        "origin_country": originCountry != null
            ? List<dynamic>.from(originCountry!.map((x) => x))
            : null,
      };
}
