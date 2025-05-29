// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CreateVisitsPage]
class CreateVisitsRoute extends PageRouteInfo<CreateVisitsRouteArgs> {
  CreateVisitsRoute({
    required Customer? customer,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CreateVisitsRoute.name,
          args: CreateVisitsRouteArgs(customer: customer, key: key),
          initialChildren: children,
        );

  static const String name = 'CreateVisitsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateVisitsRouteArgs>();
      return CreateVisitsPage(customer: args.customer, key: args.key);
    },
  );
}

class CreateVisitsRouteArgs {
  const CreateVisitsRouteArgs({required this.customer, this.key});

  final Customer? customer;

  final Key? key;

  @override
  String toString() {
    return 'CreateVisitsRouteArgs{customer: $customer, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateVisitsRouteArgs) return false;
    return customer == other.customer && key == other.key;
  }

  @override
  int get hashCode => customer.hashCode ^ key.hashCode;
}

/// generated route for
/// [CutsomersPage]
class CutsomersRoute extends PageRouteInfo<void> {
  const CutsomersRoute({List<PageRouteInfo>? children})
      : super(CutsomersRoute.name, initialChildren: children);

  static const String name = 'CutsomersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CutsomersPage();
    },
  );
}

/// generated route for
/// [VisitsPage]
class VisitsRoute extends PageRouteInfo<VisitsRouteArgs> {
  VisitsRoute({
    required Customer? customer,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          VisitsRoute.name,
          args: VisitsRouteArgs(customer: customer, key: key),
          initialChildren: children,
        );

  static const String name = 'VisitsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VisitsRouteArgs>();
      return VisitsPage(customer: args.customer, key: args.key);
    },
  );
}

class VisitsRouteArgs {
  const VisitsRouteArgs({required this.customer, this.key});

  final Customer? customer;

  final Key? key;

  @override
  String toString() {
    return 'VisitsRouteArgs{customer: $customer, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VisitsRouteArgs) return false;
    return customer == other.customer && key == other.key;
  }

  @override
  int get hashCode => customer.hashCode ^ key.hashCode;
}
