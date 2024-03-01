import 'package:flutter/material.dart';
import 'package:pos_fic/data/datasources/auth_local_datasource.dart';

class SaveServerKeyPage extends StatefulWidget {
  const SaveServerKeyPage({super.key});

  @override
  State<SaveServerKeyPage> createState() => _SaveServerKeyPageState();
}

class _SaveServerKeyPageState extends State<SaveServerKeyPage> {
  TextEditingController? serverKey;
  @override
  void initState() {
    super.initState();
    serverKey = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: serverKey,
              decoration: const InputDecoration(
                labelText: 'Server Key',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                AuthLocalDatasource().saveMidtransServerKey(serverKey!.text);
                Navigator.pop(context);
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
