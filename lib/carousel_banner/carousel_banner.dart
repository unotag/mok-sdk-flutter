import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mokone/carousel_banner/carousel_banner_data.dart';
import 'package:mokone/mokone.dart';
import 'package:shimmer/shimmer.dart';

class MokCarouselBanner extends StatefulWidget {
  const MokCarouselBanner({super.key});

  @override
  State<MokCarouselBanner> createState() => _MokCarouselBannerState();
}

class _MokCarouselBannerState extends State<MokCarouselBanner> {
  var _bannerData;

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
                    return Image.network(
                      data.carouselContent?[0].url ??
                          "https://images.unsplash.com/photo-1700427296131-0cc4c4610fc6?q=80&w=1476&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                );
              }).toList(),
            );
            }else{
              return Container();
            }
        }
      },
    );
  }
}

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
//           stream: FirebaseFirestore.instance.collection('config').doc('home_bottom_banner').snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData || snapshot.data == null) {
//               return const BannerShimmer(height: 240);
//             }
//             _bannerData = snapshot.data?.data();
//             if (_bannerData != null) {
//               _viewModel.getHomeBannerData(_bannerData);
//             }
//             if (_viewModel.homeBannerData?.isEmpty ?? true) {
//               return Container(
//                 height: 0,
//               );
//             }
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0.0),
//               child: AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: Swiper(
//                   autoplay: true,
//                   duration: 1000,
//                   loop: true,
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                         onTap: () async {
//                           if ((_viewModel.homeBannerData?[index]['cta'] ?? "") != "") {
//                             locator<AnalyticsService>()
//                                 .logHomeCarouselClicked(title: _viewModel.homeBannerData?[index]["title"] ?? "NA");
//                             await _viewModel.onLinkTap(index);
//                           }
//                         },
//                         child: CachedNetworkImage(
//                           cacheManager: null,
//                           imageUrl: _viewModel.homeBannerData?[index]["image_url"] ?? "",
//                           placeholder: (context, url) => const BannerShimmer(height: 240),
//                           errorWidget: (context, url, error) => Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.grey.shade400,
//                               ),
//                               child: Icon(Icons.error)),
//                           imageBuilder: (context, imageProvider) => ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image(image: imageProvider, fit: BoxFit.cover),
//                           ),
//                           fit: BoxFit.cover,
//                         ));
//                   },
//                   itemCount: _viewModel.homeBannerData?.length ?? 0,
//                   viewportFraction: 1,
//                   scale: 0.9,
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }


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
