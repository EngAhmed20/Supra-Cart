const userTable='users';
const userData='userData';
const baseUrl='https://wfgvihviefrbvzrwkgye.supabase.co/rest/v1/';
const userId='';
const homeProductsUrl='products_table?select=*,favorite_products(*),purchase_table(*)';
const productRateUrl='rates_table?select=*&for_product=eq.';
const productRateAddUrl='rates_table';
const getProductCommentsUrl='comments_table?select=*&for_product=eq.';
const postProductCommentsUrl='comments_table';
const favTable='favorite_products';
const purchaseTable='purchase_table';
const List<String> orderStatusList = [
  'Pending',
  'Processing',
  'Shipped',
  'Delivered',
  'Confirm Receipt',
  'Archived',
];
const deliveryInfoTable='delivery_info';