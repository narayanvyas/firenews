import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> newsData = Map();
  bool isLoading = false;
  getNewsData() async {
    setState(() {
      isLoading = true;
    });
    String domain = 'https://newsapi.org/v2/';
    String endPoint = 'everything';
    String query =
        '?q=business&from=2020-06-21&sortBy=publishedAt&apiKey=8ab183ab76e1498bb09e34ab790d1c6f';

    String url = '$domain/$endPoint$query';

    http.Response response = await http.get(url);

    int statusCode = response.statusCode;
    String data;
    if (statusCode == 200) {
      data = response.body;
      Map<String, dynamic> jsonData = json.decode(data);
      setState(() {
        newsData = jsonData;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire News'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: Center(
        child: isLoading == true
            ? CircularProgressIndicator()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: ListView.builder(
                    itemCount: newsData['articles'].length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Card(
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: newsData['articles'][index]
                                            ['urlToImage'] ==
                                        null
                                    ? Container()
                                    : CachedNetworkImage(
                                        imageUrl: newsData['articles'][index]
                                            ['urlToImage'],
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                              ),
                            ),
                            title: newsData['articles'][index]['title'] == null
                                ? Text('')
                                : Text(newsData['articles'][index]['title']),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: newsData['articles'][index]
                                          ['description'] ==
                                      null
                                  ? Text('')
                                  : Text(newsData['articles'][index]
                                                  ['description']
                                              .toString()
                                              .length >
                                          100
                                      ? newsData['articles'][index]
                                              ['description']
                                          .toString()
                                          .substring(0, 100)
                                      : newsData['articles'][index]
                                          ['description']),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
