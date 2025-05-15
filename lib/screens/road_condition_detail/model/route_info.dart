class RouteInfo {
  final String routeCd;
  final String driveDrctDc;
  final String nodeCtltNm;
  final String linkKmDstne;
  final String? cctvNm;
  final String? cctvUrl;
  final double spd;

  RouteInfo({
    required this.routeCd,
    required this.driveDrctDc,
    required this.nodeCtltNm,
    required this.linkKmDstne,
    this.cctvNm,
    this.cctvUrl,
    required this.spd
  });
}