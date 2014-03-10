<%@page import="com.rent1.reference.CategoryFactory"%>
<%@page import="com.rent1.reference.Category"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.rent1.entity.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.rent1.entity.RentalProduct"%>
<%@page import="com.rent1.dao.RentalProductDao"%>

<head>
<meta charset="utf-8">
<title>RENT1 - Search Results</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="webincludes/css/bootstrap.css">
<link rel="stylesheet" href="webincludes/css/style.css">
<link rel="stylesheet" href="webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="webincludes/css/rent1.css">

<script src="webincludes/js/rent1.js"></script>

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="webincludes/js/html5shiv.js"></script>
    <![endif]-->

<link rel="icon" type="image/png" href="favicon.ico">

</head>
<body onload="initialize_sbar()">
	<%
		RentalProductDao dao = RentalProductDao.INSTANCE;

			List<RentalProduct> prods = new ArrayList<RentalProduct>();
			prods = dao.getProducts();
	%>
	<div id="fb-root"></div>
	<script>
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=272672346204724";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	</script>

	<header class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<%
			CategoryFactory cf = CategoryFactory.getInstance();
			ArrayList<Category> catagories = cf.getCatagories();
			User user = null;
			user = (User) session.getAttribute("user");
			if (user != null) {
			%>
			<ul class="nav pull-right logout">
				<li><a href="/logout"><i class="icon icon-signout"></i> Log
						Out</a></li>
			</ul>
			<%
				}
			%>
			<div class="container">
				<a href="/" class="logo"><img src="/webincludes/img/logo.png"></a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="dropdown"><a data-toggle="dropdown"
							class="dropdown-toggle" href="#">BROWSE <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="test.html">Aerial Work Platforms</a></li>
								<li><a href="#">Air Compressors &amp; Air Tools</a></li>
								<li><a href="#">Compaction</a></li>
								<li><a href="#">Forklifts &amp; Material Handling</a></li>
								<li><a href="#">Light Towers &amp; Generators</a></li>
							</ul></li>
					</ul>
				</div>
				<%
					if (user == null) {
				%>
				<a href="/register" class="btn btn-primary pull-right"
					style="margin: 1em">Create Account</a>
				<%
					}
				%><a href="#" class="btn btn-brown pull-right" style="margin: 1em">LIST
					YOUR STORE</a>
				<div class="nav-collapse collapse pull-right">
					<ul class="nav">
						<%
							if (user != null) {
						%>
						<li class="dropdown"><a data-toggle="dropdown"
							class="dropdown-toggle"> WELCOME <%=user.getNickName()%>!, <b
								class="caret"></b>
						</a>
							<ul class="dropdown-menu">
								<li><a href="/">Home</a></li>
								<li><a href="/profile">Profile</a></li>
								<li><a href="#">Orders</a></li>
							</ul></li>
						<%
							} else {
						%>
						<li>
							<!-- href="userService.createLoginURL(request.getRequestURI())" -->
							<a href="/login">SIGN IN</a>
						</li>
						<%
							}
						%>
						<li class="dropdown"><a data-toggle="dropdown"
							class="dropdown-toggle" href="#">HELP <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="#">Frequently Asked Questions</a></li>
								<li><a href="#">Support</a></li>
							</ul></li>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</header>
	<div class="content">
		<div class="container">
			<div class="row search-horizontal">
				<div class="span12">
					<form class="form-horizontal find-equipment gray-box" method='POST'
						action='/search'>
						<fieldset>
							<div class="rental-wrap wrap span3">
								<div class="custom-select-container">
									<select id="rental" name="rental" class="search-option small">
										<%
											for ( Category cata : catagories){
												int x=catagories.indexOf(cata)+1;
										%>
										<option value="<%=cf.getIndex(cata)%>"><%=cata%></option>
										<%
											}
										%>
									</select>
								</div>
							</div>
							<div class="location-wrap wrap span3">
								<input id="location" name="location"
									placeholder="Where do you need it?" onFocus="geolocate()"
									type="text">
								<p id="enter_location_error_message" class="bad"
									style="display: none;">Please set location</p>
								<span class="icon-map-marker"></span>
							</div>
							<div class="rentstart wrap span2">
								<input id="rentstart" name="rentstart" placeholder="Start Date"
									type="text"> <span class="icon-calendar"></span>
							</div>
							<div class="rentend wrap span2">
								<input id="rentend" name="rentend" placeholder="End Date"
									type="text"> <span class="icon-calendar"></span>
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
						<h4>Categories</h4>
						<ul class="unstyled search-filter panel-padding">
							<li><label class="checkbox"><input type="checkbox">
									Backhoes <span>(7)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Dozers
									<span>(4)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Earthmoving
									Attachments <span>(21)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Excavators
									<span>(7)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Graders
									&amp; Scrapers <span>(1)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Mini-Excavators
									<span>(7)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Skid
									Steers &amp; Track Loaders <span>(8)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Sweepers
									<span>(2)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Tractors
									<span>(1)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Trenchers
									<span>(6)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Wheel
									Loaders <span>(3)</span></label></li>
						</ul>
						<h4>Type</h4>
						<ul class="unstyled search-filter panel-padding">
							<li><label class="checkbox"><input type="checkbox">For
									Rent <span>(102)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">For
									Sale <span>(64)</span></label></li>
						</ul>
						<h4>Drive Train</h4>
						<ul class="unstyled search-filter panel-padding">
							<li><label class="checkbox"><input type="checkbox">2WD
									<span>(3)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">4WD
									<span>(6)</span></label></li>
						</ul>
						<h4>Attachment Type</h4>
						<ul class="unstyled search-filter panel-padding">
							<li><label class="checkbox"><input type="checkbox">Backhoe
									<span>(1)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Excavator
									<span>(4)</span></label></li>
							<li><label class="checkbox"><input type="checkbox">Skid
									Steer <span>(3)</span></label></li>
						</ul>
					</section>
				</aside>

				<div class="span9">
					<div class="pad10 gray-box">
						<%=prods.size()%>
						results
					</div>

					<ul class="search-view">
						<%
							for (RentalProduct prd : prods) {
						%>
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="<%=prd.getThumbImg()%>" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="<%=prd.getCompanyHref()%>" target="_blank">
										<h4><%=prd.getMake()+" "+prd.getModelName()+" "+prd.getCategory()%></h4>
									</a>
								</div>
								<div class="location"><%=prd.getCity()+", "+prd.getState()%></div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="<%=prd.getMakeImg()%>" /></a>
									<div class="spec">
										<strong><%=prd.getSpecs().getPrimarySpecType()%></strong> <%=prd.getSpecs().getPrimarySpecValue()%><br> 
										<strong><%=prd.getSpecs().getSecondarySpecType()%></strong> <%=prd.getSpecs().getSecondarySpecValue()%>
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol"><%=prd.getPricePlan().getCurrencySymbol()%></sup> 
									<span class="amount"><%=prd.getPricePlan().getRateDefault()%></span> 
									<sup class="currency"><%=prd.getPricePlan().getCurrencyCode()%></sup>
								</div>
								<span class="rate"><%=prd.getPricePlan().getDefaultType()%></span> <a href="#" class="more"
									data-toggle="collapse" data-target="#more-pricing-1">More
									Pricing <i class="icon icon-double-angle-right"></i>
								</a>
							</div>

							<div id="more-pricing-1" class="collapse">
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
										<td><%=prd.getPricePlan().getCurrencySymbol()+prd.getPricePlan().getRateDaily()%></td>
										<td><%=prd.getPricePlan().getCurrencySymbol()+prd.getPricePlan().getRateWeekly()%></td>
										<td><%=prd.getPricePlan().getCurrencySymbol()+prd.getPricePlan().getRateMonthly()%></td>
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


	<footer class="container">

		<!-- <hr> -->

		<div class="row">
			<div class="span3">
				<img src="/webincludes/img/rent1-logo-gray.png" class="logo" />
				<p>
					Copyright &copy; 2013 RENT1.<br /> All rights reserved.
				</p>
				<div class="fb-like" data-href="http://www.test.com"
					data-send="false" data-layout="button_count" data-width="50"
					data-show-faces="false"></div>
				<div class="g-plusone" data-size="medium"
					data-href="http://www.test.com"></div>
			</div>
			<div class="span3">
				<h2>Contact</h2>
				<ul class="menu nav">
					<li class="first leaf"><a title="" href="http://www.test.com">Email
							Us</a></li>
					<li class="leaf"><a title="" href="http://www.test.com">Newsletter</a></li>
					<li class="leaf"><a title="" href="http://www.test.com">Help
							&amp; Support</a></li>
					<li class="last leaf"><a title="" href="http://www.test.com">Press
							Kit</a></li>
				</ul>
			</div>
			<div class="span3">
				<h2>Company</h2>
				<ul class="menu nav">
					<li class="first leaf"><a title="" href="http://www.test.com">About</a></li>
					<li class="leaf"><a title="" href="http://www.test.com">Blog</a></li>
					<li class="leaf"><a title="" href="http://www.test.com">Jobs</a></li>
					<li class="leaf"><a title="" href="http://www.test.com">Policies</a></li>
					<li class="last leaf"><a title="" href="http://www.test.com">Terms
							&amp; Privacy</a></li>
				</ul>
			</div>
			<div class="span3">
				<h2>Investors</h2>
				<ul class="menu nav">
					<li class="first leaf"><a title="" href="http://www.test.com">Investor
							Presentations</a></li>
					<li class="leaf"><a title="" href="http://www.test.com">Investor
							Events</a></li>
					<li class="leaf"><a title="" href="http://www.test.com">Annual
							Reports</a></li>
					<li class="leaf"><a title="" href="http://www.test.com">SEC
							Filings</a></li>
					<li class="last leaf"><a title="" href="http://www.test.com">Research
							Coverage</a></li>
				</ul>
			</div>
		</div>

	</footer>
	<!-- /footer -->

	<!-- javascript
  ================================================== -->
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="webincludes/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		(function() {
			var po = document.createElement('script');
			po.type = 'text/javascript';
			po.async = true;
			po.src = 'https://apis.google.com/js/plusone.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(po, s);
		})();
	</script>


</body>