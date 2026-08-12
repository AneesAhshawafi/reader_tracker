// import 'package:flutter/material.dart';
// import 'dart:html' as html;
// import 'dart:ui_web' as ui_web;

// class WebCORSImage extends StatelessWidget {
//   final String imageUrl;
//   final double? width;
//   final double? height;
//   final BoxFit fit;

//   const WebCORSImage({
//     super.key,
//     required this.imageUrl,
//     this.width,
//     this.height,
//     this.fit = BoxFit.cover,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final String viewType = 'web-img-${imageUrl.hashCode}';

//     ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
//       final element = html.ImageElement()
//         ..src = imageUrl
//         ..style.width = '100%'
//         ..style.height = '100%'
//         ..style.objectFit = _getBoxFitCss(fit);
//       return element;
//     });

//     return SizedBox(
//       width: width ?? double.infinity,
//       height: height, // Remove default double.infinity if unused
//       child: HtmlElementView(viewType: viewType),
//     );
//   }

//   String _getBoxFitCss(BoxFit fit) {
//     switch (fit) {
//       case BoxFit.cover:
//         return 'cover';
//       case BoxFit.contain:
//         return 'contain';
//       case BoxFit.fill:
//         return 'fill';
//       default:
//         return 'cover';
//     }
//   }
// }
