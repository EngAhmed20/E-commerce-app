import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/moduls/login_scr.dart';
import 'package:shop_app/network/local/shared_pref/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String img;
  final String title;
  final String body;
  BoardingModel({
    required this.img,required this.body,required this.title
});
}

class OnBoardingScr extends StatefulWidget {
  @override
  State<OnBoardingScr> createState() => _OnBoardingScrState();
}

class _OnBoardingScrState extends State<OnBoardingScr> {
 List<BoardingModel> boarding=[
   BoardingModel(
     img: 'assets/images/board.jpg',
     title: 'On Board 1 Title',
     body: 'On Board 1 Body'
   ),
   BoardingModel(
       img: 'assets/images/board2.jpg',
       title: 'On Board 2 Title',
       body: 'On Board 2 Body'
   ),
   BoardingModel(
       img: 'assets/images/board3.jpg',
       title: 'On Board 3 Title',
       body: 'On Board 3 Body'
   ),
 ];
bool islast=false;
 var boardController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed:(){
            CacheHelper.saveData(key: 'Showboard', value: false).then((value) {
              if(value)
                {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScr()), (route) => false);

                }
            });
          }, child: Text('Skip'))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(itemBuilder: (context,index)=>buildBoardItem(boarding[index]),
              itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                if(index==boarding.length-1)
                  {
                    setState(() {
                      islast = true;
                    });
                  }
                else{
                  setState(() {
                    islast=false;
                  });
                }
                },
              ),
            ),
            SizedBox(height: 40,),
            Row(children: [
              SmoothPageIndicator(controller: boardController, count: boarding.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.orange,
                dotHeight: 10,
                dotWidth: 10,
                spacing: 5,
              ),
              ),
              Spacer(),
            FloatingActionButton(onPressed: (){
              if(islast)
                {
                  CacheHelper.saveData(key: 'Showboard', value: false).then((value) {
                    if(value)
                    {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScr()), (route) => false);

                    }
                  });
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScr()),);

                }
              else{
                boardController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn);
              }
            },child:Icon(Icons.arrow_right),),
            ],
            ),
            SizedBox(height: 40,),

          ],
        ),
      ),
    );
  }
}
Widget buildBoardItem(BoardingModel model)=> Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(child: Image(image: AssetImage('${model.img}'),)),
Text('${model.title}',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
SizedBox(height: 20,),
Text('${model.body}',style: TextStyle(fontSize: 20,)),
],
);