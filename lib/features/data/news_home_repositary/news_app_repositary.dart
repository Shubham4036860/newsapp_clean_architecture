import 'package:news_app/core/remote/api_endpoint.dart';
import 'package:news_app/core/remote/network_api_service.dart';
import 'package:news_app/core/remote/network_base_api_service.dart';
import 'package:news_app/features/data/news_home_repositary/news_repo.dart';

class MainNewsAppRepo extends NewsRepo {
  final BaseApiService apiService = NetworkApiService();

  @override
  Future getNewsData(String countryCode, String newsType) async {
    try {
      print("countryCode -->> $countryCode");
      dynamic response = await apiService.getAllNewsResponse(ApiEndPoints().getNewsList, countryCode, newsType);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
