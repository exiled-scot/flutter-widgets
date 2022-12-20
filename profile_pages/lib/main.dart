import 'package:flutter/material.dart';

void main() => runApp(ContactProfilePage());

enum APP_THEME { LIGHT, DARK }

class MyAppThemes {

  //Light theme definition
  static ThemeData appThemeLight() {
    //Theme for app
    return ThemeData(
      // Define the default brightness and colors for the overall app.
      brightness: Brightness.light,

      //Appbar theme
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),

      //Theme for icons
      iconTheme: IconThemeData(
        color: Colors.indigo.shade800,
      ),

      //Theme for FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        //White background
        backgroundColor: Colors.white,

        //Black plus (+) sign for FAB
        foregroundColor: Colors.black,
      ),
    );
  }

 //Dark theme definition
  static ThemeData appThemeDark() {

    //Theme for app
    return ThemeData(
      // Define the default brightness and colors for the overall app.
      brightness: Brightness.dark,

      //Theme for AppBar
      appBarTheme: AppBarTheme(
        color: Colors.black,

        //Theme for appBar's icons
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),

      //Theme for app's icons
      iconTheme: IconThemeData(
        color: Colors.orange,
      ),

      //Theme for FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        //dark background for FAB
        backgroundColor: Colors.black,

        //White plus (+) sign for FAB
        foregroundColor: Colors.white,
      ),
    );
  }
}

class ContactProfilePage extends StatefulWidget {
  @override
  _ContactProfilePageState createState() => _ContactProfilePageState();
}

class _ContactProfilePageState extends State<ContactProfilePage> {

  //NEW CODE
  var currentTheme = APP_THEME.LIGHT;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //NEW CODE: Applying theme based on the current selection.
      theme: currentTheme == APP_THEME.DARK
          ? MyAppThemes.appThemeDark()
          : MyAppThemes.appThemeLight(),

      home: Scaffold(
        //Code to build app bar
        appBar: buildAppBarWidget(),

        //Code to build body of the screen
        body: buildBodyWidget(),

        //Code for FAB
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
            icon: Icon(Icons.threesixty),
            onPressed: () {
              setState(() {

                //NEW CODE: Currently selected theme toggles when FAB is pressed
                currentTheme == APP_THEME.DARK
                    ? currentTheme = APP_THEME.LIGHT
                    : currentTheme = APP_THEME.DARK;
              });
            },
          ),
        ),
      ),
    );
  }

  //Building appBar
  PreferredSizeWidget buildAppBarWidget() {
    return AppBar(
      leading: Icon(
        Icons.arrow_back,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.star_border),
          onPressed: () {
            print("Contact is starred");
          },
        ),
      ],
    );
  }

  //Building main body
  Widget buildBodyWidget() {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 250,
              child: Image.network(
                "https://github.com/ptyagicodecamp/educative_flutter/raw/profile_1/assets/profile.jpg?raw=true",
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Priyanka Tyagi",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              child: profileActionItems(),
            ),
            Divider(
              color: Colors.grey,
            ),
            mobilePhoneListTile(),
            otherPhoneListTile(),
            Divider(
              color: Colors.grey,
            ),
            emailListTile(),
            Divider(
              color: Colors.grey,
            ),
            addressListTile(),
          ],
        ),
      ],
    );
  }

  //Building profile action items: Call, Text, Video, etc
  Widget profileActionItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildCallButton(),
        buildTextButton(),
        buildVideoCallButton(),
        buildEmailButton(),
        buildDirectionsButton(),
        buildPayButton(),
      ],
    );
  }

  Widget buildCallButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.call,
          ),
          onPressed: () {},
        ),
        Text("Call"),
      ],
    );
  }

  Widget buildTextButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.message,
          ),
          onPressed: () {},
        ),
        Text("Text"),
      ],
    );
  }

  Widget buildVideoCallButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.video_call,
          ),
          onPressed: () {},
        ),
        Text("Video"),
      ],
    );
  }

  Widget buildEmailButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.email,
          ),
          onPressed: () {},
        ),
        Text("Email"),
      ],
    );
  }

  Widget buildDirectionsButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.directions,
          ),
          onPressed: () {},
        ),
        Text("Directions"),
      ],
    );
  }

  Widget buildPayButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.attach_money,
          ),
          onPressed: () {},
        ),
        Text("Pay"),
      ],
    );
  }

  Widget mobilePhoneListTile() {
    return ListTile(
      leading: Icon(
        Icons.call,
        color: Colors.grey,
      ),
      title: Text("330-803-3390"),
      subtitle: Text("mobile"),
      trailing: IconButton(
        icon: Icon(
          Icons.message,
        ),
        onPressed: () {},
      ),
    );
  }

 //Building phone number component
  Widget otherPhoneListTile() {
    return ListTile(
      leading: Text(""),
      title: Text("440-440-3390"),
      subtitle: Text("other"),
      trailing: IconButton(
        icon: Icon(
          Icons.message,
        ),
        onPressed: () {},
      ),
    );
  }

  //Building email address list tile
  Widget emailListTile() {
    return ListTile(
      leading: Icon(
        Icons.email,
        color: Colors.grey,
      ),
      title: Text("priyanka@priyanka.com"),
      subtitle: Text("work"),
    );
  }

  //Building address widget
  Widget addressListTile() {
    return ListTile(
      leading: Icon(
        Icons.location_on,
        color: Colors.grey,
      ),
      title: Text("234 Sunset St, Burlingame"),
      subtitle: Text("home"),
      trailing: IconButton(
        icon: Icon(
          Icons.directions,
        ),
        onPressed: () {},
      ),
    );
  }
}
