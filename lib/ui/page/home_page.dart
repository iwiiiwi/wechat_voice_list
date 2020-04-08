import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat_voice_list/generated/l10n.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).tabHome),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
