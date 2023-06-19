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
import '../widgets/made_with.dart';
import '../widgets/search_bar_home.dart';
import '../widgets/see_all_button.dart';
import '../widgets/server_indicator.dart';
import '../widgets/support_us.dart';

class HomeScreen extends StatefulWidget {
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
        actions: [
          ServerIndicator(isServerUp: isServerUp),
          SizedBox(width: 5),
          IButton(),
          SizedBox(width: 10)
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0, top: 100.0),
                child: Text(
                  "What's New to Learn",
                  style: TextStyle(
                      fontSize: fsBanner,
                      color: Colors.white,
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
                            padding: EdgeInsets.all(16),
                            child: const Text(
                              "Apps for You",
                              style: TextStyle(
                                fontSize: fsBanner,
                                color: Colors.white,
                                fontWeight: fwBanner,
                              ),
                            ),
                          ),
                          SeeAll()
                        ],
                      ),
                      appData.isEmpty
                          ? CardSkeleton(itemCount: 5)
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
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
                      const MadeWith(),
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
