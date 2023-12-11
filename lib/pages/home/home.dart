import 'dart:convert';
import 'dart:ui'; 
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/pages/home/model.dart';
import 'package:news/pages/news category/category.dart';
//import 'package:flutter/src/foundation/annotations.dart ';
import 'package:http/http.dart';
import 'package:news/pages/news%20view/newsview.dart';


class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newsModelListCarousel = <NewsQueryModel>[];
  List<String> navBarItem = ["Top News", "Politics","Business","Technology","Sports" ,"Entertainment" , "Health"];
  bool isLoading = true;
  
  
  getNewsByQuery(String query) async {
    
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
  Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });

      });
    });

  }

  getNews() async {
    String url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=5c1a1c7bad7c40a88e598294cd511d51";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelListCarousel.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });

      });
    });


  }


  @override
  void initState() {

    super.initState();
    getNewsByQuery('india');
    getNews();
  }

  @override
  Widget build(BuildContext context) {
  

    
    return SafeArea(
      child: Scaffold(
        
          drawer: const Drawer( ),
          appBar: AppBar(
            
          
         title: const Text('ताज़ा ख़बर', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 25),),
         centerTitle: true,
         
         actions: const [Icon(Icons.event_sharp),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
          Icon(Icons.notifications),
           
           Padding(padding: EdgeInsets.symmetric(horizontal: 9)),],
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
              
                 toolbarHeight: 50,
           
       flexibleSpace: Container(
        height: 48,
        
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 150, 234, 220),Color.fromARGB(255, 54, 255, 228)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                
                 ),
               ),
             )
             ),
            
          body: Container(
            height: 1000,
            child: SingleChildScrollView(
              
              child: Column(
                
                    children: [
              Container(
                height: 40,
                
                margin: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
               
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 224, 225, 222),
                  borderRadius: BorderRadius.circular(55)
                  
                ),
                child: Row(
                  children: [
                    GestureDetector(
                       onTap: (){ if ((searchController.text).replaceAll(" ", "") ==
                      "") {
                    print("Blank search");
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Categoryy( Query :searchController.text)));
                  }
                  },
                
                       child: Container(
                        margin: EdgeInsets.only(right: 20 , left: 10),
                        child: Icon(Icons.search , color: Colors.blue),
                        ),
                    ),
                    
                       Expanded( 
                        
                         child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value){
                           if(value == ""){
                            print('blank');
                           }
                           else{
                           Navigator.push(
                            context, MaterialPageRoute(builder: (context)=> Categoryy( Query :value))); }
                            },
                        decoration: InputDecoration(
                          
                          border: InputBorder.none,
                          
                          hintText: "search the news "
                        ),
                       ),
                     )
                  ],
                ),
                
              ),
              Container(
            height: 33,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: navBarItem.length,
                itemBuilder : (context , index){
                return InkWell(
                  onTap: () {
                    
                    Navigator.push(context,MaterialPageRoute(builder:
                      (context)=> Categoryy(Query: navBarItem[index])));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20 , vertical : 10),
                    margin: EdgeInsets.symmetric(horizontal : 2),
                    decoration : BoxDecoration(
                      color: Color.fromARGB(255, 54, 255, 228),
                      borderRadius : BorderRadius.circular(15)
                    ),

                    child : Center(
                      child: Text(
                          navBarItem[index] ,
                      style: TextStyle(
                        fontSize:12 ,
                        color: Colors.black,
                        fontWeight:FontWeight.bold
                      )),
                    ),
                  ),
                );
                }
            )
          ),
              
              
              
              SizedBox(
                height: 12
                
              ),
               Container(
               child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left:8),
                          child: Text("World News " , style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 26
                          ),),
                        ),
                      ],
                    ),
                  ),


               isLoading ? Center(
                 child: Container(height :35,
                  child: CircularProgressIndicator()),
               ): CarouselSlider(
                
                options : CarouselOptions(
                  
                  height : 175,
                  
                  autoPlay : true,
                    enlargeCenterPage : false
                ),
                items :  newsModelListCarousel.map((instance) {
                  return Builder(
                    
                    builder: (BuildContext context){
                      return Container(
                        
                        margin: EdgeInsets.symmetric(vertical: 0),
                        child: InkWell(
                          onTap: () {
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsView(instance.newsUrl)));
                          },
                          child: Card(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  
                                  borderRadius: BorderRadius.circular(15),
                                  child:Image.network(instance.newsImg , height: double.infinity,),
                                ),
                                Positioned(
                                  left: 9,
                                  right: 0,
                                  bottom: 8,
                                  child: Container(
                                  
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text("" ,style: TextStyle(
                                      color: Colors.white , fontWeight: FontWeight.bold,fontSize: 17
                                    ),),
                                     Text(instance.newsHead ,style: TextStyle(
                                      color: Colors.white , fontWeight: FontWeight.bold
                                    ),   )],
                                  ),
                                )
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  );
                }).toList(),
               
              ),
              SizedBox(
                height: 10,
              ),
              Container(
              child: Column(
                children: [
                  Container(
                    margin : EdgeInsets.fromLTRB(15, 25, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text("LATEST NEWS " , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 28
                        ),),
                      ],
                    ),
                  ),

                  isLoading? Center(child: Container(child: CircularProgressIndicator())):
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsModelList.length,
                      itemBuilder: (context, index) {
                        return Container(
                         
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                        padding: EdgeInsets.fromLTRB(15, 15, 10, 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newsModelList[index].newsHead,
                                                
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(newsModelList[index].newsDes.length >50 ? "${newsModelList[index].newsDes.substring(0,50)}..." : newsModelList[index].newsDes ,  style: TextStyle(color: Colors.white , fontSize: 12)
                                                ,)
                                            ],
                                          )))
                                ],
                              )),
                        );
                      }),
             
              Container(
                padding: EdgeInsets.fromLTRB(0,10,0,5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){}, child: Text("SHOW MORE")),
                  ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
      )
    );

  }
 final List items = [ Image.network("https://www.shutterstock.com/image-vector/breaking-news-background-world-global-260nw-719766118.jpg") ];
  }
