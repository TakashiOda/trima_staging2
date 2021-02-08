// $(function(){
//   $('#supplier_address_get_btn').on('click', () => {
//     const code = $('#supplier_address_post_code').val();
//     console.log(code);
//     $.ajax({
//       // url: "http://zipcloud.ibsnet.co.jp/api/search?zipcode=" + $('#supplier_address_post_code').val(),
//       url: `http://zipcloud.ibsnet.co.jp/api/search?zipcode=${code}`,
//       dataType: 'jsonp',
//     }).done((data) => {
//       if (data.results) {
//         getData(data.results[0]);
//       } else {
//         alert('該当データが見つかりません');
//       }
//     }).fail((data) => {
//       alert('通信に失敗しました');
//     });
//   });
//
//   function getData(data) {
//     $('#supplier_pref').val(data.address1);
//     $('#supplier_city').val(data.address2);
//     $('#supplier_address').val(data.address3);
//   }
// });
