import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgpt/data/constants.dart';
import 'package:sgpt/widgets/app_title.dart';
import 'package:sgpt/widgets/search_bar_app.dart';

import '../model/app_data_model.dart';
import '../service/api_service.dart';
import '../widgets/card.dart';
import '../widgets/card_skeleton.dart';
import '../widgets/server_indicator.dart';
import 'form_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final TextEditingController appScreenController = TextEditingController();

  // List<dynamic> AppList = [];
  // List<AppData> allApps = [];
  Timer? timer;
  bool isServerUp = false;
  List<AppData> allCards = [];

  Future fetchCards(int? value, String? query) async {
    try {
      List<AppData> data = await ApiService.getCard(limit: value, query: query);
      setState(() {
        allCards = data;
        if (kDebugMode) {
          print('Error : $allCards');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    fetchCards(6, appScreenController.text.trim());

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
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ibg,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: itrans,
          title: const AppTitle(),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [
            ServerIndicator(isServerUp: isServerUp),
            const SizedBox(width: 15)
          ]),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: [
                appSearchBar(
                  onTap: () {
                    fetchCards(null, appScreenController.text.trim());
                  },
                  searchController: appScreenController,
                ),
                const SizedBox(height: 20),
                Container(
                  child: Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          allCards.isEmpty
                              ? const CardSkeleton(itemCount: 6)
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.85,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  itemCount: allCards.length,
                                  itemBuilder: (context, index) {
                                    final data = allCards[index];
                                    return CardWidget(
                                      data: data,
                                      pageRoute: formScreen(
                                        id: data.id,
                                        title: data.title,
                                      ),
                                    );
                                  },
                                ),
                          const SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
