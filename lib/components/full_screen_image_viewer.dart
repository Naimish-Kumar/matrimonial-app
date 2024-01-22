import 'package:flutter/material.dart';

class FullScreenImageViewer extends StatelessWidget {
  const FullScreenImageViewer(this.url, {Key? key}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Image.asset(
            'assets/icon/icon_pop.png',
            height: 16,
            width: 23,
          ),
        ),
        titleSpacing: 0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: GestureDetector(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'imageHero',
            child: Image.network(url!),
          ),
        ),
      ),
    );
  }
}
