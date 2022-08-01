import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/search_screen/components/adtile.dart';
import 'package:flutter_application_1/search_screen/components/header_with_searchbox.dart';

const double kDefaultPadding =20.0;

class SearchProperty extends StatefulWidget {
  const SearchProperty({Key? key}) : super(key: key);

  @override
  State<SearchProperty> createState() => _SearchPropertyState();
}

class _SearchPropertyState extends State<SearchProperty> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //it will enable scrolling on small device
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent
      ),
      body: Column(
        children: [
          HeaderWithSearchBox(size: size),
          const TitleWithCustomUnderline(text: 'Property for Sell',),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('ads').orderBy('datePublished',descending: true).snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2/3),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>  AdTile(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                );
              },
            ),
          ),



          SizedBox(height: 20,)
        ],
      ) ,
    );
  }
}



class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key, this.text="",
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 24,
      child: Stack(
        children:  [
          Padding(
            padding: const EdgeInsets.only(left : kDefaultPadding/4),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.blueAccent.withOpacity(0.2),
              height: 7,
              margin: const EdgeInsets.only(left: kDefaultPadding / 4),
            ),
          ),
        ],
      ),
    );
  }
}
