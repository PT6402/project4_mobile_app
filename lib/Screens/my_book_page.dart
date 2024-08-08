import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/MyBookProvider.dart';
import 'package:testtem/Screens/read_page.dart';

class MyBookPage extends StatefulWidget {
  const MyBookPage({super.key});

  @override
  State<MyBookPage> createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<MyBookProvider>(context, listen: false).getMB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Books'),
      ),
      body: Consumer<MyBookProvider>(
        builder: (context, provider, child) {
          if (provider.MBlist.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.MBlist.length,
            itemBuilder: (context, index) {
              final detail = provider.MBlist[index];
              return ListTile(
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      child: detail.fileimage != null
                          ? Image.memory(detail.fileimage!, fit: BoxFit.cover)
                          : Center(
                              child: Text(
                                'No Image',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            detail.bookName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(height: 5),
                          if (detail.dayTotal == 0)
                            Text(
                              'Permanent',
                              style: TextStyle(color: const Color.fromARGB(255, 218, 105, 143),fontWeight: FontWeight.bold),
                            )
                          else
                            Text(
                              'Remaining days: ${detail.dayTotal}',
                              style: TextStyle(color: const Color.fromARGB(255, 218, 105, 143),fontWeight: FontWeight.bold),
                            ),
                          SizedBox(height: 5),
                          if (detail.dayExpired != null)
                            Text(
                              'Day Expired: ${detail.dayExpired}',overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 100,
                          child: 
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:Colors.green,
                            foregroundColor:Colors.white,
                          ),
                          child: Text(detail.status ? 'Rent':'Buy',style: TextStyle(fontWeight: FontWeight.bold),),
                          
                          onPressed: () {},
                        ),),
                        SizedBox(height: 10),
                        ElevatedButton(
                          child: Text('Read Book'),
                          onPressed: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReadPage(bookId: detail.bookId),),);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
