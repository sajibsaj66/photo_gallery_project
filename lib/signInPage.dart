import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallary_photo/home_page.dart';
import 'package:gallary_photo/provider/image_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {

  googleSignIn()async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final result = await googleSignIn.signIn();

      Map<String,dynamic> formData = {
        "name":result?.displayName,
        "email":result?.email,
        "id":result?.id.toString(),
        "photoUrl":result?.photoUrl
      };
      if(result != null){
          print("asche ${formData['name']}");
          ref.read(galleryProvider).setPersonInfo(json: formData);
          if(mounted){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
          }
      }
      print(result);
    } catch (error) {
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In Page",style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Column(
               children: [
                 Container(
                   width: width * 0.5,
                   height: width * 0.5,
                   decoration: const BoxDecoration(
                       gradient: LinearGradient(colors: [
                         Colors.cyan,
                         Colors.cyanAccent,
                       ],begin: Alignment.centerLeft,
                           end: Alignment.centerRight
                       )
                   ),
                 ),
                 const Padding(
                   padding:  EdgeInsets.all(30.0),
                   child: Text("Please Sign In",style:  TextStyle(color: Colors.cyan,fontSize: 30)),
                 ),
               ],
             ),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: ElevatedButton(
                   onPressed: ()async{
                     await googleSignIn();
                   },
                   style: ElevatedButton.styleFrom(
                     minimumSize: Size(double.infinity,width * 0.13),
                     backgroundColor: Colors.cyan,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10),
                     )
                   ),
                   child: const Text("Google Login",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
               ),
             )
          ],
        ),
      ),
    );
  }
}
