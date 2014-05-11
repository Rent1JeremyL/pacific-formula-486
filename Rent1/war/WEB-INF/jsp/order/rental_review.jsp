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
			RentalRequest order = (RentalRequest) request.getAttribute("rentalOrder");
		%>
		<div class="jumbotron home bg-img"></div>
		<div class="det_container box_outset">
			<div>
				<div class="section-title_h">
					<h3 class="title_green">Review Order</h3>
				</div>
				<div class="text-center pad5"><img alt="" src="/webincludes/img/order_status2.png"></div>
				<br>
				<div class="row control-group">
					<form method="post" action="/rental/place-order">
						<div class="groove_border span11 pad5">
							<h3 class="pad5">Rental Period</h3>
							<div class="wrap span5">
								<p class="prof_h1_left">Start Date:</p>
								<input id="rentstart" name="rentstart"
									class="placeholder-input has-text" placeholder="Start Date"
									type="text" required>
							</div>
							<div class="wrap span5">
								<p class="prof_h1_left">End Date:</p>
								<input id="rentend" name="rentend"
									class="placeholder-input has-text" placeholder="End Date"
									type="text" required>
							</div>
						</div>
						<div>
							<div class="pull-right pad10" style="margin-right: 70px;">
								<button id="saveBtn" class="btn btn-primary" type="submit">
									<i class="icon icon-wrench"></i> Place Order
								</button>
							</div>
							<div class="pad10 pull-right">
								<button id="backBtn" class="btn btn-primary"
									onClick="history.go(-1);return true;">
									<i class="icon icon-arrow-left"></i> Back
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>