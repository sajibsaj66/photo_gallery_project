import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallary_photo/provider/image_provider.dart';

class ZoomingPage extends ConsumerStatefulWidget {
  final String imageUrl;
  final int id;
  const ZoomingPage({Key? key,required this.imageUrl,required this.id}) : super(key: key);

  @override
  ConsumerState<ZoomingPage> createState() => _ZoomingPageState();
}

class _ZoomingPageState extends ConsumerState<ZoomingPage> with SingleTickerProviderStateMixin{
  PageController pageController = PageController();
  int index = 0;
  bool change = false;
  bool full = false;
  late TransformationController controller;
  TapDownDetails? tapDetails;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  double minScale = 1;
  double maxScale = 4;
  @override
  void initState() {
    controller = TransformationController();
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 300))..addListener(() {
      setState(() {
        controller.value = animation!.value;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: buildImage(imageLink: widget.imageUrl, context: context, id: widget.id))
            ],
          ),
        ),
      ) ,
    );
  }
  Widget buildImage({required String imageLink,required BuildContext context,required int id}){
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onDoubleTapDown: (details) => tapDetails = details,
      onDoubleTap: (){
        final position  = tapDetails!.localPosition;
        double scale = 5;
        final x = -position.dx * (scale - 1);
        final y = -position.dy * (scale - 1);
        final zoomed = Matrix4.identity()
          ..translate(x,y)
          ..scale(scale);
        final end  = controller.value.isIdentity()?zoomed:Matrix4.identity();
        animation = Matrix4Tween(
            begin: controller.value,
            end: end
        ).animate(CurveTween(curve: Curves.easeIn).animate(animationController));
        animationController.forward(from: 0);
        if(mounted) {
          setState(() {
            full = !full;
          });
        }
      },
      child: Stack(
        children: [
          InteractiveViewer(
              clipBehavior: Clip.none,
              transformationController: controller,
              maxScale: maxScale,
              minScale: minScale,
              child: Container(
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(imageLink),
                    ),
                    color: Colors.transparent
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    },icon:Container(
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.only(bottom: 10.0,top: 5),
                        child: Center(child: Icon(Icons.arrow_back,color: Colors.white)),
                      ),
                    ),)),
                Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(onPressed: (){
                      ref.read(galleryProvider).setFavorite(id: id);
                      if(mounted){
                        if(ref.watch(galleryProvider).favoriteId.contains(id)){
                          change = true;
                        }else{
                          change = false;
                        }
                      }
                      if(mounted){
                        setState(() { });
                      }
                    },icon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Icon(Icons.favorite_border,color: ref.watch(galleryProvider).favoriteId.contains(id)?Colors.red:Colors.green,size: 30,),
                    ),)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
