//
//  Main.dart
//  n_slide_popup
//
//  Created by shang on 2025/12/27.
//  Copyright © 2025/12/27 shang. All rights reserved.
//

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:n_slide_popup/n_slide_popup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Alignment> alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  var alignment = Alignment.center;

  late final themeData = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "PopupRoute direction from Alignment.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            buildWrap(
              onChanged: (v) {
                alignment = v;
                debugPrint("$alignment ${alignment.x} ${alignment.y}");
                onPopupRoute();
              },
            ),
            Divider(),
            const Text(
              "OverlayEntry direction from Alignment.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            buildWrap(
              onChanged: (v) {
                alignment = v;
                debugPrint("$alignment ${alignment.x} ${alignment.y}");
                NOverlayDialog.show(
                  context,
                  from: v,
                  barrierColor: Colors.black12,
                  // barrierDismissible: false,
                  onBarrier: () {
                    debugPrint('NOverlayDialog onBarrier');
                  },
                  child: Container(
                    width: 300,
                    height: 300,
                    child: buildContent(
                      title: v.toString(),
                      onTap: () {
                        NOverlayDialog.dismiss();
                        debugPrint('NOverlayDialog onBarrier');
                      },
                    ),
                  ),
                );
              },
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        NOverlayDialog.sheet(
                          context,
                          child: buildContent(
                            height: 400,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            onTap: () {
                              NOverlayDialog.dismiss();
                            },
                          ),
                        );
                      },
                      child: Text("NOverlayDialog.sheet"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NOverlayDialog.toast(
                          context,
                          hideBarrier: true,
                          from: Alignment.center,
                          message: "This is a Toast!",
                        );
                      },
                      child: Text("NOverlayDialog.toast"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NOverlayDialog.drawer(
                          context,
                          child: buildContent(
                            title: "NOverlayManager.drawer",
                            radius: 0,
                            onTap: () {
                              NOverlayDialog.dismiss();
                            },
                          ),
                        );
                      },
                      child: Text("NOverlayManager.drawer"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWrap({required ValueChanged<Alignment> onChanged}) {
    final list = alignments;
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = 8.0;
        final rowCount = 3.0;
        final itemWidth = (constraints.maxWidth - spacing * (rowCount - 1)) / rowCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          // crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...list.map(
              (e) {
                final i = list.indexOf(e);
                final btnTitle = [e.toString().split(".").last, "(${e.x}, ${e.y})"].join("\n");
                return GestureDetector(
                  onTap: () => onChanged(e),
                  child: Container(
                    width: itemWidth.truncateToDouble(),
                    height: itemWidth * 0.618,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(btnTitle),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> onPopupRoute() async {
    final route = NSlidePopupRoute(
      from: alignment,
      builder: (_) {
        return buildPopupView(alignment: alignment, argsDismiss: {"b": "88"});
      },
    );
    final result = await Navigator.of(context).push(route);
    print(["result", result.runtimeType, result]);
  }

  Widget buildPopupView({required Alignment alignment, Map<String, dynamic>? argsDismiss}) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 300,
        height: 400,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.green,
          // border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(argsDismiss);
          },
          child: Text("dismiss"),
        ),
      ),
    );
  }

  Widget buildContent({
    double? width,
    double? height,
    EdgeInsetsGeometry? margin,
    double? radius,
    String? title,
    VoidCallback? onTap,
  }) {
    final btnTitle = title ?? "buildContent";
    return Container(
      width: width,
      height: height,
      margin: margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 16)),
      ),
      child: ElevatedButton(
        onPressed: () {
          debugPrint(btnTitle);
          onTap?.call();
        },
        child: Text(btnTitle),
      ),
    );
  }
}
