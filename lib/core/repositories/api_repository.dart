import '../services/api.dart';

class ApiRepository {
  final Api? _api;

  ApiRepository({required Api? api}) : _api = api;

  Future<Map<String, dynamic>> getApps(String serialNumber) async {
    return _api!.getData("apps/$serialNumber");
  }

  void notifyDownload(String appUuid, String versionUuid) {
    _api!.getData("notify/download//$appUuid/$versionUuid");
  }

  Future<Map<String, dynamic>> syncTerminal(
      Map<String, dynamic> request) async {
    return _api!.postData(request, "terminal/sync");
  }

  Future<Map<String, dynamic>> validateConnection(
      String connectionId, String serialNumber) async {
    return _api!
        .getData("remote/connection/validate/$serialNumber/$connectionId");
  }
}
