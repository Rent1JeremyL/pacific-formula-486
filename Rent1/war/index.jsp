<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.rent1.entity.User"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.rent1.factory.CategoryFactory"%>
<%@ page import="com.rent1.reference.Category"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>

<head>
<meta charset="utf-8">
<title>RENT1</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">

<!-- ==== START [Ajax Datepicker] -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- ==== END [Ajax Datepicker] -->
<!-- ==== START [load bootstrap elements] ========== -->
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ==== END ====================================== -->	
<!-- ==== START [Google Map Engine] -->
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
<!-- ==== END [Google Map Engine] -->
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
		});
	</script>
<%@include file='/WEB-INF/jsp/header.jsp' %>
<!-- ======== javascript create AutoComplete by Categories ======== -->
<script>
<%
String secCatas = CategoryFactory.getInstance().getAllSecondayCatagoriesToJSArray();
%>
$(function() {
	var availableTags = [<%=secCatas%>];
	$( "#rental" ).autocomplete({
		source: availableTags
	});
});
</script>
	<div class="jumbotron masthead home bg-img">
		<div class="container">
			<h1>Find your equipment.</h1>
			<h3>Rent from over 1,421 cities across North America.</h3>
			<div style="color: #FF0000;">${errorMessage}</div>
			<form class="form-horizontal well" method='POST'
				action='/search'>
				<fieldset>
					<div class="rental-wrap wrap span3">
 			            <input id="rental" name="rental" placeholder="What are you renting?" type="text" required>
						<span class="icon-wrench"></span>
					</div>
					<div class="location-wrap wrap span3">
						<input id="location" name="location"
							placeholder="Where do you need it?" onFocus="geolocate()"
							type="text" required>
						<span class="icon-map-marker"></span>
					</div>
					<div class="wrap span2">
						<input id="rentstart" name="rentstart" placeholder="Start Date"
							type="text" required><span class="icon-calendar"></span>
					</div>
					<div class="wrap span2">
						<input id="rentend" name="rentend" placeholder="End Date"
							type="text" required><span class="icon-calendar"></span>
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
					construction tool rentals that show cases available offerings by
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
<%@include file='/WEB-INF/jsp/footer.jsp' %>	
</body>