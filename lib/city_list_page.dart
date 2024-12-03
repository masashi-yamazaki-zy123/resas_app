import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/env.dart';
import 'city_detail_page.dart';
import 'package:http/http.dart' as http;

class CityListPage extends StatefulWidget {
  const CityListPage({
    super.key,
  });

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    _future = http
        .get(
          Uri.https(host, endpoint),
          headers: headers,
        )
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    const cities = [
      '札幌市',
      '横浜市',
      '川崎市',
      '名古屋市',
      '京都市',
      '大阪市',
      '堺市',
      '神戸市',
      '岡山市',
      '広島市',
      '北九州市',
      '福岡市',
      '熊本市',
      '那覇市',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder<String>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final json = jsonDecode(snapshot.data!)['result'] as List;
            final items = json.cast<Map<String, dynamic>>();
            print(snapshot.data);
            return ListView(
              children: [
                for (final city in items)
                  ListTile(
                    title: Text(city['cityName']),
                    subtitle: const Text('政令指定都市'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CityDetailPage(
                            city: city['cityName'],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          }),
    );
  }
}
