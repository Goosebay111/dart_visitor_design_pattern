// you want to produce different outcomes of related classes under different conditions (i.e. discount, wholesale).
void main() {
  // set to receive information that you want from a special configuration.
  var cost = RetailPricingVisitor();
  var discount = DiscountPricingVisitor();
  // set a list of objects that you want to visit.
  var workStuff = [Laptop(), Mobile(), Tablet()];
  // visit each object in the list.
  for (var equipment in workStuff) {
    // calls the specific gear (i.e. laptop, mobile, tablet) and triggers a specific method in the Visitor.
    // (i.e. visitLaptop, visitMobile, visitTablet).
    // this method handles the processing of that peice of gear.
    equipment.accept(cost);
  }

  print('Total cost: ${cost.totalPrice}');

  for (var equipment in workStuff) {
    equipment.accept(discount);
  }
  print('Total cost: ${discount.totalPrice}');
}

// different Pricings are modifiable by using different concrete implementations of the interface.
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

// sets the output of the conditions.
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

// each peice of equipment has a method called accept that takes a visitor.
// the accept method for each concrete class will call the appropriate visit method for the visitor.
// this is possible because of polymorphism (i.e. extends),
// which does not require a @oveerride for each method.
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
  // it was not necessary to override discountPrice because of polymorphism (extends).
  // @override
  // double discountPrice() => retailPrice * 0.9;

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
