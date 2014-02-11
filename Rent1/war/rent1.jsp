<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
<meta charset="utf-8">
<title>RENT1</title>
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

<style type="text/css">
.fb_hidden {
	position: absolute;
	top: -10000px;
	z-index: 10001
}

.fb_invisible {
	display: none
}

.fb_reset {
	background: none;
	border: 0;
	border-spacing: 0;
	color: #000;
	cursor: auto;
	direction: ltr;
	font-family: "lucida grande", tahoma, verdana, arial, sans-serif;
	font-size: 11px;
	font-style: normal;
	font-variant: normal;
	font-weight: normal;
	letter-spacing: normal;
	line-height: 1;
	margin: 0;
	overflow: visible;
	padding: 0;
	text-align: left;
	text-decoration: none;
	text-indent: 0;
	text-shadow: none;
	text-transform: none;
	visibility: visible;
	white-space: normal;
	word-spacing: normal
}

.fb_reset>div {
	overflow: hidden
}

.fb_link img {
	border: none
}

.fb_dialog {
	background: rgba(82, 82, 82, .7);
	position: absolute;
	top: -10000px;
	z-index: 10001
}

.fb_dialog_advanced {
	padding: 10px;
	-moz-border-radius: 8px;
	-webkit-border-radius: 8px;
	border-radius: 8px
}

.fb_dialog_content {
	background: #fff;
	color: #333
}

.fb_dialog_close_icon {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/yq/r/IE9JII6Z1Ys.png)
		no-repeat scroll 0 0 transparent;
	_background-image:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/yL/r/s816eWC-2sl.gif);
	cursor: pointer;
	display: block;
	height: 15px;
	position: absolute;
	right: 18px;
	top: 17px;
	width: 15px;
	top: 8px\9;
	right: 7px\9
}

.fb_dialog_mobile .fb_dialog_close_icon {
	top: 5px;
	left: 5px;
	right: auto
}

.fb_dialog_padding {
	background-color: transparent;
	position: absolute;
	width: 1px;
	z-index: -1
}

.fb_dialog_close_icon:hover {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/yq/r/IE9JII6Z1Ys.png)
		no-repeat scroll 0 -15px transparent;
	_background-image:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/yL/r/s816eWC-2sl.gif)
}

.fb_dialog_close_icon:active {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/yq/r/IE9JII6Z1Ys.png)
		no-repeat scroll 0 -30px transparent;
	_background-image:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/yL/r/s816eWC-2sl.gif)
}

.fb_dialog_loader {
	background-color: #f2f2f2;
	border: 1px solid #606060;
	font-size: 24px;
	padding: 20px
}

.fb_dialog_top_left,.fb_dialog_top_right,.fb_dialog_bottom_left,.fb_dialog_bottom_right
	{
	height: 10px;
	width: 10px;
	overflow: hidden;
	position: absolute
}

.fb_dialog_top_left {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/ye/r/8YeTNIlTZjm.png)
		no-repeat 0 0;
	left: -10px;
	top: -10px
}

.fb_dialog_top_right {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/ye/r/8YeTNIlTZjm.png)
		no-repeat 0 -10px;
	right: -10px;
	top: -10px
}

.fb_dialog_bottom_left {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/ye/r/8YeTNIlTZjm.png)
		no-repeat 0 -20px;
	bottom: -10px;
	left: -10px
}

.fb_dialog_bottom_right {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/ye/r/8YeTNIlTZjm.png)
		no-repeat 0 -30px;
	right: -10px;
	bottom: -10px
}

.fb_dialog_vert_left,.fb_dialog_vert_right,.fb_dialog_horiz_top,.fb_dialog_horiz_bottom
	{
	position: absolute;
	background: #525252;
	filter: alpha(opacity = 70);
	opacity: .7
}

.fb_dialog_vert_left,.fb_dialog_vert_right {
	width: 10px;
	height: 100%
}

