import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_fic/core/components/spaces.dart';
import 'package:pos_fic/data/datasources/product_local_datasource.dart';
import 'package:pos_fic/presentation/home/bloc/product/product_bloc.dart';
import 'package:pos_fic/presentation/setting/bloc/sync_order/sync_order_bloc.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({super.key});

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync Data'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  success: (_) async {
                    await ProductLocalDatasource.instance.removeAllProduct();
                    await ProductLocalDatasource.instance
                        .insertAllProduct(_.products.toList());
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Sync Data Success"),
                    ));
                  });
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return ElevatedButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(const ProductEvent.fetch());
                  },
                  child: const Text("Sync Data Product"),
                );
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              });
            },
          ),
          const SpaceHeight(20),
          BlocConsumer<SyncOrderBloc, SyncOrderState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  success: (_) async {
                    // await ProductLocalDatasource.instance.removeAllProduct();
                    // await ProductLocalDatasource.instance
                    //     .insertAllProduct(_.products.toList());
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Sync Data Success"),
                    ));
                  });
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return ElevatedButton(
                  onPressed: () {
                    context
                        .read<SyncOrderBloc>()
                        .add(const SyncOrderEvent.sendOrder());
                  },
                  child: const Text("Sync Data Order"),
                );
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              });
            },
          ),
        ],
      ),
    );
  }
}
