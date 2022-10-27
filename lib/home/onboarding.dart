import 'package:flutter/material.dart';
import 'package:my_app/authentication/main_page.dart';
import 'package:my_app/components/login.dart';
// import 'package:my_app/home/MyHomePage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  int _index = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingContent(
                    image: data[index].image,
                    title: data[index].title,
                    content1: data[index].content1,
                    content2: data[index].content2,
                    content3: data[index].content3,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  ...List.generate(
                    data.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: DotIndicator(
                        isActive: index == _index,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 80,
                    child: ElevatedButton(
                        onPressed: () {
                          _index == 1
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const mainpage(),
                                  ),
                                )
                              : _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const CircleBorder(),
                        ),
                        child: Text(
                          _index == 1 ? 'Skip' : 'Next',
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? 15 : 5,
      width: 3,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnBoard {
  final String image, title, content1, content2, content3;

  OnBoard({
    required this.image,
    required this.title,
    required this.content1,
    required this.content2,
    required this.content3,
  });
}

final List<OnBoard> data = [
  OnBoard(
    image: 'assets/images/logo.png',
    title: 'An IOT app for cheking the air',
    content1: 'Develop by group 3 in BKU which is used for checking',
    content2: 'the air in our living environment',
    content3: 'to protect our health',
  ),
  OnBoard(
    image: 'assets/images/logo.png',
    title: 'An IOT app for cheking the air',
    content1: 'Develop by group 3 in BKU which is used for checking',
    content2: 'the air in our living environment',
    content3: 'to protect our health',
  ),
];

class OnboardingContent extends StatelessWidget {
  final String image, title, content1, content2, content3;

  const OnboardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.content1,
      required this.content2,
      required this.content3});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  image,
                  height: 250,
                ),
                const Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  content1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const Text(
                  'the air in our living environment',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  content3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
