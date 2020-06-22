import 'package:testcart/Utils/data.dart';
import 'package:testcart/UI/detailscreen.dart';
import 'package:testcart/Model/product_model.dart';
import 'package:flutter/material.dart';

class SearchByCountry extends SearchDelegate {
  final List<Product> _cases;

  SearchByCountry(this._cases);

  var style = TextStyle(
      fontFamily: 'Ubuntu', fontSize: 20, fontWeight: FontWeight.w300);


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> result =[];
    if (query.length > 0) {
      result= _cases.where((element) => element.title.toLowerCase().contains(query) | element.categoryName.contains(query)).toList();
    }

    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: ListView(
        children: result.map((e){
          return InkWell(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailedScreen(e)));
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width*0.9,
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Row(
                children: <Widget>[
                  Image.network(
                    e.images,
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Text(
                      e.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: style.copyWith(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: fFamily),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
