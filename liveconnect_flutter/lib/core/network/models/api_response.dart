/// Generic API Response Model
/// 
/// Use this for consistent API response handling.
/// Your backend should return responses in this format.
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final Map<String, dynamic>? errors;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errors,
    this.statusCode,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? true,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      message: json['message'],
      errors: json['errors'] != null
          ? Map<String, dynamic>.from(json['errors'])
          : null,
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'message': message,
      'errors': errors,
      'statusCode': statusCode,
    };
  }
}

/// Paginated API Response Model
class PaginatedResponse<T> {
  final List<T> data;
  final int page;
  final int limit;
  final int total;
  final bool hasMore;

  PaginatedResponse({
    required this.data,
    required this.page,
    required this.limit,
    required this.total,
    required this.hasMore,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return PaginatedResponse<T>(
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => fromJsonT(item))
              .toList() ??
          [],
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      hasMore: json['hasMore'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'page': page,
      'limit': limit,
      'total': total,
      'hasMore': hasMore,
    };
  }
}




