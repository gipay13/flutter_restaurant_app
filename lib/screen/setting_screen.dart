import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/assets/style/style.dart';
import 'package:flutter_restaurant_app/model/provider/notification_provider.dart';
import 'package:flutter_restaurant_app/model/provider/preference_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eater", style: Theme.of(context).textTheme.headline5.copyWith(color: palatte2, fontWeight: FontWeight.bold),), centerTitle: true,
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: Text("Notification"),
                  trailing: Consumer<NotificationProvider>(
                    builder: (context, state, _) {
                      return Switch.adaptive(
                        value: provider.isDailyNewsActive,
                        onChanged: (value) async {
                          state.notificationRestaurant(value);
                          provider.enableDailyNews(value);
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
