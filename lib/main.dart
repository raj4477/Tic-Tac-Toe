// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:  Homepage()
    );
  }
}
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<List> _matrix;
  _HomepageState(){
    _initMatrix();
  }
  _initMatrix(){
    _matrix =  List<List>(3);
    for(var i=0;i<3;i++){
      _matrix[i] = List (3);
      for( var j = 0; j< 3; j++){
        _matrix[i][j] = ' ';
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(0,0),
                _buildElement(0,1),
                _buildElement(0,2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(1,0),
                _buildElement(1,1),
                _buildElement(1,2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(2,0),
                _buildElement(2,1),
                _buildElement(2,2),
              ],
            ),
          ],
        ),

      ),

    );
  }
  var _lastchar1 ='O';
  _buildElement( int i , int j){
    return GestureDetector(
      onTap: () {
         _change(i,j);
         if(_checkWinner(i,j)){
           _showDialog(_matrix[i][j]);
         }else {
           if (_checkDraw()) {
            _showDialog(null) ;
           }
         }
      },
      child:   Container(

        width: 95,
        decoration: BoxDecoration(
          shape : BoxShape.rectangle,
          border: Border.all(
            color: Colors.blueAccent
          )
        ),
        child: Text(
          _matrix[i][j],

          style: TextStyle(
            fontSize: 100,
            color: Colors.red
          ),
        ),
      ),
    );
  }
  _change(int i, int j){
    setState(() {
      if(_matrix[i][j]==' '){
        if (_lastchar1 == 'O')
          _matrix[i][j] = 'X';
        else
          _matrix[i][j] = 'O';
        _lastchar1 = _matrix[i][j];
      }
    });
  }
  _checkDraw(){
    var draw = true;
    _matrix.forEach((i){
      i.forEach((j){
        if(j==' ')
          draw = false;
      });
    });
    return draw;
  }
  _checkWinner(int x, int y){
    var col= 0,row=0, _dIag=0, _rDiag=0;
    var n =_matrix.length-1;
   String player =_matrix[x][y];
    for (int i =0;i<_matrix.length;i++){
      if(_matrix[x][i]==player)
        col++;
      if(_matrix[i][y]== player)
        row++;
      if(_matrix[i][i]==player)
        _dIag++;
      if(_matrix[i][n-1]==player)
        _rDiag++;
    }
    if ( row ==n+1 || col == n+1 ||_dIag==n+1 || _rDiag == n+1 ) {
      return true;
    }
    return false;

}

_showDialog( String  winner){
 String str;
 if(winner==null)
   {str='It\'s a draw';}
 else{
   str='player $winner Won';}
  showDialog(
      context: context,
      builder: (context){
         return AlertDialog(
           title: Text('Game Over '),
           backgroundColor: Colors.white,
           content:  Text( str),
           actions: <Widget>[
            RaisedButton(onPressed: (){
               Navigator .of(context).pop();
               setState(() {
                 _initMatrix();
               });
             }, child:Text('Reset Game '),
            color: Colors.blueAccent,)
           ],
          );

      }
  );
  }

}