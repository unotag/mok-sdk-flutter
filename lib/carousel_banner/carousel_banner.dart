import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mokone/carousel_banner/carousel_banner_data.dart';
import 'package:mokone/mokone.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return Text('Result: ${snapshot.data?.data?[0].carouselContent?[0].url}');
        }
      },
    );
  }
}

//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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

class BannerShimmer extends StatelessWidget {
  final double height;

  const BannerShimmer({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height - 28,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            height: height - 28,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

Future<CarouselData?> fetchData() async {
  final mokonePlugin = Mokone();
  var result = await mokonePlugin.getCarouselData();
  if (result != null && result != "null") {
    return CarouselData.fromJson(json.decode(result));
  }
  return null;
}

