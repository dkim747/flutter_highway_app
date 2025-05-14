import 'package:json_annotation/json_annotation.dart';

part 'favorites.g.dart';

@JsonSerializable()
class Favorites{
  final String id;
  final String type;
  // final T object;

  Favorites({
    required this.id,
    required this.type
    // required this.object
  });

  Map<String, dynamic> toJson() =>
      _$FavoritesToJson(this);

  factory Favorites.fromJson(Map<String, dynamic> json) =>
      _$FavoritesFromJson(json);
}