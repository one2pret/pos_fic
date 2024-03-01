import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_fic/core/assets/assets.gen.dart';
import 'package:pos_fic/core/components/menu_button.dart';
import 'package:pos_fic/core/components/spaces.dart';
import 'package:pos_fic/core/extensions/build_context_ext.dart';
import 'package:pos_fic/data/datasources/auth_local_datasource.dart';
import 'package:pos_fic/data/datasources/product_local_datasource.dart';
import 'package:pos_fic/presentation/auth/pages/login_page.dart';
import 'package:pos_fic/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:pos_fic/presentation/home/bloc/product/product_bloc.dart';
import 'package:pos_fic/presentation/setting/pages/manage_printer_page.dart';
import 'package:pos_fic/presentation/setting/pages/manage_product_page.dart';
import 'package:pos_fic/presentation/setting/pages/save_server_key_page.dart';
import 'package:pos_fic/presentation/setting/pages/sync_data_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                MenuButton(
                    iconPath: Assets.images.manageProduct.path,
                    label: 'Kelola Produk',
                    isImage: true,
                    onPressed: () => context.push(const ManageProductPage())),
                const SpaceWidth(15),
                MenuButton(
                    iconPath: Assets.images.managePrinter.path,
                    label: 'Kelola Printer',
                    isImage: true,
                    onPressed: () {
                      context.push(const ManagePrinterPage());
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                MenuButton(
                    iconPath: Assets.images.manageProduct.path,
                    label: 'Qris Server Key',
                    isImage: true,
                    onPressed: () => context.push(const SaveServerKeyPage())),
                const SpaceWidth(15),
                MenuButton(
                    iconPath: Assets.images.managePrinter.path,
                    label: 'Sinkronisasi Data',
                    isImage: true,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SyncDataPage()));
                    }),
              ],
            ),
          ),
          const SpaceHeight(60),
          const Divider(),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  success: (_) {
                    AuthLocalDatasource().removeAuthData();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  });
            },
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: const Text("Logout"));
            },
          ),
        ],
      ),
    );
  }
}
