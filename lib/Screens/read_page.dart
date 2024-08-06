import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/ReadProvider.dart';

class ReadPage extends StatefulWidget {
  final int bookId;

  const ReadPage({super.key, required this.bookId});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReadProvider>(context, listen: false).getInit(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Page'),
      ),
      body: Consumer<ReadProvider>(
        builder: (context, provider, child) {
          if (provider.imageInit.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return PageView.builder(
            itemCount: provider.imageInit.length,
            itemBuilder: (context, index) {
              final image = provider.imageInit[index];
              return Image.memory(
                image.imageData,
                fit: BoxFit.cover,
              );
            },
          );
        },
      ),
    );
  }
}
