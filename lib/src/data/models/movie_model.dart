class MovieModel {
  MovieModel({
    this.id,
    this.title,
    this.year,
    this.genre,
    this.plot,
    this.coverImg,
    this.imdRating,
    this.type,
  });

  String? id;
  String? title;
  String? year;
  List<String>? genre;
  String? plot;
  String? coverImg;
  String? imdRating;
  String? type;

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    genre = json['genre'].cast<String>();
    plot = json['plot'];
    coverImg = json['coverImg'];
    imdRating = json['imdRating'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = title;
    data['title'] = title;
    data['year'] = year;
    data['genre'] = genre;
    data['plot'] = plot;
    data['coverImg'] = coverImg;
    data['imdRating'] = imdRating;
    data['type'] = type;
    return data;
  }
}
