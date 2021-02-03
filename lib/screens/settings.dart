import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/theme.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool valueSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ConstantesGradiente.gradientAppBar(context),
        title: Text('Settings'),
      ),
      body: Container(
        decoration: ConstantesGradiente.gradientContainer(context),
        child: ListView(
          children: [
            ListTile(
              trailing: Switch(
                activeColor: Theme.of(context).primaryColor,
                value: valueSwitch,
                onChanged: (value) {
                  Themebuilder.of(context).changeTheme();
                  setState(
                    () {
                      valueSwitch = !valueSwitch;
                    },
                  );
                },
              ),
              title: Text(
                'Dark Theme',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                _buildPopup(context, 'Change Password');
              },
              title: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                _buildPopup(context, 'Delete Account');
              },
              title: Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                _buildPopup(context, 'Support');
              },
              title: Text(
                'Support',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                _buildPopup(context, 'About');
              },
              title: Text(
                'About',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPopup(context, txt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$txt'),
          content: Text('(missing add functionality)'),
          actions: [
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
