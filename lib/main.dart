import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:uispdokatacalc/objects/point.dart';
import 'package:uispdokatacalc/objects/button.dart';
import 'package:uispdokatacalc/objects/button2.dart';
import 'package:uispdokatacalc/ad_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;
/*
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }
*/
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pos = 0;
  List<int> pM = [0, 0, 0, 0, 0];
  List<int> pD = [0, 0, 0, 0, 0];
  List<Widget> cronologia = [];
  double pt = 0;

  late BannerAd _ad;

//  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    // COMPLETE: Create a BannerAd instance
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
          print('Ad failed to load: $error');
        },
//        onAdOpened: (Ad ad) => print('Ad opened.'),
//        onAdClosed: (Ad ad) => print('Ad closed.'),
//        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    _ad.load();
  }

  @override
  void dispose() {
//    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Row(
                  children: const [
                    Tab(icon: Icon(Icons.border_clear)),
                    Text(' PUNTI'),
                  ],
                ),
                Row(
                  children: const [
                    Tab(icon: Icon(Icons.schedule)),
                    Text(' CRONOLOGIA'),
                  ],
                ),
              ],
            ),
            title: const Text('KATA Calc')),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    KataPoint(
                        value: '${pM[0]}.${pD[0]}',
                        pos: pos,
                        i: 0,
                        onclick: _p0),
                    KataPoint(
                        value: pt.toString(), pos: 99, i: 99, onclick: _p99),
                    KataPoint(
                        value: '${pM[4]}.${pD[4]}',
                        pos: pos,
                        i: 4,
                        onclick: _p4),
                  ],
                ),
                Row(
                  children: <Widget>[
                    KataPoint(
                        value: '${pM[1]}.${pD[1]}',
                        pos: pos,
                        i: 1,
                        onclick: _p1),
                    KataPoint(
                        value: '${pM[2]}.${pD[2]}',
                        pos: pos,
                        i: 2,
                        onclick: _p2),
                    KataPoint(
                        value: '${pM[3]}.${pD[3]}',
                        pos: pos,
                        i: 3,
                        onclick: _p3),
                  ],
                ),
                Row(
                  children: <Widget>[
                    KataButton2(
                      value: '6',
                      onclick: _pm6,
                    ),
                    KataButton2(
                      value: '7',
                      onclick: _pm7,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    KataButton(
                      value: '7',
                      onclick: _b7,
                    ),
                    KataButton(
                      value: '8',
                      onclick: _b8,
                    ),
                    KataButton(
                      value: '9',
                      onclick: _b9,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    KataButton(
                      value: '4',
                      onclick: _b4,
                    ),
                    KataButton(
                      value: '5',
                      onclick: _b5,
                    ),
                    KataButton(
                      value: '6',
                      onclick: _b6,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    KataButton(
                      value: '1',
                      onclick: _b1,
                    ),
                    KataButton(
                      value: '2',
                      onclick: _b2,
                    ),
                    KataButton(
                      value: '3',
                      onclick: _b3,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    KataButton(
                      value: 'C',
                      onclick: _bClear,
                    ),
                    KataButton(
                      value: '0',
                      onclick: _b0,
                    ),
//                    KataButton(value: 'N',onclick: _bNext,),
//                    Tab(icon: Icon(Icons.arrow_forward)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: () => {_bNext()},
                          child: const Icon(
                            Icons.keyboard_return,
                            size: 54.0,
                          ),
//                          child: Icon(Icons.arrow_forward, size: 54.0,),
/*                          Text(
                            value!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            fontSize: 45.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            )
                          ),
  */
                        ),
                      ),
                    ),
                  ],
                ),
// BANNER PUBBLICITARIO

                Container(
                  width: _ad.size.width.toDouble(),
                  height: 72.0,
                  alignment: Alignment.center,
                  child: AdWidget(ad: _ad),
                ),
              ],
            ),
            Column(
              children: cronologia,
            ),
          ],
        ),
      ),
    );
  }

  void _calcolaTotale() {
    double min = 10;
    double max = 0;
    pt = 0;
    for (int i = 0; i < 5; i++) {
      double value = pM[i] + pD[i] / 10;
      pt = pt + value;
      if (min > value) {
        min = value;
      }
      if (max < value) {
        max = value;
      }
    }
    pt = pt - min - max;
    pt = ((pt * 10).round().toDouble() / 10);
  }

  void _displayAll() {
    setState(() {
      _calcolaTotale();
    });
  }

  void _incrementAndDisplay(int n) {
    if (pM[pos] != 0) {
      pD[pos] = n;
      pos = pos + 1;
      _displayAll();
    }
  }

  void _pm6() {
    pM[pos] = 6;
    _displayAll();
  }

  void _pm7() {
    pM[pos] = 7;
    _displayAll();
  }

  void _p0() {
    pos = 0;
    _displayAll();
  }

  void _p1() {
    pos = 1;
    _displayAll();
  }

  void _p2() {
    pos = 2;
    _displayAll();
  }

  void _p3() {
    pos = 3;
    _displayAll();
  }

  void _p4() {
    pos = 4;
    _displayAll();
  }

  void _p99() {
    _displayAll();
  }

  void _b0() {
    _incrementAndDisplay(0);
  }

  void _b1() {
    _incrementAndDisplay(1);
  }

  void _b2() {
    _incrementAndDisplay(2);
  }

  void _b3() {
    _incrementAndDisplay(3);
  }

  void _b4() {
    _incrementAndDisplay(4);
  }

  void _b5() {
    _incrementAndDisplay(5);
  }

  void _b6() {
    _incrementAndDisplay(6);
  }

  void _b7() {
    _incrementAndDisplay(7);
  }

  void _b8() {
    _incrementAndDisplay(8);
  }

  void _b9() {
    _incrementAndDisplay(9);
  }

  void _bClear() {
    pos = 0;
    pM = [0, 0, 0, 0, 0];
    pD = [0, 0, 0, 0, 0];
    pt = 0;
    _displayAll();
  }

  void _bNext() {
    var now = DateTime.now();
//  var formatter = new DateFormat('yyyy-MM-dd');
    var formatter = DateFormat('HH:mm:ss');
    String s = formatter.format(now);

    for (int i = 0; i < 5; i++) {
      s = "$s - ${pM[i].toString()} . ${pD[i].toString()}";
    }
    _calcolaTotale();
    s = '$s = ${pt.toString()}';

    cronologia.add(Text(s,
//        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 18.0,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w700,
        )));
    _bClear();
  }
}



/*

class _BannerInlinePageState extends State<BannerInlinePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob Banner Inline Ad'),
      ),
      body: ListView.builder(
        // COMPLETE: Adjust itemCount based on the ad load state
        itemCount: widget.entries.length + (_isAdLoaded ? 1 : 0),
        itemBuilder: (context, index) {
          // COMPLETE: Render a banner ad
          if (_isAdLoaded && index == _kAdIndex) {
            return Container(
              child: AdWidget(ad: _ad),
              width: _ad.size.width.toDouble(),
              height: 72.0,
              alignment: Alignment.center,
            );
          } else {
            // COMPLETE: Get adjusted item index from _getDestinationItemIndex()
            final item = widget.entries[_getDestinationItemIndex(index)];

            return ListTile(
              leading: Image.asset(
                item.asset,
                width: 48,
                height: 48,
                package: 'flutter_gallery_assets',
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Text(item.duration),
              onTap: () {
                print('Clicked ${item.name}');
              },
            );
          }
        },
      ),
    );
  }

  // COMPLETE: Add _getDestinationItemIndex()
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }
}


*/