.fb_dialog_vert_left {
	margin-left: -10px
}

.fb_dialog_vert_right {
	right: 0;
	margin-right: -10px
}

.fb_dialog_horiz_top,.fb_dialog_horiz_bottom {
	width: 100%;
	height: 10px
}

.fb_dialog_horiz_top {
	margin-top: -10px
}

.fb_dialog_horiz_bottom {
	bottom: 0;
	margin-bottom: -10px
}

.fb_dialog_iframe {
	line-height: 0
}

.fb_dialog_content .dialog_title {
	background: #6d84b4;
	border: 1px solid #3b5998;
	color: #fff;
	font-size: 14px;
	font-weight: bold;
	margin: 0
}

.fb_dialog_content .dialog_title>span {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/yd/r/Cou7n-nqK52.gif)
		no-repeat 5px 50%;
	float: left;
	padding: 5px 0 7px 26px
}

body.fb_hidden {
	-webkit-transform: none;
	height: 100%;
	margin: 0;
	overflow: visible;
	position: absolute;
	top: -10000px;
	left: 0;
	width: 100%
}

.fb_dialog.fb_dialog_mobile.loading {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/ya/r/3rhSv5V8j3o.gif) white
		no-repeat 50% 50%;
	min-height: 100%;
	min-width: 100%;
	overflow: hidden;
	position: absolute;
	top: 0;
	z-index: 10001
}

.fb_dialog.fb_dialog_mobile.loading.centered {
	max-height: 590px;
	min-height: 590px;
	max-width: 500px;
	min-width: 500px
}

#fb-root #fb_dialog_ipad_overlay {
	background: rgba(0, 0, 0, .45);
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	min-height: 100%;
	z-index: 10000
}

#fb-root #fb_dialog_ipad_overlay.hidden {
	display: none
}

.fb_dialog.fb_dialog_mobile.loading iframe {
	visibility: hidden
}

.fb_dialog_content .dialog_header {
	-webkit-box-shadow: white 0 1px 1px -1px inset;
	background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#738ABA),
		to(#2C4987));
	border-bottom: 1px solid;
	border-color: #1d4088;
	color: #fff;
	font: 14px Helvetica, sans-serif;
	font-weight: bold;
	text-overflow: ellipsis;
	text-shadow: rgba(0, 30, 84, .296875) 0 -1px 0;
	vertical-align: middle;
	white-space: nowrap
}

.fb_dialog_content .dialog_header table {
	-webkit-font-smoothing: subpixel-antialiased;
	height: 43px;
	width: 100%
}

.fb_dialog_content .dialog_header td.header_left {
	font-size: 12px;
	padding-left: 5px;
	vertical-align: middle;
	width: 60px
}

.fb_dialog_content .dialog_header td.header_right {
	font-size: 12px;
	padding-right: 5px;
	vertical-align: middle;
	width: 60px
}

.fb_dialog_content .touchable_button {
	background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#4966A6),
		color-stop(0.5, #355492), to(#2A4887));
	border: 1px solid #29447e;
	-webkit-background-clip: padding-box;
	-webkit-border-radius: 3px;
	-webkit-box-shadow: rgba(0, 0, 0, .117188) 0 1px 1px inset,
		rgba(255, 255, 255, .167969) 0 1px 0;
	display: inline-block;
	margin-top: 3px;
	max-width: 85px;
	line-height: 18px;
	padding: 4px 12px;
	position: relative
}

.fb_dialog_content .dialog_header .touchable_button input {
	border: none;
	background: none;
	color: #fff;
	font: 12px Helvetica, sans-serif;
	font-weight: bold;
	margin: 2px -12px;
	padding: 2px 6px 3px 6px;
	text-shadow: rgba(0, 30, 84, .296875) 0 -1px 0
}

.fb_dialog_content .dialog_header .header_center {
	color: #fff;
	font-size: 16px;
	font-weight: bold;
	line-height: 18px;
	text-align: center;
	vertical-align: middle
}

.fb_dialog_content .dialog_content {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/y9/r/jKEcVPZFk-2.gif)
		no-repeat 50% 50%;
	border: 1px solid #555;
	border-bottom: 0;
	border-top: 0;
	height: 150px
}

.fb_dialog_content .dialog_footer {
	background: #f2f2f2;
	border: 1px solid #555;
	border-top-color: #ccc;
	height: 40px
}

#fb_dialog_loader_close {
	float: left
}

