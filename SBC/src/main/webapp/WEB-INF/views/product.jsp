<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	$.ajaxSetup({
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',	//한글깨짐 방지
		success: function(result) {
			alert(result);
		},
		error: function(jqXHR) {
			//Exception 처리
			alert("jqXHR status code:"+jqXHR.status+" message:"+jqXHR.responseText);	
		}
	});	//.ajaxSetup

	//GET
	$("#testGetListBtn").click(function(){
		$.ajax({
			type: "get",
			url: "products",
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(productList) {
				$("#listView").empty();
				$.each(productList, function(i, product) {
					$("#listView").append(
							product.product_id+" "
							+product.product_name+" "
							+product.price
							+"<br>").css("background", "pink");
				});
			}
		});	//.ajax
	});	//.click
	
});	//.ready
</script>
</head>
<body>
GET : 리스트 조회 
	<button value="testGetListBtn" id="testGetListBtn">조회</button><br>
	<div id="listView"></div><br><br>
</body>
</html>