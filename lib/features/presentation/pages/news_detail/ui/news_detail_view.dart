import 'package:flutter/material.dart';
import 'package:news_app/config/appfonts/app_fonts.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/features/presentation/widgets/common_widget_app.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailView extends StatefulWidget {
  final String title;
  final String source;
  final String description;
  final String imageOFNews;
  final String publishAT;
  final String contentOfNews;

  const NewsDetailView(
      {super.key,
      required this.title,
      required this.source,
      required this.description,
      required this.imageOFNews,
      required this.publishAT,
      required this.contentOfNews});

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: getAppBarCommon(
          context,
          Text(
            'News Detail',
            style: CustomTextStyles.mediumText(color: colorBlue, fontSize: 22),
          ),
          leadingWidget: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: colorBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              imageOfNews(widget.imageOFNews),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [source(widget.source), publishAt(widget.publishAT)],
                ),
              ),
              titleOfNews(widget.title),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 25),
                child: Text(
                  "News Description",
                  maxLines: 5,
                  style: CustomTextStyles.mediumText(color: colorBlack, fontSize: 18),
                ),
              ),
              descriptionOFNews(widget.description),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 25),
                child: Text(
                  "News Content",
                  maxLines: 5,
                  style: CustomTextStyles.mediumText(color: colorBlack, fontSize: 18),
                ),
              ),
              contentOfNews(widget.contentOfNews),
              shareIcon(context,widget.title,widget.imageOFNews)
            ],
          ),
        ),
      ),
    );
  }

  Widget source(
    String textOfSource,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 25),
      child: Text(
        textOfSource,
        style: CustomTextStyles.mediumText(color: colorGray, fontSize: 13),
      ),
    );
  }

  Widget publishAt(
    String publishAtDate,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 25),
      child: Text(
        publishAtDate,
        style: CustomTextStyles.mediumText(color: colorBlack, fontSize: 13),
      ),
    );
  }

  Widget shareIcon(BuildContext context,String titleOfNews,String urlOfNews) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(color: colorWhite, border: Border.all(color: colorBlue, width: 0.2), borderRadius: BorderRadius.circular(20)),
        child: GestureDetector(
          onTap: () {
            Share.share(
              '''$titleOfNews\n$urlOfNews''',
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.share,
                color: colorBlue,
                size: 25,
              ),
              Text(
                "Share News With Friends",
                style: CustomTextStyles.mediumText(color: colorBlack, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleOfNews(
    String titleOfNews,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 25),
      child: Text(
        titleOfNews,
        textAlign: TextAlign.start,
        style: CustomTextStyles.mediumText(color: colorBlack, fontSize: 20),
      ),
    );
  }

  Widget descriptionOFNews(
    String descriptionOfNews,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 25),
      child: Text(
        descriptionOfNews,
        maxLines: 5,
        style: CustomTextStyles.mediumText(color: colorBlack.withOpacity(0.5), fontSize: 15),
      ),
    );
  }

  Widget contentOfNews(
    String contentOfNews,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 25),
      child: Text(
        contentOfNews,
        maxLines: 5,
        style: CustomTextStyles.mediumText(color: colorBlack.withOpacity(0.5), fontSize: 15),
      ),
    );
  }

  Widget imageOfNews(String imageUrl) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: getNetworkImageView(imageUrl, boxFit: BoxFit.cover),
    );
  }
}
