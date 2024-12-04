import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/city.dart';

import 'env.dart';
import 'package:http/http.dart' as http;

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});

  final City city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/municipality/taxes/perYear';
    final headers = {'X-API-KEY': Env.resasApiKey,};
    final param = {
      'prefCode': widget.city.prefCode.toString(),
      'cityCode': widget.city.cityCode,
    };
    _future = http
        .get(
          Uri.https(host, endpoint, param),
          headers: headers,
        )
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.city.cityName),
      ),
      body:  FutureBuilder<String>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final result = jsonDecode(snapshot.data!)['result'] as Map<String, dynamic>;
          final data = result['data'] as List;
          final items = data.cast<Map<String, dynamic>>();
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index){
              final item = items[index];
              return ListTile(
                title: Text(item['year'].toString()),
                trailing: Text(item['value'].toString()),
              );
            },
          );       
        },
      ),
    );
  }
}
