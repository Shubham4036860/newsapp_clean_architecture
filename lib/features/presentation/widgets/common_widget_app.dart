import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/appfonts/app_fonts.dart';
import 'package:news_app/config/theme/app_theme.dart';

Widget getNetworkImageView(String imageURL, {double? width, double? height, BoxFit? boxFit, bool isShowLoader = true}) {
  return ExtendedImage.network(
    imageURL,
    fit: boxFit ?? BoxFit.cover,
    cache: true,
    // Enable caching of the image
    clearMemoryCacheWhenDispose: true,
    // Clear memory cache when widget is disposed
    loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Container(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            alignment: Alignment.center,
            margin: isShowLoader ? EdgeInsets.zero : const EdgeInsets.only(top: 12),
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        case LoadState.completed:
          return null;
        case LoadState.failed:
          return SizedBox(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            child: Image.asset(
              "assets/images/error_image.jpg",
              fit: BoxFit.contain,
            ),
          );
      }
    },
    enableMemoryCache: true,
  );
}

getCenterLoadingView() {
  return const Center(
    child: CircularProgressIndicator(
      color: colorBlue,
    ),
  );
}

Widget noDataFound() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Text(
          'No data Found',
          style: CustomTextStyles.boldText(color: colorBlack, fontSize: 15),
        ),
      )
    ],
  );
}

getAppBarCommon(BuildContext context, Widget titleWidget, {Widget? leadingWidget}) {
  return AppBar(
    centerTitle: true,
    title: titleWidget,
    leading: leadingWidget,
  );
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  print('connectivityResult $connectivityResult}');
  if (connectivityResult == ConnectivityResult.none) {
    print('No internet connection false');
    return false;
  } else {
    print('No internet connection true');
    return true;
  }
}
