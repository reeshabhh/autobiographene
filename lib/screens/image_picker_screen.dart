// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ImagePickerScreen extends StatefulWidget {
//   static const String id = 'image_picker_screen';

//   @override
//   _ImagePickerScreenState createState() => _ImagePickerScreenState();
// }

// class _ImagePickerScreenState extends State<ImagePickerScreen> {
  
//   File _image;

// Future getImageFromCamera() async {
//   final image = await ImagePicker().pickImage(
//     source: ImageSource.camera,
//   );
//   // imageQuality: 100 / 50

//   setState(() {
//     _image = File(image.path);
//   });
// }

// Future getImageFromGallery() async {
//   final image = await ImagePicker().pickImage(
//     source: ImageSource.gallery,
//   );

//   // imageQuality: 100 / 50

//   setState(() {
//     _image = File(image.path);
//   });
// }
 
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }





// void _showImageSourceActionSheet(BuildContext context) {
//   // Function(ImageSource) selectImageSource = (imageSource) {
//   //   context
//   //       .read<ProfileBloc>()
//   //       .add(OpenImagePicker(imageSource: imageSource));
//   // };

//   // if (Platform.isIOS) {
//   //   showCupertinoModalPopup(
//   //     context: context,
//   //     builder: (context) => CupertinoActionSheet(
//   //       actions: [
//   //         CupertinoActionSheetAction(
//   //           child: Text('Camera'),
//   //           onPressed: () {
//   //             Navigator.pop(context);
//   //             selectImageSource(ImageSource.camera);
//   //           },
//   //         ),
//   //         CupertinoActionSheetAction(
//   //           child: Text('Gallery'),
//   //           onPressed: () {
//   //             Navigator.pop(context);
//   //             selectImageSource(ImageSource.gallery);
//   //           },
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // } else {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) => Wrap(children: [
//       ListTile(
//         leading: Icon(Icons.camera_alt),
//         title: Text('Camera'),
//         onTap: () {
//           Navigator.pop(context);
//           // selectImageSource(ImageSource.camera);
//         },
//       ),
//       ListTile(
//         leading: Icon(Icons.photo_album),
//         title: Text('Gallery'),
//         onTap: () {
//           Navigator.pop(context);
//           // selectImageSource(ImageSource.gallery);
//         },
//       ),
//     ]),
//   );
// }
// // }
