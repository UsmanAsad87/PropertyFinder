import 'package:flutter/material.dart';
import 'package:flutter_application_1/search_screen/single_ad_screen.dart';
const double kDefaultPadding =20.0;

class AdTile extends StatefulWidget {
  final snap;
  const AdTile({
    Key? key,required this.snap,
  }) : super(key: key);


  @override
  State<AdTile> createState() => _AdTileState();
}

class _AdTileState extends State<AdTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //color: Colors.blueAccent.shade200,
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding ,
        //bottom: kDefaultPadding ,
      ),
      width: size.width * 0.4,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>SinglePostScreen(ad:widget.snap)));
        },
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width/2.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent),
                  image: DecorationImage(
                      image: NetworkImage(widget.snap['adImageUrl']), fit: BoxFit.cover)),
            ),
            Container(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.blueAccent.withOpacity(0.23),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${widget.snap['title']}\n".toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "${widget.snap['city']}\n".toUpperCase(),
                          style: TextStyle(
                            color: Colors.blueAccent.withOpacity(0.5),
                          ),
                        ),
                        TextSpan(
                          text: '\$${widget.snap['price']}',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
