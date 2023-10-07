import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../model/app_data_model.dart';
import '../screens/chat_screen.dart';
import '../screens/form_screen.dart';
import '../service/api_service.dart';
import '../widgets/app_title.dart';
import '../widgets/card.dart';
import '../widgets/card_skeleton.dart';
import '../widgets/i_button.dart';
import '../widgets/search_bar_home.dart';
import '../widgets/see_all_button.dart';
import '../widgets/server_indicator.dart';
import '../widgets/support_us.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController homeController = TextEditingController();

  Timer? timer;
  bool isServerUp = false;
  List<AppData> appData = [];

  void fetchApps(int? value) async {
    try {
      var data = await ApiService.getCard(
        limit: value,
      );
      setState(() {
        appData = data;
      });
      if (kDebugMode) {
        print(appData);
      }
    } catch (err) {
      if (kDebugMode) {
        print("Home error: $err");
      }
    }
  }

  @override
  void initState() {
    super.initState();


    fetchApps(5);

    ApiService.serverStatus().then((status) {
      setState(() {
        isServerUp = status;
      });
    });

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      ApiService.serverStatus().then((status) {
        if (status != isServerUp) {
          setState(() {
            isServerUp = status;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ibg,
      appBar: AppBar(
        surfaceTintColor: itrans,
        backgroundColor: itrans,
        title: const AppTitle(),
        elevation: 0.0,
        actions: const [
          // ServerIndicator(isServerUp: isServerUp),
          SizedBox(width: 5),
          IButton(),
          SizedBox(width: 10)
        ],
      ),
      body: Stack(
        children: [
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0, top: 100.0),
                child: Text(
                  "What's New to Learn",
                  style: TextStyle(
                      fontSize: fsBanner,
                      color: itextColor.withOpacity(0.9),
                      fontWeight: fwBanner),
                ),
              ),
              searchBar(
                searchController: homeController,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          chatController: homeController.text,
                          isFormRoute: false,
                        ),
                      )).then((value) => homeController.clear());
                },
                chat: false,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "Apps for You",
                              style: TextStyle(
                                fontSize: fsBanner,
                                color: itextColor.withOpacity(0.9),
                                fontWeight: fwBanner,
                              ),
                            ),
                          ),
                          const SeeAll()
                        ],
                      ),
                      appData.isEmpty
                          ? const CardSkeleton(itemCount: 5)
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: cardAspectRatio,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: appData.length,
                              itemBuilder: (context, index) {
                                final data = appData[index];
                                return CardWidget(
                                  data: data,
                                  pageRoute: formScreen(
                                      id: data.id, title: data.title),
                                );
                              },
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SupportUs(),
                      const SizedBox(height: 145,)
                      // const MadeWith(),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
