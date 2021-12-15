import 'package:flutter/material.dart';
import 'package:flutter_mask/UI/widget/remain_stat_list_tile.dart';
import 'package:flutter_mask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

//view 영역
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length}곳'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                storeModel.fetch();
              }) //새로고침 버튼
        ], //위젯 액션(반응이 있는 위젯 생성)
      ),
      body: _buildbody(storeModel),
    );
  }

  Widget _buildbody(StoreModel storeModel) {
    if (storeModel.isLoading == true) {
      return loadingWidget();
    }
    if (storeModel.stores.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Not Store in 5Km'), Text('check your internet')],
        ), //5키로 내에 매점이 없거나 인터넷 연결이 안되었을때, 중앙에 띄워줌
      );
    }
    return ListView(
      children: storeModel.stores.map((e) {
        return RemainStatListTile(e);
      }).toList(),
    ); //매점에 대한 리스트를 반환
  }

  Widget loadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('정보를 가져오는 중'),
        CircularProgressIndicator(), //회전 인디케이터
      ],
    )); //로딩화면
  }
}
