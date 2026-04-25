class MuscleModel {
  final String? id;
  final String? name;
  final String? image;

  MuscleModel({required this.id, required this.name, required this.image});

  factory MuscleModel.fromJson(Map<String, dynamic> json) {
    return MuscleModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

}
