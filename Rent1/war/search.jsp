<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Search Results | RENT1</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="css/bootstrap.css">
<!-- <link rel="stylesheet" href="css/bootstrap-responsive.css"> -->
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/font-awesome.min.css">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->

<link rel="icon" type="image/png" href="favicon.ico">

</head>
<body>

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
				UserService userService = UserServiceFactory.getUserService();
				User user = userService.getCurrentUser();
				if (user != null) {
					pageContext.setAttribute("user", user);
			%>
			<ul class="nav pull-right logout">
				<li><a
					href="<%=userService.createLogoutURL(request.getRequestURI())%>"><i
						class="icon icon-signout"></i> Log Out</a></li>
			</ul>
			<%
				}
			%>
			<div class="container">
				<a href="/" class="logo"><img src="img/logo.png" /></a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="dropdown"><a data-toggle="dropdown"
							class="dropdown-toggle" href="#">BROWSE <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="#">Aerial Work Platforms</a></li>
								<li><a href="#">Air Compressors &amp; Air Tools</a></li>
								<li><a href="#">Compaction</a></li>
								<li><a href="#">Forklifts &amp; Material Handling</a></li>
								<li><a href="#">Light Towers &amp; Generators</a></li>
							</ul></li>
					</ul>
				</div>
				<!--/.nav-collapse -->

				<a href="#" class="btn btn-brown pull-right">LIST YOUR STORE</a>

				<div class="nav-collapse collapse pull-right">
					<ul class="nav">
						<%
							if (user != null) {
						%>
						<li><a href="#">WELCOME ${fn:escapeXml(user.nickname)}! ,</a></li>
						<%
							} else {
						%>
						<li><a
							href="<%=userService.createLoginURL(request.getRequestURI())%>">SIGN
								IN</a></li>
						<%
							}
						%>
						<!--li><a href="#">LOG IN</a></li-->
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
					<form class="form-horizontal find-equipment gray-box">
						<fieldset>
							<div class="rental-wrap wrap span3">
								<input id="rental" name="rental"
									placeholder="What are you renting?"
									value="Earthmoving Equipment" type="text"> <span
									class="icon-wrench"></span>
							</div>
							<div class="location-wrap wrap span3">
								<input id="location" name="location"
									placeholder="Where do you need it?" value="Vancouver, BC"
									type="text"> <span class="icon-map-marker"></span>
							</div>
							<div class="rentstart wrap span2">
								<input id="rentstart" name="rentstart" placeholder="Start Date"
									type="text"> <span class="icon-calendar"></span>
							</div>
							<div class="rentend wrap span2">
								<input id="rentend" name="rentend" placeholder="End Date"
									type="text"> <span class="icon-calendar"></span>
							</div>
							<a class="btn btn-primary" href="/search.jsp"><i
								class="icon icon-search"></i> Search</a>
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
						834 results with <a href="#">100 popular sellers</a>
						<button class="btn pull-right pull-up-5">
							<i class="icon icon-share"></i> SHARE
						</button>
					</div>

					<ul class="search-view">
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="img/product-thumb.jpg" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="product.html"><h4>John Deere 320D Skid Steer</h4></a>
								</div>
								<div class="location">Vancouver, BC</div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="img/brand/john-deere.jpg" /></a>
									<div class="spec">
										<strong>Size:</strong> 126" x 70" x 115"<br /> <strong>Weight:</strong>
										6,435 lb (2,919 kg)
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol">$</sup> <span class="amount">240</span> <sup
										class="currency">CAD</sup>
								</div>
								<span class="rate">Per Day</span> <a href="#" class="more"
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
										<td>$240</td>
										<td>$1200</td>
										<td>$3800</td>
									</tr>
								</table>
							</div></li>
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="img/bobcat-thumb.jpg" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="product.html"><h4>Bobcat S205</h4></a>
								</div>
								<div class="location">Vancouver, BC</div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="img/brand/bobcat.jpg" /></a>
									<div class="spec">
										<strong>Size:</strong> 126" x 70" x 115"<br /> <strong>Weight:</strong>
										6,435 lb (2,919 kg)
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol">$</sup> <span class="amount">240</span> <sup
										class="currency">CAD</sup>
								</div>
								<span class="rate">Per Day</span> <a href="#" class="more"
									data-toggle="collapse" data-target="#more-pricing-2">More
									Pricing <i class="icon icon-double-angle-right"></i>
								</a>
							</div>

							<div id="more-pricing-2" class="collapse">
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
										<td>$240</td>
										<td>$1200</td>
										<td>$3800</td>
									</tr>
								</table>
							</div></li>
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="img/product-thumb.jpg" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="product.html"><h4>John Deere 320D Skid Steer</h4></a>
								</div>
								<div class="location">Vancouver, BC</div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="img/brand/john-deere.jpg" /></a>
									<div class="spec">
										<strong>Size:</strong> 126" x 70" x 115"<br /> <strong>Weight:</strong>
										6,435 lb (2,919 kg)
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol">$</sup> <span class="amount">240</span> <sup
										class="currency">CAD</sup>
								</div>
								<span class="rate">Per Day</span> <a href="#" class="more"
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
										<td>$240</td>
										<td>$1200</td>
										<td>$3800</td>
									</tr>
								</table>
							</div></li>
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="img/bobcat-thumb.jpg" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="product.html"><h4>Bobcat S205</h4></a>
								</div>
								<div class="location">Vancouver, BC</div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="img/brand/bobcat.jpg" /></a>
									<div class="spec">
										<strong>Size:</strong> 126" x 70" x 115"<br /> <strong>Weight:</strong>
										6,435 lb (2,919 kg)
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol">$</sup> <span class="amount">240</span> <sup
										class="currency">CAD</sup>
								</div>
								<span class="rate">Per Day</span> <a href="#" class="more"
									data-toggle="collapse" data-target="#more-pricing-2">More
									Pricing <i class="icon icon-double-angle-right"></i>
								</a>
							</div>

							<div id="more-pricing-2" class="collapse">
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
										<td>$240</td>
										<td>$1200</td>
										<td>$3800</td>
									</tr>
								</table>
							</div></li>
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="img/product-thumb.jpg" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="product.html"><h4>John Deere 320D Skid Steer</h4></a>
								</div>
								<div class="location">Vancouver, BC</div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="img/brand/john-deere.jpg" /></a>
									<div class="spec">
										<strong>Size:</strong> 126" x 70" x 115"<br /> <strong>Weight:</strong>
										6,435 lb (2,919 kg)
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol">$</sup> <span class="amount">240</span> <sup
										class="currency">CAD</sup>
								</div>
								<span class="rate">Per Day</span> <a href="#" class="more"
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
										<td>$240</td>
										<td>$1200</td>
										<td>$3800</td>
									</tr>
								</table>
							</div></li>
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="img/bobcat-thumb.jpg" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="product.html"><h4>Bobcat S205</h4></a>
								</div>
								<div class="location">Vancouver, BC</div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="img/brand/bobcat.jpg" /></a>
									<div class="spec">
										<strong>Size:</strong> 126" x 70" x 115"<br /> <strong>Weight:</strong>
										6,435 lb (2,919 kg)
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol">$</sup> <span class="amount">240</span> <sup
										class="currency">CAD</sup>
								</div>
								<span class="rate">Per Day</span> <a href="#" class="more"
									data-toggle="collapse" data-target="#more-pricing-2">More
									Pricing <i class="icon icon-double-angle-right"></i>
								</a>
							</div>

							<div id="more-pricing-2" class="collapse">
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
										<td>$240</td>
										<td>$1200</td>
										<td>$3800</td>
									</tr>
								</table>
							</div></li>
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="img/product-thumb.jpg" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="product.html"><h4>John Deere 320D Skid Steer</h4></a>
								</div>
								<div class="location">Vancouver, BC</div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="img/brand/john-deere.jpg" /></a>
									<div class="spec">
										<strong>Size:</strong> 126" x 70" x 115"<br /> <strong>Weight:</strong>
										6,435 lb (2,919 kg)
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol">$</sup> <span class="amount">240</span> <sup
										class="currency">CAD</sup>
								</div>
								<span class="rate">Per Day</span> <a href="#" class="more"
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
										<td>$240</td>
										<td>$1200</td>
										<td>$3800</td>
									</tr>
								</table>
							</div></li>
						<li class="product"><a href="#" class="thumb pull-left"><img
								src="img/bobcat-thumb.jpg" /></a>

							<div class="pull-left summary">
								<div class="title">
									<a href="product.html"><h4>Bobcat S205</h4></a>
								</div>
								<div class="location">Vancouver, BC</div>
								<div class="brand">
									<a class="brand-thumb pull-left" href="#"><img
										src="img/brand/bobcat.jpg" /></a>
									<div class="spec">
										<strong>Size:</strong> 126" x 70" x 115"<br /> <strong>Weight:</strong>
										6,435 lb (2,919 kg)
									</div>
								</div>
							</div>

							<div class="pull-right info">
								<div class="price">
									<sup class="symbol">$</sup> <span class="amount">240</span> <sup
										class="currency">CAD</sup>
								</div>
								<span class="rate">Per Day</span> <a href="#" class="more"
									data-toggle="collapse" data-target="#more-pricing-2">More
									Pricing <i class="icon icon-double-angle-right"></i>
								</a>
							</div>

							<div id="more-pricing-2" class="collapse">
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
										<td>$240</td>
										<td>$1200</td>
										<td>$3800</td>
									</tr>
								</table>
							</div></li>
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
				<img src="img/rent1-logo-gray.png" class="logo" />
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
	<script src="js/bootstrap.min.js"></script>
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
</html>