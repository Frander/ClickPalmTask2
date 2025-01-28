class Visit {
  final int idVisit;
  final int idCompany;
  final String createdAt;
  final String descriptionVisit;


  Visit({
    required this.idVisit,
    required this.idCompany,
    required this.createdAt,
    required this.descriptionVisit,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      idVisit: json['id_visit'],
      idCompany: json['id_company'],
      createdAt: json['created_at'],
      descriptionVisit: json['description_visit'],
    );
  }
}