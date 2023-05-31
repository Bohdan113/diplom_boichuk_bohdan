import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom_boichuk_bohdan/common/widgets/text_widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/theme/app_theme.dart';

class CachedImageCustom extends StatelessWidget {
  final String imageUrl;
  final Widget? errorWidget;
  final Color? progressIndicatorColor;
  final bool smallSvg;
  final BorderRadius? borderRadius;
  final bool onlyLoading;
  final BoxFit? fit;
  final BoxShape? shape;
  final double? imageHeight;
  final Alignment? alignment;
  final Function()? onTap;

  const CachedImageCustom(
      {Key? key,
      required this.imageUrl,
      this.errorWidget,
      this.progressIndicatorColor,
      this.smallSvg = false,
      this.onlyLoading = false,
      this.fit,
      this.borderRadius,
      this.shape,
      this.imageHeight,
      this.alignment, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return !onlyLoading
        ? imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                height: imageHeight,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: shape == null ? borderRadius ?? BorderRadius.circular(12.sp) : null,
                    shape: shape ?? BoxShape.rectangle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: fit ?? BoxFit.cover,
                      alignment: alignment ?? Alignment.center,
                    ),
                  ),
                  child: InkWell(
                    onTap: onTap,
                    customBorder: const CircleBorder(),
                  ),
                ),
                progressIndicatorBuilder: (context, url, progress) => const CupertinoActivityIndicator(),
                errorWidget: (context, url, progress) => Center(
                  child: errorWidget ??
                      CustomText(
                        text: '',
                        size: 50.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.black,
                      ),
                ),
              )
            : Container()
        : const CupertinoActivityIndicator();
  }
}
