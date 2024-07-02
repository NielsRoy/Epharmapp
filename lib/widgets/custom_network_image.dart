// import 'dart:io';
// import 'package:flutter/widgets.dart';

// class CustomNetworkImage extends ImageProvider<CustomNetworkImage> {
//   final String url;
//   final HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

//   CustomNetworkImage(this.url);

//   @override
//   ImageStreamCompleter load(CustomNetworkImage key, DecoderCallback decode) {
//     return MultiFrameImageStreamCompleter(
//       codec: _loadAsync(),
//       scale: key.scale,
//       informationCollector: () sync* {
//         yield ErrorDescription('Image URL: $url');
//       },
//     );
//   }

//   Future<Codec> _loadAsync() async {
//     final Uri resolved = Uri.base.resolve(url);
//     final HttpClientRequest request = await httpClient.getUrl(resolved);
//     final HttpClientResponse response = await request.close();
//     if (response.statusCode != HttpStatus.ok) {
//       throw Exception('Failed to load image: ${response.statusCode} ${response.reasonPhrase}');
//     }
//     final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
//     return await instantiateImageCodec(bytes);
//   }

//   @override
//   Future<CustomNetworkImage> obtainKey(ImageConfiguration configuration) {
//     return SynchronousFuture<CustomNetworkImage>(this);
//   }

//   @override
//   bool operator ==(dynamic other) {
//     if (other.runtimeType != runtimeType) return false;
//     final CustomNetworkImage typedOther = other;
//     return url == typedOther.url;
//   }

//   @override
//   int get hashCode => url.hashCode;

//   @override
//   String toString() => '$runtimeType("$url")';
// }
