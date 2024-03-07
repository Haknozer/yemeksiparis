import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yemeksiparis/data/entity/yemekler.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;


  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blue.shade900
        ),
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close,size: 40,)
        ),
        title: const Text("Ürün Detayı"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite,size: 40,))
        ],
      ),
    );
  }
}