.fb_dialog.fb_dialog_mobile .fb_dialog_close_button {
	text-shadow: rgba(0, 30, 84, .296875) 0 -1px 0
}

.fb_dialog.fb_dialog_mobile .fb_dialog_close_icon {
	visibility: hidden
}

.fb_iframe_widget {
	display: inline-block;
	position: relative
}

.fb_iframe_widget span {
	display: inline-block;
	position: relative;
	text-align: justify
}

.fb_iframe_widget iframe {
	position: absolute
}

.fb_iframe_widget_lift {
	z-index: 1
}

.fb_hide_iframes iframe {
	position: relative;
	left: -10000px
}

.fb_iframe_widget_loader {
	position: relative;
	display: inline-block
}

.fb_iframe_widget_fluid {
	display: inline
}

.fb_iframe_widget_fluid span {
	width: 100%
}

.fb_iframe_widget_loader iframe {
	min-height: 32px;
	z-index: 2;
	zoom: 1
}

.fb_iframe_widget_loader .FB_Loader {
	background:
		url(http://static.ak.fbcdn.net/rsrc.php/v2/y9/r/jKEcVPZFk-2.gif)
		no-repeat;
	height: 32px;
	width: 32px;
	margin-left: -16px;
	position: absolute;
	left: 50%;
	z-index: 4
}

.fb_connect_bar_container div,.fb_connect_bar_container span,.fb_connect_bar_container a,.fb_connect_bar_container img,.fb_connect_bar_container strong
	{
	background: none;
	border-spacing: 0;
	border: 0;
	direction: ltr;
	font-style: normal;
	font-variant: normal;
	letter-spacing: normal;
	line-height: 1;
	margin: 0;
	overflow: visible;
	padding: 0;
	text-align: left;
	text-decoration: none;
	text-indent: 0;
	text-shadow: none;
	text-transform: none;
	visibility: visible;
	white-space: normal;
	word-spacing: normal;
	vertical-align: baseline
}

.fb_connect_bar_container {
	position: fixed;
	left: 0 !important;
	right: 0 !important;
	height: 42px !important;
	padding: 0 25px !important;
	margin: 0 !important;
	vertical-align: middle !important;
	border-bottom: 1px solid #333 !important;
	background: #3b5998 !important;
	z-index: 99999999 !important;
	overflow: hidden !important
}

.fb_connect_bar_container_ie6 {
	position: absolute;
	top: expression(document.compatMode == "CSS1Compat" ?  
		 document.documentElement.scrollTop + "px" : body.scrollTop + "px")
}

.fb_connect_bar {
	position: relative;
	margin: auto;
	height: 100%;
	width: 100%;
	padding: 6px 0 0 0 !important;
	background: none;
	color: #fff !important;
	font-family: "lucida grande", tahoma, verdana, arial,
		sans-serif !important;
	font-size: 13px !important;
	font-style: normal !important;
	font-variant: normal !important;
	font-weight: normal !important;
	letter-spacing: normal !important;
	line-height: 1 !important;
	text-decoration: none !important;
	text-indent: 0 !important;
	text-shadow: none !important;
	text-transform: none !important;
	white-space: normal !important;
	word-spacing: normal !important
}

.fb_connect_bar a:hover {
	color: #fff
}

.fb_connect_bar .fb_profile img {
	height: 30px;
	width: 30px;
	vertical-align: middle;
	margin: 0 6px 5px 0
}

.fb_connect_bar div a,.fb_connect_bar span,.fb_connect_bar span a {
	color: #bac6da;
	font-size: 11px;
	text-decoration: none
}

.fb_connect_bar .fb_buttons {
	float: right;
	margin-top: 7px
}

.fbpluginrecommendationsbarleft,.fbpluginrecommendationsbarright {
	position: fixed !important;
	bottom: 0;
	z-index: 999
}

.fbpluginrecommendationsbarleft {
	left: 10px
}

.fbpluginrecommendationsbarright {
	right: 10px
}
</style>
</head>
<body>

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
				<a href="/" class="logo"><img src="img/logo.png"></a>
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

	<div class="jumbotron masthead home bg-img">
		<div class="container">
			<h1>Find your equipment.</h1>
			<h3>Rent from over 1,421 cities across North America.</h3>
			<form class="form-horizontal find-equipment well">
				<fieldset>
					<div class="rental-wrap wrap span3">
						<input id="rental" name="rental"
							placeholder="What are you renting?" type="text"> <span
							class="icon-wrench"></span>
					</div>
					<div class="location-wrap wrap span3">
						<input id="location" name="location"
							placeholder="Where do you need it?" type="text"> <span
							class="icon-map-marker"></span>
					</div>
					<div class="rentstart wrap span2">
						<input id="rentstart" name="rentstart" placeholder="29-06-2013"
							type="text"> <span class="icon-calendar"></span>
					</div>
					<div class="rentend wrap span2">
						<input id="rentend" name="rentend" placeholder="29-06-2013"
							type="text"> <span class="icon-calendar"></span>
					</div>
					<!-- <button id="submit" class="btn btn-primary" type="submit" href="/search.html">
                <i class="icon icon-search"></i> Search
            </button> -->
					<a class="btn btn-primary" href="/search.jsp"><i
						class="icon icon-search"></i> Search</a>
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
					<ul>
						<li><a href="#">Aerial Work Platforms</a></li>
						<li><a href="#">Air Compressors &amp; Air Tools</a></li>
						<li><a href="#">Compaction</a></li>
						<li><a href="#">Concrete &amp; Masonry</a></li>
						<li><a href="#">Earthmoving Equipment</a></li>
						<li><a href="#">Forklifts &amp; Material Handling</a></li>
						<li><a href="#">Light Towers &amp; Generators</a></li>
						<li><a href="#">Plumbing &amp; Pipes</a></li>
					</ul>
				</div>
				<div class="span4">
					<ul>
						<li><a href="#">Plumbing &amp; Pipes</a></li>
						<li><a href="#">Power &amp; HVAC</a></li>
						<li><a href="#">Power Tools &amp; Surveying</a></li>
						<li><a href="#">Pressure Washers &amp; Pumps</a></li>
						<li><a href="#">Surface Preparation</a></li>
						<li><a href="#">Trench Safety &amp; Shoring</a></li>
						<li><a href="#">Vehicles &amp; Traffic Control</a></li>
						<li><a href="#">Welders</a></li>
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
						src="img/biggest-equipment-selection.png">
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
					<img class="competitive-pricing" src="img/competitive-pricing.png">
				</div>
			</div>
			<div class="platform wrap">
				<div class="container">
					<img class="quickest-simplest-platform"
						src="img/quickest-simplest-platform.png">
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
				<img src="img/rent1-logo-gray.png" class="logo">
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
	<!--script
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
	</script-->



	<iframe
		style="width: 1px; height: 1px; position: absolute; top: -100px;"
		src="https://accounts.google.com/o/oauth2/postmessageRelay?parent=http%3A%2F%2Frent1demo.lexcorp.ca#rpctoken=775803882&amp;forcesecure=1"
		id="oauth2relay897585591" name="oauth2relay897585591"></iframe>
</body>
<iframe src="" style="display: none;"></iframe>