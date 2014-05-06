<%@page contentType="text/html;charset=UTF-8" language="java"%>
<head>
<meta charset="utf-8">
<title>RENT1 - Rental Requirements</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">
<link rel="icon" type="image/png" href="/favicon.ico">
<!-- ==== START [load bootstrap elements] ========== -->
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="/webincludes/js/bootstrap.min.js"></script>
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
		<div class="jumbotron home bg-img"></div>
		<div class="det_container box_outset">
			<div>
				<div class="section-title_h">
					<h3 class="title_green">Rental Requirements</h3>
				</div>
				<br>
				<div style="margin-left: 30px; color: black;">
					<p>The following are the Rent1 requirements for renting from
						our site:</p>
					<ul>
						<li>You must have a Rent1 user account and be logged in</li>
						<li>Your user account must be <a href="#">Rent1 Verified</a></li>
						<li>You must have completed the address portion of your user
							profile</li>
					</ul>
					<p>
						Please ensure you have completed all of the above steps. If you
						have fullfilled the requirements and are still having trouble
						contact our <a href="#">Customer Support</a>.
					</p>
					<br>
					<div class="section-title_h" style="padding: 10px 20px">
						<a href="/"> back </a>
					</div>
					<br>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>