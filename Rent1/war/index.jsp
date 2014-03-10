<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.rent1.entity.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.rent1.reference.CategoryFactory"%>
<%@page import="com.rent1.reference.Category"%>
<%@page import="java.util.List"%>

<head>
<meta charset="utf-8">
<title>RENT1</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="webincludes/css/bootstrap.css">
<link rel="stylesheet" href="webincludes/css/style.css">
<link rel="stylesheet" href="webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="webincludes/css/rent1.css">

<!-- START [Ajax Datepicker] -->
<link rel="stylesheet"
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/themes/ui-darkness/jquery-ui.css">
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
<!-- END [Ajax Datepicker] -->

<!-- START [Gooogle Map Engine] -->
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
<!-- END [Gooogle Map Engine] -->

<script src="webincludes/js/rent1.js"></script>

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="webincludes/js/html5shiv.js"></script>
    <![endif]-->
<link rel="icon" type="image/png" href="favicon.ico">
</head>
<body>
	<script type='text/javascript'>
		$(document).ready(function() {
			initialize_sbar();
			$('#datepicker').datepicker();
			$('#rentend').datepicker();
			$("#datepicker").datepicker("setDate", new Date);
		});
	</script>
	<div class=" fb_reset" id="fb-root">
		<div
			style="position: absolute; top: -10000px; height: 0px; width: 0px;">
			<div>
				<iframe
					src="http://static.ak.facebook.com/connect/xd_arbiter.php?version=40#channel=f7231717919628&amp;origin=http%3A%2F%2Frent1demo.lexcorp.ca"
					style="border: medium none;" tab-index="-1"
					title="Facebook Cross Domain Communication Frame"
					aria-hidden="true" id="fb_xdm_frame_http" allowtransparency="true"
					name="fb_xdm_frame_http" scrolling="no" frameborder="0"></iframe>
				<iframe
					src="https://s-static.ak.facebook.com/connect/xd_arbiter.php?version=40#channel=f7231717919628&amp;origin=http%3A%2F%2Frent1demo.lexcorp.ca"
					style="border: medium none;" tab-index="-1"
					title="Facebook Cross Domain Communication Frame"
					aria-hidden="true" id="fb_xdm_frame_https" allowtransparency="true"
					name="fb_xdm_frame_https" scrolling="no" frameborder="0"></iframe>
			</div>
		</div>
		<div
			style="position: absolute; top: -10000px; height: 0px; width: 0px;">
			<div>
				<iframe
					src="https://www.facebook.com/connect/ping?client_id=272672346204724&amp;domain=rent1demo.lexcorp.ca&amp;origin=1&amp;redirect_uri=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D40%23cb%3Df2d5956f4369b34%26domain%3Drent1demo.lexcorp.ca%26origin%3Dhttp%253A%252F%252Frent1demo.lexcorp.ca%252Ff7231717919628%26relation%3Dparent&amp;response_type=token%2Csigned_request%2Ccode&amp;sdk=joey"
					style="display: none;" allowtransparency="true"
					name="f260707571a95ec" scrolling="no" frameborder="0"></iframe>
			</div>
		</div>
	</div>
	<script async=""
		src="https://apis.google.com/_/scs/apps-static/_/js/k=oz.gapi.en.XRY3JMZg4gk.O/m=auth/exm=plusone/rt=j/sv=1/d=1/ed=1/am=IQ/rs=AItRSTPoMDNZYsbhLrpsdslX9ONNmyeJqw/cb=gapi.loaded_1"></script>
	<script async=""
		src="https://apis.google.com/_/scs/apps-static/_/js/k=oz.gapi.en.XRY3JMZg4gk.O/m=plusone/rt=j/sv=1/d=1/ed=1/am=IQ/rs=AItRSTPoMDNZYsbhLrpsdslX9ONNmyeJqw/cb=gapi.loaded_0"></script>
	<script gapi_processed="true"
		src="https://apis.google.com/js/plusone.js" async=""
		type="text/javascript"></script>
	<script
		src="//connect.facebook.net/en_US/all.js#xfbml=1&amp;appId=272672346204724"
		id="facebook-jssdk"></script>
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
								<%
									for ( Category cata : catagories){
								%>
								<li><a href="template.jsp"><%=cata%></a></li>
								<%
									}
								%>
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

	<div class="jumbotron masthead home bg-img">
		<div class="container">
			<h1>Find your equipment.</h1>
			<h3>Rent from over 1,421 cities across North America.</h3>
			<form class="form-horizontal find-equipment well" method='POST'
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
					<div class="wrap span2">
						<input id="datepicker" name="rentstart" placeholder="Start Date"
							type="text"><span class="icon-calendar"></span>
					</div>
					<div class="wrap span2">
						<input id="datepicker" name="rentend" placeholder="End Date"
							type="text"><span class="icon-calendar"></span>
					</div>
					<button id="submit" class="btn btn-primary" type="submit">
						<i class="icon icon-search"></i> Search
					</button>
				</fieldset>
			</form>
		</div>
	</div>
	<div class="content">
		<div class="row cta">
			<div class="container">
				<h1>The best selection, the best prices, anywhere.</h1>
				<p>Rent1 is an online marketplace for heavy equipment and
					construction tool rentals that showcases available offerings by
					rental companies in various geographic areas.</p>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class="span8">
					<h3>View Our Categories</h3>
				</div>
				<div class="span4">
					<h3>View Cities</h3>
				</div>
			</div>
			<div class="row categories">
				<div class="span4">
					<%
						int size = catagories.size();
						int half = size /2;
						List<Category> list1 = catagories.subList(0, half);
						List<Category> list2 = catagories.subList(half, size);
					%>
					<ul>
						<%
							for(Category cata1 : list1){
						%>
						<li><a href="#"><%=cata1%></a></li>
						<%
							}
						%>
					</ul>
				</div>
				<div class="span4">
					<ul>
						<%
							for(Category cata2 : list2){
						%>
						<li><a href="#"><%=cata2%></a></li>
						<%
							}
						%>
					</ul>
				</div>
				<div class="span2">
					<ul>
						<li><a href="#">Vancouver</a></li>
						<li><a href="#">Calgary</a></li>
						<li><a href="#">Edmonton</a></li>
						<li><a href="#">Toronto</a></li>
						<li><a href="#">Montreal</a></li>
						<li><a href="#">Kelowna</a></li>
						<li><a href="#">Abbotsford</a></li>
						<li><a href="#">Surrey</a></li>
					</ul>
				</div>
				<div class="span2">
					<ul>
						<li><a href="#">Seattle</a></li>
						<li><a href="#">Los Angeles</a></li>
						<li><a href="#">New York</a></li>
						<li><a href="#">Detroit</a></li>
						<li><a href="#">Boston</a></li>
						<li><a href="#">California</a></li>
						<li><a href="#">San Diego</a></li>
						<li><a href="#">Miami</a></li>
					</ul>
				</div>
			</div>
		</div>

		<!-- Example row of columns -->
		<div class="row homepage-surface">
			<div class="equipment wrap">
				<div class="container">
					<img class="equipment-selection"
						src="/webincludes/img/biggest-equipment-selection.png">
					<div class="text">
						<h2>Biggest equipment selection in the world.</h2>
						<p>Itaque earum rerum hic tenetur a sapiente delectus. Ut enim
							ad minim veniam, quis nostrud exercitation ullamco. Fugiat quo
							voluptas nulla pariatur? Non numquam eius modi tempora incidunt
							ut labore et dolore magnam aliquam quaerat voluptatem.</p>
					</div>
				</div>
			</div>
			<div class="pricing wrap">
				<div class="container">
					<div class="text">
						<h2>Offering the most competitive pricing available, period.</h2>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Temporibus autem quibusdam et aut officiis debitis aut rerum
							necessitatibus saepe eveniet ut et voluptates repudiandae sint et
							molestiae non recusandae. Cupiditate non provident, similique
							sunt in culpa qui officia deserunt mollitia. Architecto beatae
							vitae dicta sunt explicabo.</p>
					</div>
					<img class="competitive-pricing"
						src="/webincludes/img/competitive-pricing.png">
				</div>
			</div>
			<div class="platform wrap">
				<div class="container">
					<img class="quickest-simplest-platform"
						src="/webincludes/img/quickest-simplest-platform.png">
					<div class="text">
						<h2>The quickest &amp; simplest platform to manage all your
							rental needs.</h2>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Temporibus autem quibusdam et aut officiis debitis aut rerum
							necessitatibus saepe eveniet ut et voluptates repudiandae sint et
							molestiae non recusandae. Cupiditate non provident, similique
							sunt in culpa qui officia deserunt mollitia. Architecto beatae
							vitae dicta sunt explicabo.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /content -->


	<footer class="container">

		<!-- <hr> -->

		<div class="row">
			<div class="span3">
				<img src="/webincludes/img/rent1-logo-gray.png" class="logo">
				<p>
					Copyright Â© 2013 RENT1.<br> All rights reserved.
				</p>
				<div
					fb-iframe-plugin-query="app_id=272672346204724&amp;href=http%3A%2F%2Fwww.test.com%2F&amp;layout=button_count&amp;locale=en_US&amp;sdk=joey&amp;send=false&amp;show_faces=false&amp;width=50"
					fb-xfbml-state="rendered" class="fb-like fb_iframe_widget"
					data-href="http://www.test.com" data-send="false"
					data-layout="button_count" data-width="50" data-show-faces="false">
					<span style="vertical-align: bottom; width: 80px; height: 20px;"><iframe
							class=""
							src="http://www.facebook.com/plugins/like.php?app_id=272672346204724&amp;channel=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D40%23cb%3Df1a502da93dd1de%26domain%3Drent1demo.lexcorp.ca%26origin%3Dhttp%253A%252F%252Frent1demo.lexcorp.ca%252Ff7231717919628%26relation%3Dparent.parent&amp;href=http%3A%2F%2Fwww.test.com%2F&amp;layout=button_count&amp;locale=en_US&amp;sdk=joey&amp;send=false&amp;show_faces=false&amp;width=50"
							style="border: medium none; visibility: visible; width: 80px; height: 20px;"
							title="fb:like Facebook Social Plugin" allowtransparency="true"
							name="f28151b20664d62" scrolling="no" width="50px"
							frameborder="0" height="1000px"></iframe></span>
				</div>
				<div id="___plusone_0"
					style="text-indent: 0px; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% transparent; border-style: none; float: none; line-height: normal; font-size: 1px; vertical-align: baseline; display: inline-block; width: 90px; height: 20px;">
					<iframe title="+1" data-gapiattached="true"
						src="https://apis.google.com/u/0/_/+1/fastbutton?usegapi=1&amp;bsv=o&amp;size=medium&amp;origin=http%3A%2F%2Frent1demo.lexcorp.ca&amp;url=http%3A%2F%2Fwww.test.com%2F&amp;gsrc=3p&amp;ic=1&amp;jsh=m%3B%2F_%2Fscs%2Fapps-static%2F_%2Fjs%2Fk%3Doz.gapi.en.XRY3JMZg4gk.O%2Fm%3D__features__%2Fam%3DIQ%2Frt%3Dj%2Fd%3D1%2Ft%3Dzcms%2Frs%3DAItRSTPoMDNZYsbhLrpsdslX9ONNmyeJqw#_methods=onPlusOne%2C_ready%2C_close%2C_open%2C_resizeMe%2C_renderstart%2Concircled%2Cdrefresh%2Cerefresh%2Conload&amp;id=I0_1392069832614&amp;parent=http%3A%2F%2Frent1demo.lexcorp.ca&amp;pfname=&amp;rpctoken=26872541"
						name="I0_1392069832614" id="I0_1392069832614" vspace="0"
						tabindex="0"
						style="position: static; top: 0px; width: 90px; margin: 0px; border-style: none; left: 0px; visibility: visible; height: 20px;"
						marginwidth="0" marginheight="0" hspace="0" scrolling="no"
						width="100%" frameborder="0"></iframe>
				</div>
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



	<iframe
		style="width: 1px; height: 1px; position: absolute; top: -100px;"
		src="https://accounts.google.com/o/oauth2/postmessageRelay?parent=http%3A%2F%2Frent1demo.lexcorp.ca#rpctoken=775803882&amp;forcesecure=1"
		id="oauth2relay897585591" name="oauth2relay897585591"></iframe>
</body>
<iframe src="" style="display: none;"></iframe>