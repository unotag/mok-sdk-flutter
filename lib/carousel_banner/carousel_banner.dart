import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mokone/carousel_banner/carousel_banner_data.dart';
import 'package:mokone/mokone.dart';

class MokCarouselBanner extends StatefulWidget {
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxFit? scaleType;

  MokCarouselBanner({
    super.key,
    this.height = 250.0,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.scaleType = BoxFit.fill,
  });

  @override
  State<MokCarouselBanner> createState() => _MokCarouselBannerState();
}

class _MokCarouselBannerState extends State<MokCarouselBanner> {
  final mokonePlugin = Mokone();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CarouselData?>(
      future: fetchData(), // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<CarouselData?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            debugPrint("::::::ConnectionState.none");
            return Container();
          case ConnectionState.active:
          case ConnectionState.waiting:
            debugPrint("::::::Awaiting result...");
            return Container();
          case ConnectionState.done:
            if (snapshot.hasError) return Container();
            if (snapshot.hasData) {
              return CarouselSlider(
                options: CarouselOptions(height: widget.height, viewportFraction: 1),
                items: snapshot.data?.data?.map((data) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                          onTap: () async {
                            if (data.carouselContent?[0].cta != null) {
                              await mokonePlugin.handleBannerClick(data.carouselContent?[0].cta ?? "");
                            }
                          },
                          child: Container(
                            padding: widget.padding,
                            margin: widget.margin,
                            child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width,
                              cacheManager: null,
                              imageUrl: data.carouselContent?[0].url ?? "",
                              errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                  ),
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.grey.shade500,
                                  )),
                              fit: widget.scaleType,
                            ),
                          ));
                    },
                  );
                }).toList(),
              );
            } else {
              return Container();
            }
        }
      },
    );
  }
}

Future<CarouselData?> fetchData() async {
  try {
    final mokonePlugin = Mokone();
    var result = await mokonePlugin.getCarouselData();
    if (result != null && result != "null") {
      return CarouselData.fromJson(json.decode(result));
    }
    return null;
  } catch (error) {
    debugPrint("fetch carousel data error: $error");
    rethrow;
  }
}
