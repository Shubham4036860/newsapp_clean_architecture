abstract class NewsEvent {}

class NewsFetchDataEvent extends NewsEvent {
  final String countryCode;
  final String newsType;
  NewsFetchDataEvent(this.countryCode,this.newsType);
}
