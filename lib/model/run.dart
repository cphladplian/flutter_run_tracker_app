class Run {
  String? id;
  String where;
  double distance;
  int person;

  Run({
    this.id,
    required this.where,
    required this.distance,
    required this.person,
  });

  factory Run.fromJson(Map<String, dynamic> json) {
    return Run(
      id: json['id'],
      where: json['runWhere'],
      distance: double.parse(json['runDistance'].toString()),
      person: int.parse(json['runPerson'].toString()),
    );
}

  Map<String, dynamic> toJson() {
    return {
      'runWhere': where,
      'runDistance': distance,
      'runPerson': person,
    };
  }
}