class OrderModal {
  String id;
  String order_no;
  String bill_no;
  String cust_name;
  String mobile_no;
  String address;
  String created_at;
  String cust_id;
  String sales_name;
  String status;
  String city_id;
  OrderModal(
      {this.address = "",
      this.order_no = "",
      this.id = "",
      this.bill_no = "",
      this.cust_name = "",
      this.mobile_no = "",
      this.city_id = "",
      this.created_at = "",
      this.cust_id = "",
      this.sales_name = "",
      this.status = ""});
}
