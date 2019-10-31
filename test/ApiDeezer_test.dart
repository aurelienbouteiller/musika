import 'dart:convert';
import 'dart:math';

import 'package:musika/ApiDeezer.dart';
import 'package:test/test.dart';

void main (){
  group('ApiDeezer', (){
    test('test getIdByArtiste', ()async{
      var daftPunk = await ApiDeezer.getIdByArtiste("Daft Punk");

      expect(jsonDecode(daftPunk.body)["data"][0]["id"], 78383429 );
    });

    test('test getArtisteById', ()async{
      var daftPunk = await ApiDeezer.getArtisteById(27);

      expect(jsonDecode(daftPunk.body)['name'], "Daft Punk");
    });
    
    test('test getTopMusicByArtisteId', ()async{
      var daftPunk = await ApiDeezer.getTopMusicByArtisteId(27);
      
      expect(jsonDecode(daftPunk.body)['data'][0]["title"], "Get Lucky (Radio Edit)");
    });

    test("test getMusicById", ()async{
      var oneMoreTime = await ApiDeezer.getMusicById(3135553);

      expect(jsonDecode(oneMoreTime.body)["title"], "One More Time");
    });
  });
  
}