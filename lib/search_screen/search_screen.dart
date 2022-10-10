import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Getx/search_controller.dart';
import 'package:flutter_application_1/search_screen/components/adtile.dart';
import 'package:flutter_application_1/search_screen/components/header_with_searchbox.dart';
import 'package:get/get.dart';

const double kDefaultPadding =20.0;

class SearchProperty extends StatefulWidget {
  SearchProperty({Key? key}) : super(key: key);


  @override
  State<SearchProperty> createState() => _SearchPropertyState();
}

class _SearchPropertyState extends State<SearchProperty> {
  final searchController = Get.put(SearchController());
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
          searchController.searchText==''?
          Expanded(
            child: Column(
              children: [
                const TitleWithCustomUnderline(text: 'Property for Sell',),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('ads').orderBy('datePublished',descending: true).snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
              ],
            ),
          ):
          //Text(searchController.searchText.toString()),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('ads')
                  .where('title',
                  isGreaterThanOrEqualTo: searchController.searchText.toString())
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                  snapshot) {
                if (!snapshot.hasData) {
                  print('no data');
                  return const Center(
                    child: CircularProgressIndicator(
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Center(
                    child: CircularProgressIndicator(
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        const Text('No ads found'),
                        TextButton(
                          child: const Text(
                            "See all Ads",
                            style: TextStyle(fontSize: 12),
                          ),
                          onPressed: () {
                            searchController.searchText =RxString('');
                            print(searchController.searchText);
                            setState(() {

                            });
                          },
                        )
                      ],
                    ),
                  );
                }
                else {
                  return   GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2/3),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>  AdTile(
                        snap: snapshot.data!.docs[index].data(),
                      ),
                  );
                }
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
