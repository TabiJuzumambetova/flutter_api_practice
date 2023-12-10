import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/translator.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  String joke = "";
  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Text(
          "Do you wanna hear the joke? ",
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300.w,
                  height: 300.w,
                  child: Text(
                    joke,
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w, 50.h),
                    backgroundColor: Colors.purpleAccent,
                  ),
                  onPressed: () {
                    GetRandomJike();
                  },
                  child: const Text("change")),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w, 50.h),
                    backgroundColor: Colors.purpleAccent,
                  ),
                  onPressed: () {
                    translateJoke();
                  },
                  child: const Text("translate")),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> GetRandomJike() async {
    final Response response =
        await dio.get("https://api.chucknorris.io/jokes/random");
    joke = response.data["value"];
    setState(() {});
  }

  Future<void> translateJoke() async {
    final translator = GoogleTranslator();
     final String input=joke;
     final Translation translation =
        await translator.translate(input, from: "en", to: "ru");

    setState(() {
      joke = translation.text;
    });

  }
}
