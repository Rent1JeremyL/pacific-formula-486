<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.rent1.entity.User"%>
<%@page import="com.rent1.dao.UserDao"%>

<head>
<meta charset="utf-8">
<title>RENT1 - template</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="webincludes/css/bootstrap.css">
<link rel="stylesheet" href="webincludes/css/style.css">
<link rel="stylesheet" href="webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="webincludes/css/rent1.css">

<link rel="icon" type="image/png" href="favicon.ico">
</head>
<body>

<%@include file='/header.jsp' %>

	<p>Just a template</p>
	<footer class="container">
		<div class="row">
			<div class="span3">
				<img src="/webincludes/img/rent1-logo-gray.png" class="logo">
				<p>
					Copyright © 2013 RENT1.<br> All rights reserved.
				</p>
			</div>
			<div class="span3">
				<h2>Contact</h2>
				<ul class="menu nav">
					<li class="first leaf"><a title="" href="#">Email Us</a></li>
					<li class="leaf"><a title="" href="#">Help &amp; Support</a></li>
				</ul>
			</div>
		</div>
	</footer>
	<!-- javascript load bootstrap elements
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