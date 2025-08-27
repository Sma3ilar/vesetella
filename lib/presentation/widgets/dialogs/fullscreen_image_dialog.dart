// // This is a reusable dialog for displaying images in full screen with zoom capabilities
// import 'package:flutter/material.dart';
// import 'package:pg_web/core/extensions/translation_extension.dart';
// import '../../../core/constants/tr_keys.dart';

// class FullScreenImageDialog {
//   /// Shows a full screen image dialog with zoom support
//   ///
//   /// [context] - The current BuildContext
//   /// [imageUrl] - URL of the image to display
//   /// [title] - Optional title to display in the app bar (default: null)
//   static Future<void> show({
//     required BuildContext context,
//     String? imageUrl,
//     String? title,
//     List<ProjectModel>? projects,
//     int initialIndex = 0,
//   }) async {
//     // Handle backward compatibility
//     if (imageUrl != null && projects == null) {
//       // Create a single project model for backward compatibility
//       projects = [ProjectModel(id: 0, imageUrl: imageUrl, title: title ?? '')];
//       initialIndex = 0;
//     }

//     // Validate projects list
//     if (projects == null || projects.isEmpty) return;

//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return _FullScreenImageDialogContent(
//           projects: projects!,
//           initialIndex: initialIndex,
//         );
//       },
//     );
//   }
// }

// class _FullScreenImageDialogContent extends StatefulWidget {
//   final List<ProjectModel> projects;
//   final int initialIndex;

//   const _FullScreenImageDialogContent({
//     required this.projects,
//     required this.initialIndex,
//   });

//   @override
//   State<_FullScreenImageDialogContent> createState() =>
//       _FullScreenImageDialogContentState();
// }

// class _FullScreenImageDialogContentState
//     extends State<_FullScreenImageDialogContent> {
//   late PageController _pageController;
//   late int _currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//     _pageController = PageController(initialPage: _currentIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _goToPrevious() {
//     if (_currentIndex > 0) {
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   void _goToNext() {
//     if (_currentIndex < widget.projects.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: EdgeInsets.zero,
//       backgroundColor: Colors.transparent,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Black background
//           Container(
//             color: Colors.black.withAlpha(
//               230,
//             ), // Using withAlpha instead of withOpacity
//           ),

//           // PageView for swiping between images
//           PageView.builder(
//             controller: _pageController,
//             itemCount: widget.projects.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               final project = widget.projects[index];
//               return InteractiveViewer(
//                 minScale: 0.5,
//                 maxScale: 4.0,
//                 child: Center(
//                   child: Image.network(
//                     project.imageUrl,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Center(
//                         child: CircularProgressIndicator(
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded /
//                                     loadingProgress.expectedTotalBytes!
//                               : null,
//                           color: Colors.white,
//                         ),
//                       );
//                     },
//                     errorBuilder: (context, error, stackTrace) {
//                       return Center(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.error_outline,
//                               color: Colors.white,
//                               size: 40,
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               TrKeys.failedToLoadImage.trn,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),

//           // Only show navigation arrows if there's more than one project
//           if (widget.projects.length > 1) ...[
//             // Previous navigation arrow (start side in both LTR and RTL)
//             Positioned.directional(
//               textDirection: Directionality.of(context),
//               start: 16,
//               top: 0,
//               bottom: 0,
//               child: Center(
//                 child: _currentIndex > 0
//                     ? IconButton(
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                           size: 32,
//                         ),
//                         onPressed: _goToPrevious,
//                       )
//                     : SizedBox.shrink(),
//               ),
//             ),

//             // Next navigation arrow (end side in both LTR and RTL)
//             Positioned.directional(
//               textDirection: Directionality.of(context),
//               end: 16,
//               top: 0,
//               bottom: 0,
//               child: Center(
//                 child: _currentIndex < widget.projects.length - 1
//                     ? IconButton(
//                         icon: Icon(
//                           Icons.arrow_forward_ios,
//                           color: Colors.white,
//                           size: 32,
//                         ),
//                         onPressed: _goToNext,
//                       )
//                     : SizedBox.shrink(),
//               ),
//             ),
//           ],

//           // App bar with title and close button
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               color: Colors.black.withAlpha(
//                 128,
//               ), // Using withAlpha instead of withOpacity
//               child: SafeArea(
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                     if (widget.projects[_currentIndex].title.isNotEmpty)
//                       Expanded(
//                         child: Text(
//                           widget.projects[_currentIndex].title,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Bottom tooltip with page indicator for multiple images
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               color: Colors.black.withAlpha(
//                 128,
//               ), // Using withAlpha instead of withOpacity
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: SafeArea(
//                 top: false,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.zoom_in, color: Colors.white, size: 16),
//                     SizedBox(width: 8),
//                     Text(
//                       'Pinch to zoom',
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                     // Only show page indicator if there's more than one project
//                     if (widget.projects.length > 1) ...[
//                       SizedBox(width: 16),
//                       Text(
//                         '${_currentIndex + 1}/${widget.projects.length}',
//                         style: TextStyle(color: Colors.white, fontSize: 14),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
