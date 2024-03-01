import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_fic/core/components/spaces.dart';
import 'package:pos_fic/presentation/history/bloc/history/history_bloc.dart';
import 'package:pos_fic/presentation/history/widgets/history_transaction_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(const HistoryEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

    // final List<HistoryTransactionModel> historyTransactions = [
    //   HistoryTransactionModel(
    //     name: 'Nutty Oat Latte',
    //     category: 'Drink',
    //     price: 39000,
    //   ),
    //   HistoryTransactionModel(
    //       name: 'Chicken Wings', category: 'Food', price: 20000),
    //   HistoryTransactionModel(
    //       name: 'Fruit Smoothie', category: 'Drink', price: 25000)
    // ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('History Orders',
              style: TextStyle(fontWeight: FontWeight.bold)),
          // backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const Center(
                child: Text("No Data"),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, success: (data) {
              if (data.isEmpty) {
                return const Center(
                  child: Text("No Data"),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                itemCount: data.length,
                separatorBuilder: (context, index) => const SpaceHeight(8.0),
                itemBuilder: (context, index) => HistoryTransactionCard(
                  padding: paddingHorizontal,
                  data: data[index],
                ),
              );
            });
          },
        ));
  }
}
