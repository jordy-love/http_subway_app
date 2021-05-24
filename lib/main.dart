import 'package:flutter/material.dart';
import 'package:http_subway_app/sub.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '지하철 실시간 정보',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  var _pages = [Page1(), Page2(), Page3()];

  static const String _urlPrefix = 'http://swopenapi.seoul.go.kr/api/subway/';
  static const String _userKey = 'sample';
  static const String _urlSuffix = '/json/realtimeStationArrival/0/5';
  static const String _defaultStation = '광화문';

  String _response = '';

  String _buildUrl(String station) {
    StringBuffer sb = StringBuffer();
    sb.write(_urlPrefix);
    sb.write(_userKey);
    sb.write(_urlSuffix);
    sb.write(station);
    return sb.toString();
  }

  _httpGet(String url) async {
    var url = Uri.parse(_buildUrl(_defaultStation));
    var response = await http.get(url);
    String res = response.body;
    setState(() {
      _response = res;
    });
  }


  @override
  void initState() {
    super.initState();
    _httpGet(_buildUrl(_defaultStation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("지하철 실시간 정보", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[  // 오른쪽아이콘
          IconButton(
            icon: Icon(Icons.add, color: Colors.black,),
            onPressed: () {},
          ),
        ],
      ),
      body: Text(_response), //_pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.web_asset), title: Text('테스트1')),
          BottomNavigationBarItem(icon: Icon(Icons.web_asset), title: Text('테스트2')),
          BottomNavigationBarItem(icon: Icon(Icons.web_asset), title: Text('테스트3')),
        ],
      ),
    );
  }
}
