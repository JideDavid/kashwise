import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class MDisplayPic extends StatelessWidget {
  const MDisplayPic({super.key, required this.url});

   final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        height: SizeConfig.screenWidth * 0.12,
        width: SizeConfig.screenWidth * 0.12,
        child: CachedNetworkImage(
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress, color: Theme.of(context).primaryColor,),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
