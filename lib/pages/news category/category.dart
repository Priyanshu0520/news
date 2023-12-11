// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../home/model.dart';


class Categoryy extends StatefulWidget {


String Query;
Categoryy({super.key,  required this.Query});
  @override
  State<Categoryy> createState() => _CategoryState();
}

class _CategoryState extends State<Categoryy> {
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
 bool isLoading = true;
    getNewsByQuery(String query) async {
      String url = '';
      if (query == "Top News"){
       url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
    }else if(query == "Entertainment"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
    }else if(query == "Sports"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
    }else if(query == "Politics"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=politics&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
    }else if(query == "Business"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
    }else if(query == "Health"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
    }
    else if(query == "Technology"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
    }
    else{
      
      url ="https://newsapi.org/v2/everything?domains=wsj.com&apiKey=5c1a1c7bad7c40a88e598294cd511d51";}
   
  
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });

      });
    });

  }
  @override
   void initState(){
     super.initState();
   getNewsByQuery(widget.Query);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 255, 228),
        title: const Text('Categorized News'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin : const EdgeInsets.fromLTRB(15, 25, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text(widget.Query , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 28
                        ),),
                      ],
                    ),
                  ),

                     isLoading? Center(child: Container(child: const CircularProgressIndicator())):
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsModelList.length,
                      itemBuilder: (context, index) {
                        return Container(
                         
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Card(
                            
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 1.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(newsModelList[index].newsImg)),

                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black12.withOpacity(0),
                                              Colors.black
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter
                                          )
                                        ),
                                        padding: const EdgeInsets.fromLTRB(15, 15, 10, 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newsModelList[index].newsHead,
                                                
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(newsModelList[index].newsDes.length >50 ? "${newsModelList[index].newsDes.substring(0,50)}..." : newsModelList[index].newsDes ,  style: const TextStyle(color: Colors.white , fontSize: 12)
                                                ,)
                                            ],
                                          )))
                                ],
                              )),
                        );
                      }),
             
             
                ],
              ),
            ),
    );
  }
}