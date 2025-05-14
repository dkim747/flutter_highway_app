import 'package:json_annotation/json_annotation.dart';
import '../interface/jsonencodable_interface.dart';

part 'routes.g.dart';

@JsonSerializable()
class Routes
    // implements JsonEncodable
{

  final String routeName;
  final String routeNo;
  final String startPoint;
  final String endPoint;

  Routes({
    required this.routeName,
    required this.routeNo,
    required this.startPoint,
    required this.endPoint
  });

  // @override
  // Map<String, dynamic> toJson2() => {
  //
  //   'routeName': routeName,
  //   'routeNo': routeNo
  // };

  // @override
  // String toString() => '$routeName ($routeNo)';

  factory Routes.fromJson(Map<String, dynamic> json) =>
       _$RoutesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RoutesToJson(this);
}