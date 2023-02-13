import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallary_photo/provider/image_provider.dart';

import 'image_zoom.dart';

class GalleryPage extends ConsumerStatefulWidget {
  const GalleryPage({
    super.key,
  });

  @override
  ConsumerState<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends ConsumerState<GalleryPage>
    with SingleTickerProviderStateMixin {
  bool change = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text("Gallery Photos"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width * 0.1,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "${ref.watch(galleryProvider).person?.photoUrl}"))),
            ),
          )
        ],
      ),
      body: ref.watch(galleryProvider).imageModel == null
          ? const SizedBox()
          : Center(
              child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 2 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: ref
                              .watch(galleryProvider)
                              .imageModel!
                              .products!
                              .length * 100,
                          itemBuilder: (BuildContext ctx, index) {
                            int index1 = index %
                                ref
                                    .watch(galleryProvider)
                                    .imageModel!
                                    .products!
                                    .length;
                            return TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ZoomingPage(
                                              imageUrl:
                                                  "${ref.watch(galleryProvider).imageModel?.products?[index1].thumbnail}",
                                              id: ref
                                                  .watch(galleryProvider)
                                                  .imageModel!
                                                  .products![index1]
                                                  .id!,
                                            )));
                              },
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${ref.watch(galleryProvider).imageModel?.products?[index1].thumbnail}",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  clipBehavior: Clip.hardEdge,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: ref
                                                  .watch(galleryProvider)
                                                  .imageModel
                                                  ?.products?[index1]
                                                  .thumbnail ==
                                              null
                                          ? null
                                          : DecorationImage(
                                              fit: BoxFit.fill,
                                              image: imageProvider),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                        onPressed: () {
                                          ref.read(galleryProvider).setFavorite(
                                              id: ref
                                                  .watch(galleryProvider)
                                                  .imageModel!
                                                  .products![index1]
                                                  .id!);
                                          if (mounted) {
                                            if (ref
                                                .watch(galleryProvider)
                                                .favoriteId
                                                .contains(ref
                                                    .watch(galleryProvider)
                                                    .imageModel!
                                                    .products![index1]
                                                    .id!)) {
                                              change = true;
                                            } else {
                                              change = false;
                                            }
                                          }
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                        icon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: ref
                                                    .watch(galleryProvider)
                                                    .favoriteId
                                                    .contains(ref
                                                        .watch(galleryProvider)
                                                        .imageModel!
                                                        .products![index1]
                                                        .id!)
                                                ? Colors.red
                                                : Colors.green,
                                            size: 30,
                                          ),
                                        ),
                                      )),
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: Colors.cyan,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.image),
                              ),
                            );
                          })),
                ],
              ),
            )),
    );
  }
}
