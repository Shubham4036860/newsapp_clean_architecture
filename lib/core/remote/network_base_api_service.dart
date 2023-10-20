abstract class BaseApiService {
   String newsAPIBaseURL = 'newsapi.org';
   String newsAPIKey = 'A34f17e6e15b4990b992da88c477a2d6';

   Future<dynamic> getAllNewsResponse(String url, String countryCode, String newsType);

}
