// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquidacion_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LiquidacionStore on _LiquidacionStore, Store {
  final _$loadingAtom = Atom(name: '_LiquidacionStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$listLiquidacionAtom = Atom(name: '_LiquidacionStore.listLiquidacion');

  @override
  List<Liquidacion> get listLiquidacion {
    _$listLiquidacionAtom.reportRead();
    return super.listLiquidacion;
  }

  @override
  set listLiquidacion(List<Liquidacion> value) {
    _$listLiquidacionAtom.reportWrite(value, super.listLiquidacion, () {
      super.listLiquidacion = value;
    });
  }

  final _$StoreGetLiquidacionListAsyncAction =
      AsyncAction('_LiquidacionStore.StoreGetLiquidacionList');

  @override
  Future<Liquidacion> StoreGetLiquidacionList(String cobro) {
    return _$StoreGetLiquidacionListAsyncAction
        .run(() => super.StoreGetLiquidacionList(cobro));
  }

  final _$_LiquidacionStoreActionController =
      ActionController(name: '_LiquidacionStore');

  @override
  dynamic setCobro(String cobro) {
    final _$actionInfo = _$_LiquidacionStoreActionController.startAction(
        name: '_LiquidacionStore.setCobro');
    try {
      return super.setCobro(cobro);
    } finally {
      _$_LiquidacionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
listLiquidacion: ${listLiquidacion}
    ''';
  }
}
