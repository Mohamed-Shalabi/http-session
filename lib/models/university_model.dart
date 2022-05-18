class UniversityModel {
  final String name;
  final List<String> webPages;

  UniversityModel.fromMap(final Map<String, dynamic> map)
      : name = map['name'],
        webPages = map['web_pages'].cast<String>();

  Map<String, dynamic> toMap() => {
        'name': name,
        'web_pages': webPages,
      };
}
