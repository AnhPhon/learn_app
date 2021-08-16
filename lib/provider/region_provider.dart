import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/region.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/region_repo.dart';

class RegionProvider {
  RegionRepo? regionRepo = GetIt.I.get<RegionRepo>();

  RegionProvider();

  Future<void> getRegions({
    required Function(List<Region> regions) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.getRegions();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => Region.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }
}
