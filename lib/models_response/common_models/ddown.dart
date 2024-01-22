class DDown {
  DDown({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory DDown.fromJson(Map<String, dynamic> json) => DDown(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };

  String getIds(List<DDown> data) {
    List<int> tmp = [];

    data.forEach((element) {
      tmp.add(element.id!);
    });
    return tmp.toString();
  }

  DDown.initialState()
      : id = 0,
        name = '';
}
