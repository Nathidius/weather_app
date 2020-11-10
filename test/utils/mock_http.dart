import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

// Thanks to below solution there is possibility to test widgets
// containing SvgPicture.network.
Future<void> mockHttp(VoidCallback body) async {
  final MockHttpClient mockHttpClient = MockHttpClient();
  final MockHttpClientRequest mockRequest = MockHttpClientRequest();
  final MockHttpClientResponse mockResponse = MockHttpClientResponse();

  when(mockHttpClient.getUrl(any))
      .thenAnswer((_) => Future<MockHttpClientRequest>.value(mockRequest));

  when(mockRequest.close())
      .thenAnswer((_) => Future<MockHttpClientResponse>.value(mockResponse));

  await HttpOverrides.runZoned(() async {
    when(mockResponse.statusCode).thenReturn(200);
    when(mockResponse.compressionState)
        .thenReturn(HttpClientResponseCompressionState.notCompressed);
    body();
  }, createHttpClient: (SecurityContext c) => mockHttpClient);
}
