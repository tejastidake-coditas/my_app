import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:my_app/core/constants/text_constants.dart';
import 'package:my_app/core/networking/failure_constants.dart';
import 'package:my_app/core/networking/network_constants.dart';
import 'package:my_app/core/utils/enums/method_enum.dart';

class NetworkService {
  late final Dio _dio;
  late Logger _logger;

  NetworkService() {
    final header = {'Content-Type': NetworkConstants.contentType};

    final BaseOptions baseOptions = BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      connectTimeout: NetworkConstants.connectTimeout,
      receiveTimeout: NetworkConstants.recieveTimeout,
      headers: header,
    );

    _dio = Dio(baseOptions);
    _logger = Logger();
    initInterceptors();
  }

  void initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: onRequest,
        onResponse: onResponse,
        onError: onError,
      ),
    );
  }

  dynamic onRequest(RequestOptions requestOptions, handler) {
    _logger.i(
      'Request: ${requestOptions.method}\nData: ${requestOptions.data}',
    );
    return handler.next(requestOptions);
  }

  dynamic onResponse(Response response, handler) {
    _logger.i(
      'Response: ${response.requestOptions.method}\nData: ${response.data}',
    );
    return handler.next(response);
  }

  dynamic onError(DioException err, handler) {
    _logger.e(
      'Error: ${err.response?.requestOptions.method}\nMessage: ${err.response?.statusMessage}',
    );
  }

  Future<Either<Failure, Response<dynamic>>> request(
    String endpoint,
    Method method,
  ) async {
    Response response;

    try {
      switch (method) {
        // we are using switch so if in future we need more methods like post, patch, etc...
        case Method.get:
          response = await _dio.get(endpoint);
          break;
      }
      // now let's handle the status codes:
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(response);
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        return Left(
          ServiceFailure(
            message:
                '${TextConstants.clientError} & StatusCode: ${response.statusCode}',
          ),
        );
      } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
        return Left(
          ServiceFailure(
            message:
                '${TextConstants.serverError} & StatusCode: ${response.statusCode}',
          ),
        );
      } else {
        return Left(
          ServiceFailure(
            message:
                '${TextConstants.unexpectedError} & StatusCode: ${response.statusCode}',
          ),
        );
      }
    } on DioException catch (error) {
      return Left(Failure(error.toString()));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
