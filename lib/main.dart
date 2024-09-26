import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'FirstScreen.dart';
import 'data/model/free_fack_model.dart';
import 'data/repo/free_fack_post_repo.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              textStyle: const TextStyle(color: Colors.white)),
        ),
        // textButtonTheme: TextButtonThemeData(
        //   style: ButtonStyle(
        //     textStyle: WidgetStateProperty.all(
        //       TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
        // buttonTheme: ButtonThemeData(
        //   buttonColor: Colors.blueAccent,
        //   textTheme: ButtonTextTheme.normal,
        // ),
      ),
      home: const Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  var posts = <FreeFakePostModel>[];
  late final FreeFakePostRepoDio freeFakePostRepo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    freeFakePostRepo = FreeFakePostRepoDio(client: Dio());
    futureInit();
  }

  void futureInit() async {
    posts = await freeFakePostRepo.fetchPosts();
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Padding(
              //   padding: EdgeInsetsDirectional.only(start: 16),
              //   child: Text(
              //     "List view Example",
              //     textAlign: TextAlign.start,
              //   ),
              // ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(color: Colors.black54, width: 1),
                    ),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(
                        title: Text(post?.title ?? "default"),
                        subtitle: Column(
                          children: [
                            Text(post?.content ?? "default"),
                            post!.picture != null
                                ? Image.network(post!.picture!)
                                : const Placeholder()
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black,
                        thickness: 5,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
