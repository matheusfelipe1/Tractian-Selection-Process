import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traction_selection_process/app/core/utils/result.dart';

void main() {
  group("Result tests", () {
    test('Should return data success', () {
      final result = Result<A, Exception>.success(A());
      expect(result.isSuccess, equals(true));
      result.processResult(
        onSuccess: (data) {
          expect(data, isA<A>());
          expect(data.a, "a");
        },
        onFailure: (error) {
          debugPrint("error on $error");
          fail("Should not be called");
        },
      );
    });

    test('Should return data failure', () {
      final result = Result<A, Exception>.failure(Exception("error!!!"));
      expect(result.isSuccess, equals(false));
      result.processResult(
        onSuccess: (data) {
          fail("Should not be called");
        },
        onFailure: (error) {
          expect(error, isA<Exception>());
          expect(error.toString(), "Exception: error!!!");
        },
      );
    });
  });
}

class A {
  final String a = "a";
}
