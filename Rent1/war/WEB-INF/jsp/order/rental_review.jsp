<%@page import="com.rent1.utils.StringUtils2"%>
<%@page import="java.util.Vector"%>
<%@page import="com.rent1.shop.ShoppingCartItem"%>
<%@page import="com.rent1.entity.RentalRequest"%>
<%@page import="com.rent1.entity.RentalProduct"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<head>
<meta charset="utf-8">
<title>RENT1 - Rental Review</title>
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
					<h3 class="title_green">Review Order</h3>
				</div>
				<div class="text-center pad5">
					<img alt="" src="/webincludes/img/order_status2.png">
				</div>
				<br>
				<div class="row control-group">
					<form method="post" action="/rental/place-order">
						<div class="groove_border span11 pad5">
							<div class="wrap span5">
								<div class="span5">
									<p class="prof_h1_left">Delivery Address</p>
								</div>
								<div style="margin-left: 40px;">
									<%=order.getCustomerFullname()%><br>
									<%=order.getDeliveryAddress().getStreet1()%><br>
									<%
										if (StringUtils.isNotBlank(order.getDeliveryAddress().getStreet2())) {
									%>
									<%=order.getDeliveryAddress().getStreet2()%><br>
									<%
										}
									%>
									<%=order.getDeliveryAddress().getCity()%><br>
									<%=order.getDeliveryAddress().getState()%>,
									<%=order.getDeliveryAddress().getCountry()%><br>
									<%=order.getDeliveryAddress().getPostCode()%><br>
								</div>
							</div>
							<aside class="wrap span5">
								<div class="span5">
									<p class="prof_h1_left">Billing Address</p>
								</div>
								<div style="margin-left: 40px;">
									<%=order.getCustomerCompanyName()%><br>
									<%=order.getCustomerFullname()%><br>
									<%=order.getCustomerAddress().getStreet1()%><br>
									<%
										if (StringUtils.isNotBlank(order.getCustomerAddress().getStreet2())) {
									%>
									<%=order.getCustomerAddress().getStreet2()%><br>
									<%
										}
									%>
									<%=order.getCustomerAddress().getCity()%><br>
									<%=order.getCustomerAddress().getState()%>,
									<%=order.getDeliveryAddress().getCountry()%><br>
									<%=order.getCustomerAddress().getPostCode()%><br>
								</div>
							</aside>
						</div>
						<div class="groove_border span11 pad5">
							<h4 class="pad5">Order Summary</h4>
							<p>* The following is only intended as an estimate and is not a final invoice.</p>
							<div class="wrap span10">
								<table class="ord_table">
									<tbody>
										<tr>
											<th>Description</th>
											<th>Rental Dates</th>
											<th>Est. Price</th>
										</tr>
										<%
											int prodId = 0;
											List<ShoppingCartItem> items = order.getItems();
											for (ShoppingCartItem item : items) {
												prodId++;
										%>
										<tr id="item-<%=prodId%>">
											<td class="span4"><%=item.getName()%></td>
											<td class="span3"><%=item.getStartDate() + " to " + item.getEndDate()%><br> <%="Period (days): " + item.getRentalDays()%></td>
											<td class="span2"><%=StringUtils2.priceToString(item.getRentalEstimate())%></td>
										</tr>
										<%
											}
										%>
										<tr class="subt">
											<td></td>
											<td><strong>SubTotal</strong></td>
											<td><%=StringUtils2.priceToString(order.getSubTotalEstimate())%></td>
										<tr>
										<tr class="subt">
											<td></td>
											<td></td>
											<td>+ Delivery Charge(s)</td>
										<tr>
										<tr class="subt">
											<td></td>
											<td></td>
											<td>+ Applicable Taxes</td>
										</tr>
									<tbody>
								</table>
								<p class="pad10"><strong>Notes:</strong> <%=order.getNotes() %></p>
							</div>
						</div>
						<div>
							<div class="pull-right pad10" style="margin-right: 70px;">
								<button id="saveBtn" class="btn btn-primary" type="submit">
									<i class="icon icon-wrench"></i> Place Order
								</button>
							</div>
							<div class="pad10 pull-right">
								<a id="backBtn" class="btn btn-primary"
									href="/view-cart">
									<i class="icon icon-shopping-cart"></i> Back to Cart
								</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>