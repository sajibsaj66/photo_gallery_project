

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallary_photo/provider/image_provider.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Favorite Item"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: ref.watch(galleryProvider).favoriteList.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                height: 100,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("${ref.watch(galleryProvider).favoriteList[index].thumbnail}")
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
              );
            }),
      ),
    );
  }
}
