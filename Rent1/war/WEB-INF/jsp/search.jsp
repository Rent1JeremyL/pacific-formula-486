<%@page import="com.rent1.reference.CategoryFactory"%>
<%@page import="com.rent1.reference.Category"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.rent1.entity.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.rent1.entity.RentalProduct"%>

<head>
<meta charset="utf-8">
<title>RENT1 - Search Results</title>
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
<!-- javascript load bootstrap elements =============== -->
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ================================================== -->
<!-- START [Gooogle Map Engine] -->
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
<!-- END [Gooogle Map Engine] -->
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
			$( "#rentstart" ).datepicker();
			$( "#rentend" ).datepicker();
			
			document.getElementById('rental').value='<%=session.getAttribute("searchString")%>';
			document.getElementById('location').value='<%=session.getAttribute("searchLoc")%>';
			document.getElementById('rentstart').value='<%=session.getAttribute("searchStart")%>';
			document.getElementById('rentend').value='<%=session.getAttribute("searchEnd")%>';
		});
	</script>
	<%
		List<RentalProduct> prods = (ArrayList<RentalProduct>) session
				.getAttribute("products");
	%>
	<%@include file='/WEB-INF/jsp/header.jsp'%>
	<div class="content">
		<div class="container">
			<div class="row search-horizontal">
				<div class="span12">
					<form class="form-horizontal find-equipment gray-box" method='POST'
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
							<div class="rentstart wrap span2">
								<input id="rentstart" name="rentstart" placeholder="Start Date"
									type="text" required> <span class="icon-calendar"></span>
							</div>
							<div class="rentend wrap span2">
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
							<h4 class="block-title">Suport RENT1</h4>
							<div class="content clearfix">
								<p style="text-align: center;">
								(Scrolling ad window below)
									<img alt="" src="https://secure.eyereturn.com/16044/w14-0373_on_demand_300x250_anchorman_2_sv8_v1.jpg" />
								</p>
							</div>
						</div>
					</section>
				</aside>

				<div class="span9">
					<div class="pad10 gray-box">
						<%=prods.size()%>
						results
					</div>

					<ul class="search-view">
						<%
							int prodId = 0;
							for (RentalProduct prd : prods) {
								prodId++;
						%>
						<li class="product-<%=prodId%>"><a href="#"
							class="thumb pull-left"><img src="<%=prd.getThumbImg()%>" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="<%=prd.getCompanyHref()%>">
										<h4><%=prd.getMake() + " " + prd.getModelName() + " "
						+ prd.getCategory()%></h4>
									</a>
								</div>
								<div class="location"><%=prd.getCity() + ", " + prd.getState()%></div>
								<div class="brand">
									<a class="brand-thumb pull-left"
										href="<%=prd.getCompanyHref()%>" target="_blank"><img
										src="<%=prd.getMakeImg()%>" /></a>
									<div class="spec">
										<strong><%=prd.getSpecs().getPrimarySpecType()%></strong>
										<%=prd.getSpecs().getPrimarySpecValue()%><br> <strong><%=prd.getSpecs().getSecondarySpecType()%></strong>
										<%=prd.getSpecs().getSecondarySpecValue()%>
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<%
										Integer days = (Integer) session.getAttribute("rentalDays");
											String[] defRates = prd.getPricePlan().getDefaultRateValues(
													days.intValue());
									%>
									<sup class="symbol"><%=prd.getPricePlan().getCurrencySymbol()%></sup>
									<span class="amount"><%=defRates[1]%></span> <sup
										class="currency"><%=prd.getPricePlan().getCurrencyCode()%></sup>
								</div>
								<span class="rate"><%=defRates[0]%></span> <a
									href="#product-<%=prodId%>" class="more" data-toggle="collapse"
									data-target="#more-pricing-<%=prodId%>">More Pricing <i
									class="icon icon-double-angle-right"></i>
								</a>
							</div>

							<div id="more-pricing-<%=prodId%>" class="collapse">
								<table class="table table-bordered">
									<tr>
										<th>Daily</th>
										<th>Weekly</th>
										<th>Monthly</th>
										<td rowspan="2"
											style="width: 160px; text-align: center; padding-top: 15px;">
											<a href="#" class="btn btn-primary btn-large">Rent Now</a>
										</td>
									</tr>
									<tr>
										<td><%=prd.getPricePlan().getCurrencySymbol()
						+ prd.getPricePlan().getRateDaily()%></td>
										<td><%=prd.getPricePlan().getCurrencySymbol()
						+ prd.getPricePlan().getRateWeekly()%></td>
										<td><%=prd.getPricePlan().getCurrencySymbol()
						+ prd.getPricePlan().getRateMonthly()%></td>
									</tr>
								</table>
							</div></li>
						<%
							}
						%>
					</ul>
				</div>

			</div>

		</div>
	</div>
	<!-- /content -->
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>