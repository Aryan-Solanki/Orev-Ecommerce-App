import 'package:flutter/material.dart';
import 'package:orev/models/OrderProduct.dart';

import 'Product.dart';

class Order {
  final bool cod;
  final String deliveryBoy;
  final double deliveryCost;
  final String orderStatus;
  final OrderProduct product;
  final String orderId;
  final double totalCost;
  final String userId;
  final String timestamp;
  final String responseMsg;
  final Map selectedAddress;
  final double codcharges;
  final bool usedOrevWallet;
  final double orevWalletAmountUsed;
  final String transactionId;
  Order(
      {this.cod,
      this.deliveryBoy,
      this.deliveryCost,
      this.orderStatus,
      this.product,
      this.orderId,
      this.totalCost,
      this.userId,
      this.timestamp,
      this.responseMsg,
      this.selectedAddress,
      this.codcharges,
      this.orevWalletAmountUsed,
      this.transactionId,
      this.usedOrevWallet});
}
