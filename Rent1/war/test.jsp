<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>jQuery UI Datepicker - Default functionality</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

<script>
$(function() {
$( "#rentstart" ).datepicker();
});
</script>
</head>
<body>
<p>Date: <input type="text" id="rentstart" name="rentstart"></p>
<%@include file='/WEB-INF/jsp/footer.jsp' %>
</body>
</html>