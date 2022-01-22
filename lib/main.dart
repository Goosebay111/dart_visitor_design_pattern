void main() {
  var cost = RetailPricingVisitor();
  var discount = DiscountPricingVisitor();

  var workStuff = [Laptop(), Mobile(), Tablet()];
  for (var equipment in workStuff) {
    equipment.accept(cost);
  }
  print('Total cost: ${cost.totalPrice}');

  for (var equipment in workStuff) {
    equipment.accept(discount);
  }
  print('Total cost: ${discount.totalPrice}');
}

class RetailPricingVisitor extends EquipmentVisitor {
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  @override
  void visitLaptop(Laptop laptop) {
    _totalPrice += laptop.retailPrice;
  }

  @override
  void visitMobile(Mobile mobile) {
    _totalPrice += mobile.retailPrice;
  }

  @override
  void visitTablet(Tablet tablet) {
    _totalPrice += tablet.retailPrice;
  }
}

class DiscountPricingVisitor extends EquipmentVisitor {
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  @override
  void visitLaptop(Laptop laptop) {
    _totalPrice += laptop.discountPrice();
  }

  @override
  void visitMobile(Mobile mobile) {
    _totalPrice += mobile.discountPrice();
  }

  @override
  void visitTablet(Tablet tablet) {
    _totalPrice += tablet.discountPrice();
  }
}

//For each peice of equipment, we need to implement a visitor
abstract class EquipmentVisitor {
  void visitMobile(Mobile mobile);
  void visitTablet(Tablet tablet);
  void visitLaptop(Laptop laptop);
}

abstract class Equipment {
  Equipment(this.name);
  String name;

  int? watt;
  late double retailPrice;
  double discountPrice() => retailPrice;

  void accept(visitor);
}

class Mobile extends Equipment {
  Mobile() : super('Mobile Phone') {
    retailPrice = 350.00;
  }

  @override
  void accept(visitor) => visitor.visitMobile(this);
}

class Tablet extends Equipment {
  Tablet() : super('Tablet') {
    retailPrice = 400.00;
  }

  @override
  double discountPrice() => retailPrice * 0.8;

  @override
  void accept(visitor) => visitor.visitTablet(this);
}

class Laptop extends Equipment {
  Laptop() : super('Laptop') {
    retailPrice = 1000.00;
  }

  @override
  double discountPrice() => retailPrice * 0.9;

  @override
  void accept(visitor) => visitor.visitLaptop(this);
}
