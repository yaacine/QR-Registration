class Sheet{
  String id;
  String name;

  Sheet({this.id, this.name});

  factory Sheet.fromJson(Map<String, dynamic> json) {
    return Sheet(
      id: json['id'],
      name: json['name']
    );
  }

}