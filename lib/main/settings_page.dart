import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lets_get_serious/main/profile.dart';
import 'package:share_plus/share_plus.dart';
import '../tools/design.dart';
import 'info.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundGradientColor1,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(color: color4),
                ),
              ],
            ),
            Divider(thickness: 3, color: color4)
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'General Settings',
                        style: TextStyle(
                            fontSize: 32,
                            color: color4,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(
                      Icons.language,
                      color: color4,
                    ),
                    title: const Text(
                      'Profile Settings',
                      style: TextStyle(
                          fontSize: 17,
                          color: color4,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    thickness: 2,
                    color: color4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'About The App',
                        style: TextStyle(
                            fontSize: 32,
                            color: color4,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: color4,
                    ),
                    title: const Text('App Info',
                        style: TextStyle(
                            fontSize: 17,
                            color: color4,
                            fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.share,
                      color: color4,
                    ),
                    title: const Text(
                      'Share',
                      style: TextStyle(
                          fontSize: 17,
                          color: color4,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      final remoteConfig = FirebaseRemoteConfig.instance;
                      await remoteConfig.setConfigSettings(
                        RemoteConfigSettings(
                          fetchTimeout: const Duration(seconds: 10),
                          minimumFetchInterval: Duration.zero,
                        ),
                      );
                      await remoteConfig.fetchAndActivate();
                      final String updateUrl =
                          remoteConfig.getString('share_content') +
                              remoteConfig.getString('download_link');
                      await Share.share(updateUrl);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
