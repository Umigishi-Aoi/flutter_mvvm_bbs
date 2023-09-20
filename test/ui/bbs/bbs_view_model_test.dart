import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fluter_mvvm_bbs/config/firestore_settings.dart';
import 'package:fluter_mvvm_bbs/model/firestore/firestore_model.dart';
import 'package:fluter_mvvm_bbs/ui/bbs/view_model/bbs_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final instance = FakeFirebaseFirestore();

  final firestoreModel = FirestoreModel(instance);

  final bbsViewModel = BbsViewModel.withModel(firestoreModel);

  group('BbsViewModel Test', () {
    test('get data test', () async {
      expect(bbsViewModel.bbsData, null);

      await bbsViewModel.getAllData();

      expect(bbsViewModel.bbsData, <Map<String, String>>[]);

      const userName0 = 'test user0';
      const post0 = 'test post0';
      const photoUrl0 = 'https://example0.com';
      final createdAt0 =
          Timestamp.fromDate(DateTime.parse('2021-01-01 00:00:00'));

      final data = <String, dynamic>{
        BbsField.userName.name: userName0,
        BbsField.post.name: post0,
        BbsField.photoUrl.name: photoUrl0,
        BbsField.createdAt.name: createdAt0,
      };

      await instance.collection(Collection.bbs.name).add(data);

      await bbsViewModel.getAllData();

      final bbsData1 = bbsViewModel.bbsData;

      expect(bbsData1?.length, 1);

      expect(bbsData1?[0][BbsField.userName.name], userName0);
      expect(bbsData1?[0][BbsField.post.name], post0);
      expect(bbsData1?[0][BbsField.photoUrl.name], photoUrl0);
      expect(bbsData1?[0][BbsField.createdAt.name], '2021-01-01 00:00');
    });

    test('refresh test', () async {
      const userName1 = 'test user1';
      const post1 = 'test post1';
      const photoUrl1 = 'https://example1.com';
      final createdAt1 =
          Timestamp.fromDate(DateTime.parse('2021-01-02 00:00:00'));

      final data = <String, dynamic>{
        BbsField.userName.name: userName1,
        BbsField.post.name: post1,
        BbsField.photoUrl.name: photoUrl1,
        BbsField.createdAt.name: createdAt1,
      };

      await instance.collection(Collection.bbs.name).add(data);

      await bbsViewModel.refresh();

      final bbsData2 = bbsViewModel.bbsData;

      expect(bbsData2?.length, 2);

      expect(bbsData2?[0][BbsField.userName.name], userName1);
      expect(bbsData2?[0][BbsField.post.name], post1);
      expect(bbsData2?[0][BbsField.photoUrl.name], photoUrl1);
      expect(bbsData2?[0][BbsField.createdAt.name], '2021-01-02 00:00');
    });
  });
}
