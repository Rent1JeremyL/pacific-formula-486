<%@page import="java.util.Vector"%>
<%@page import="com.rent1.shop.ShoppingCartItem"%>
<%@page import="com.rent1.entity.RentalRequest"%>
<%@page import="com.rent1.entity.RentalProduct"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<head>
<meta charset="utf-8">
<title>RENT1 - Order Placed</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">
<link rel="icon" type="image/png" href="/favicon.ico">
<!-- ==== START [load bootstrap elements] ========== -->
<script src="/webincludes/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- ==== END ====================================== -->
<script src="/webincludes/js/rent1.js"></script>
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="/webincludes/js/html5shiv.js"></script>
<![endif]-->
</head>
<body>
	<%@include file='/WEB-INF/jsp/header.jsp'%>
	<div class="content" style="background: #D8D8D8;">
		<%
			RentalRequest order = (RentalRequest) user.getRentalRequest();
		%>
		<div class="jumbotron home bg-img"></div>
		<div class="det_container box_outset">
			<div>
				<div class="section-title_h">
					<h3 class="title_green">Order Placed</h3>
				</div>
				<div class="text-center pad5">
					<img alt="" src="/webincludes/img/order_status3.png">
				</div>
				<br>
				<div class="row control-group">
						<div class="groove_border span11 pad5">
							<div class="wrap span10">
								<div class="span9" style="margin-left: 40px;">
									<p><strong>Thank you for your order.  It will be reviewed and you will receive final confirmation shortly.</strong></p><br>
								</div>
								<div class="span9" style="margin-left: 40px;">
									<p>Say some stuff about the order regarding terms and conditions.  How billing will be done by the end company
									and the order still needs to be confirmed and is subject to change.</p>
								</div>
							</div>
						</div>						
						<div>
							<div class="pad10 pull-right">
								<a id="backBtn" class="btn btn-primary"
									style="margin-right: 30px" href="/">
									<i class="icon icon-shopping-cart"></i> Back to Shopping
								</a>
							</div>
						</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>