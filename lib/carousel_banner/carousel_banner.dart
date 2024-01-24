import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mokone/carousel_banner/carousel_banner_data.dart';
import 'package:mokone/mokone.dart';

class MokCarouselBanner extends StatefulWidget {
  const MokCarouselBanner({super.key});

  @override
  State<MokCarouselBanner> createState() => _MokCarouselBannerState();
}

class _MokCarouselBannerState extends State<MokCarouselBanner> {
  var _bannerData;
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
                options: CarouselOptions(height: 250.0, viewportFraction: 1),
                items: snapshot.data?.data?.map((data) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                          onTap: () async {
                            await mokonePlugin.handleBannerClick({});
                          },
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            cacheManager: null,
                            imageUrl: data.carouselContent?[0].url ?? "",
                            errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                ),
                                child: Icon(Icons.error,color: Colors.grey.shade500,)),
                            fit: BoxFit.cover,
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
    rethrow;
  }
}
