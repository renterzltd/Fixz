import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ZoomableImagePage extends StatefulWidget {
  List<String> images = [];
  ZoomableImagePage({this.images = const []});
  @override
  _ZoomableImagePageState createState() => _ZoomableImagePageState();
}

class _ZoomableImagePageState extends State<ZoomableImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: Colors.white,
              child: PhotoViewGallery.builder(
                backgroundDecoration: BoxDecoration(color: Colors.white),
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(this.widget.images[index]),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                  );
                },
                itemCount: this.widget.images.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 40,
              left: 5,
              child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),),
        ],
      ),
    );
  }
}
