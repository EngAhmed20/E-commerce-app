import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/search_cubit/SearchStates.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shared/component/constant.dart';

import '../../network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? searchmodel;

  void search({required String text})
  {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,token:token, data: {
     'text':text,
    }).then((value) {
      searchmodel=SearchModel.fromJson(value.data);
      emit(SearchSucessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
    
  }

}