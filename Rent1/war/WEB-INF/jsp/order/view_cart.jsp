<%@page import="com.rent1.shop.ShoppingCartItem"%>
<%@page import="java.util.Vector"%>
<%@page import="com.rent1.factory.CategoryFactory"%>
<%@page import="com.rent1.reference.Category"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.rent1.entity.User"%>

<head>
<meta charset="utf-8">
<title>RENT1 - Shopping Cart</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">

<!-- START [Ajax Datepicker] -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- END [Ajax Datepicker] -->
<!-- ==== START [load bootstrap elements] ========== -->
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ==== END ====================================== -->
<!-- START [Google Map Engine] -->
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
<!-- END [Google Map Engine] -->
<script src="/webincludes/js/rent1.js"></script>
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="/webincludes/js/html5shiv.js"></script>
<![endif]-->
<link rel="icon" type="image/png" href="/favicon.ico">
</head>
<body>
	<script type='text/javascript'>
		$(function() {
			initialize_sbar();
			$("#rentstart").datepicker();
			$("#rentend").datepicker();
		});
	</script>
	<script>
		
	<%String secCatas = CategoryFactory.getInstance().getAllSecondayCategoriesToJSArray();%>
		$(function() {
			var availableTags = [
	<%=secCatas%>
		];
			$("#rental").autocomplete({
				source : availableTags
			});
		});
	</script>
	<%@include file='/WEB-INF/jsp/header.jsp'%>
	<div class="content">
		<div class="container">
			<div class="row search-horizontal">
				<div class="span12">
					<form id="rentsearch"
						class="form-horizontal find-equipment gray-box" method='POST'
						action='/search'>
						<fieldset>
							<div class="rental-wrap wrap span3">
								<input id="rental" name="rental"
									placeholder="What are you renting?" type="text" required>
								<span class="icon-wrench"></span>
							</div>
							<div class="location-wrap wrap span3">
								<input id="location" name="location"
									placeholder="Where do you need it?" onFocus="geolocate()"
									type="text" required>
								<p id="enter_location_error_message" class="bad"
									style="display: none;">Please set location</p>
								<span class="icon-map-marker"></span>
							</div>
							<div class="wrap span2">
								<input id="rentstart" name="rentstart" placeholder="Start Date"
									type="text" required> <span class="icon-calendar"></span>
							</div>
							<div class="wrap span2">
								<input id="rentend" name="rentend" placeholder="End Date"
									type="text" required> <span class="icon-calendar"></span>
							</div>
							<button id="submit" class="btn btn-primary" type="submit">
								<i class="icon icon-search"></i> Search
							</button>
						</fieldset>
					</form>
				</div>
			</div>
			<div class="row">
				<aside class="span3">
					<section class="block filters">
						<div class="block-inner clearfix">
							<h4 class="block-title">RENT1 is open 24/7</h4>
							<div class="content clearfix">
								<p style="text-align: center;">
									<img alt="" src="/webincludes/img/open-7-days.png"
										style="width: 192px; height: 171px;" />
								</p>
								<p style="text-align: center;">We're open Saturdays and
									Sundays, no matter when you need your rental.</p>
							</div>
						</div>
					</section>
					<section
						class="block block-block operators-for-hire-block block-7 block-block-7 even"
						id="block-block-7">
						<div class="block-inner clearfix">
							<h4 class="block-title">Support RENT1</h4>
							<div class="content clearfix">
								<p style="text-align: center;">
									(Scrolling ad window below) <img alt=""
										src="https://secure.eyereturn.com/16044/w14-0373_on_demand_300x250_anchorman_2_sv8_v1.jpg" />
								</p>
							</div>
						</div>
					</section>
				</aside>
				<div class="span9">
					<h2 class="title_green"><%="(" + user.getShoppingCart().getTotal() + ") "%>items
						in cart
					</h2>
					<ul class="search-view">
						<%
							int prodId = 0;
							Vector<ShoppingCartItem> items = user.getShoppingCart().getItems();
							for (ShoppingCartItem item : items) {
								prodId++;
						%>
						<li id="cart-item-<%=prodId%>"><a class="thumb pull-left"><img
								src="<%=item.getThumbImg()%>" /></a>
							<div class="pull-left summary">
								<div class="title">
									<a href="<%=item.getUrl()%>">
										<h4><%=item.getName()%></h4>
									</a>
								</div>
								<div class="location"><%="Dates: " + item.getStartDate() + " to "
						+ item.getEndDate()%><br>
									<%="Days: " + item.getRentalDays()%></div>
								<div class="brand">
									<div class="spec">
										<strong><%=item.getRate()%></strong>
									</div>
								</div>
							</div>
							<div class="pull-right info">
							<% if(!item.isAttachment()){ %>
								<div class="price pad5">
								<a class="btn btn-primary" href="/search?attachment=true&productId=<%=item.getProductID() %>">
										Add Attachment(s)</a>
								</div>
							<%} %>
								<div class="price pad5 pull-right">
									<a class="btn btn-small" href="/remove-cart?item=<%=prodId%>">
										Remove</a>
								</div>
							</div></li>
						<%
							}
						%>
					</ul>
					<%
						if (user.getShoppingCart().getTotal() > 0) {
					%>
					<div class="pad10 pull-right">
						<a id="checkout" class="btn btn-primary" href="/rental/request">
							<i class="icon icon-shopping-cart"></i> Proceed to checkout
						</a>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<!-- /content -->
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>