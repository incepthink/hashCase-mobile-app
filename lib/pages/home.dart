import 'package:flutter/material.dart';
import 'package:hash_case/services/api.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
          future: api.fetchLocalNfts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return Container();
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
