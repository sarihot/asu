import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextStyle headingStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red);

  bool lockAppSwitchVal = true;
  bool fingerprintSwitchVal = false;
  bool changePassSwitchVal = true;

  TextStyle headingStyleIOS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: CupertinoColors.inactiveGray,
  );
  TextStyle descStyleIOS = const TextStyle(color: CupertinoColors.inactiveGray);

  @override
  Widget build(BuildContext context) {
    return (Platform.isAndroid)
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.redAccent,
                secondary: Colors.redAccent,
              ),
            ),
            home: Scaffold(
              appBar: AppBar(
                title: const Text("Settings UI"),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Common",
                            style: headingStyle,
                          ),
                        ],
                      ),
                      const ListTile(
                        leading: Icon(Icons.language),
                        title: Text("Language"),
                        subtitle: Text("English"),
                      ),
                      const Divider(),
                      const ListTile(
                        leading: Icon(Icons.cloud),
                        title: Text("Environment"),
                        subtitle: Text("Production"),
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Security", style: headingStyle),
                        ],
                      ),
                      ListTile(
                        leading: const Icon(Icons.phonelink_lock_outlined),
                        title: const Text("Lock app in background"),
                        trailing: Switch(
                            value: lockAppSwitchVal,
                            activeColor: Colors.redAccent,
                            onChanged: (val) {
                              setState(() {
                                lockAppSwitchVal = val;
                              });
                            }),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.fingerprint),
                        title: const Text("Use fingerprint"),
                        trailing: Switch(
                            value: fingerprintSwitchVal,
                            activeColor: Colors.redAccent,
                            onChanged: (val) {
                              setState(() {
                                fingerprintSwitchVal = val;
                              });
                            }),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.lock),
                        title: const Text("Change Password"),
                        trailing: Switch(
                            value: changePassSwitchVal,
                            activeColor: Colors.redAccent,
                            onChanged: (val) {
                              setState(() {
                                changePassSwitchVal = val;
                              });
                            }),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                backgroundColor: CupertinoColors.destructiveRed,
                middle: Text("Settings UI"),
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: CupertinoColors.extraLightBackgroundGray,
                child: Column(
                  children: [
                    //Common
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 12),
                        Text(
                          "Common",
                          style: headingStyleIOS,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      color: CupertinoColors.white,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 38,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.language,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                const Text("Language"),
                                const Spacer(),
                                Text(
                                  "English",
                                  style: descStyleIOS,
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  CupertinoIcons.right_chevron,
                                  color: CupertinoColors.inactiveGray,
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                          const Divider(),
                          Container(
                            width: double.infinity,
                            height: 38,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.cloud,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                const Text("Environment"),
                                const Spacer(),
                                Text(
                                  "Production",
                                  style: descStyleIOS,
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  CupertinoIcons.right_chevron,
                                  color: CupertinoColors.inactiveGray,
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                    //Security
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 12),
                        Text(
                          "Security",
                          style: headingStyleIOS,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      color: CupertinoColors.white,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 38,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.phonelink_lock_outlined,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                const Text("Lock app in Background"),
                                const Spacer(),
                                CupertinoSwitch(
                                    value: lockAppSwitchVal,
                                    activeColor: CupertinoColors.destructiveRed,
                                    onChanged: (val) {
                                      setState(() {
                                        lockAppSwitchVal = val;
                                      });
                                    }),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                          const Divider(),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 38,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.fingerprint,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                const Text("Use Fingerprint"),
                                const Spacer(),
                                CupertinoSwitch(
                                  value: fingerprintSwitchVal,
                                  onChanged: (val) {
                                    setState(() {
                                      fingerprintSwitchVal = val;
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                          const Divider(),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 38,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                const Text("Change Password"),
                                const Spacer(),
                                CupertinoSwitch(
                                  value: changePassSwitchVal,
                                  activeColor: CupertinoColors.destructiveRed,
                                  onChanged: (val) {
                                    setState(() {
                                      changePassSwitchVal = val;
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),   
                  ],
                ),
              ),
            ),
          );
  }
}