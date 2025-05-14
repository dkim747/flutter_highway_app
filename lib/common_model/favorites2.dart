class Favorites2<T> {

  final String type;
  final T object;

  Favorites2({
    required this.type,
    required this.object,
  });

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonFunc) => {
    'type': type,
    'object': toJsonFunc(object)
  };

  factory Favorites2.fromJson(Map<String, dynamic> json,T Function(Map<String, dynamic>) fromJsonFunc,) {

    return Favorites2(type: json['type'] as String, object: fromJsonFunc(json['object']));
  }
}