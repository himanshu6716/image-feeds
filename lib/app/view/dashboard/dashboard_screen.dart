import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_feed/app/utils/utils.dart';
import 'package:image_feed/app/view/dashboard/widget/delete_dialog.dart';
import 'package:image_feed/app/view/dashboard/widget/full_image_screen.dart';
import 'package:image_feed/app/utils/colours.dart';
import 'package:image_feed/app/view/dashboard/bloc/dashboard_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadImagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: pageBackgroundColor,
        title: Text(
          "Dashboard Screen",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 32, color: iconBlackColor),
            onPressed: () {
              context.read<DashboardBloc>().add(PickImagesEvent());
            },
          ),
        ],
      ),

      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DashboardLoaded) {
            final imagesData = state.images;
            return Column(
              children: [
                Expanded(
                  child: imagesData.isEmpty
                      ? Center(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              width: size.width * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadius / 2,
                                ),
                                color: Colors.grey.shade800,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadius / 2,
                                ),
                                child: Image.asset(
                                  "assets/images/default-placeholder.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: size.height * 0.7,
                            child: PageView.builder(
                              controller: PageController(
                                viewportFraction: 0.95,
                              ),
                              itemCount: imagesData.length,
                              itemBuilder: (context, index) {
                                final item = imagesData[index];
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: defaultBorderRadius / 2,
                                    vertical: defaultVerticalMargin,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      smallBorderRadius,
                                    ),
                                    color: pageBackgroundColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: smallBorderRadius / 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // 🔹 HEADER
                                      Padding(
                                        padding: const EdgeInsets.all(
                                          defaultBorderRadius / 2,
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: backgroundColor,
                                              radius: 24,
                                              child: const Icon(
                                                Icons.person,
                                                size: largeIconSize,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "username",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                  Text(
                                                    "location",
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.bodySmall,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.more_vert),
                                              onPressed: () {
                                                DeleteDialog.show(
                                                  context,
                                                  index,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => FullScreenImage(
                                                  imageBase64: item["image"]!,
                                                  tag: "image_$index",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: "image_$index",
                                            child: Container(
                                                width: size.width,
                                                color: backgroundColor,
                                                child: Image.memory(
                                                  base64Decode(item["image"]!),
                                                  fit: BoxFit.contain,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: smallBorderRadius,
                                          vertical: defaultBorderRadius / 4,
                                        ),
                                        child: Text(
                                          Utils().formatTime(item["time"]!),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
