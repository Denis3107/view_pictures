import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PhotoView(),
    );
  }
}

class PhotoView extends StatefulWidget {
  const PhotoView({Key? key}) : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  final urlImages = [
    'https://upload.wikimedia.org/wikipedia/commons/3/39/Domestic_Goose.jpg',
    'https://aldenvet.ua/wp-content/uploads/2021/04/3_4-1024x576.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/275px-American_Beaver.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Ink.image(
            image: NetworkImage(urlImages.first),
            height: 300,
            fit: BoxFit.contain,
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GalleryWidget(urlImages: urlImages, index: 0),
            ),
          ),
        ),
      ),
    );
  }
}

/////
class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<String> urlImages;
  int index;

  GalleryWidget({
    required this.urlImages,
    this.index = 0,
  }) : pageController = PageController(initialPage: index);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            ///scrollDirection: Axis.vertical, прокрутка галереи
            pageController: widget.pageController,
            itemCount: widget.urlImages.length,
            builder: (context, index) {
              final urlImage = widget.urlImages[index];

              return PhotoViewGalleryPageOptions(
                ///  NetworkImage(urlImage) - для силок
                ///  AssetImage(urlImage) - для файлов (путь)
                imageProvider: NetworkImage(urlImage),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
              );
            },
            onPageChanged: (index) =>  setState(() => widget.index = index),
          ),
          ///
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                effect: const SlideEffect(
                  activeDotColor: Colors.orange,
                  spacing: 8.0,
                  radius: 6.0,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                ),
                controller: widget.pageController,
                count: widget.urlImages.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
