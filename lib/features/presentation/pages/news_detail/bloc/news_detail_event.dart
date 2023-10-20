abstract class NewsDetailEvent {}

class NewsDetailDataEvent extends NewsDetailEvent {
  final String shareURl;

  NewsDetailDataEvent(this.shareURl);
}
