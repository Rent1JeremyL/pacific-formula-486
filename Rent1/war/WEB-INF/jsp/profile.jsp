<%@page import="com.google.appengine.api.datastore.Transaction"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.rent1.entity.User"%>
<%@page import="com.rent1.dao.UserDao"%>

<head>
<meta charset="utf-8">
<title>RENT1 - Profile</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="webincludes/css/bootstrap.css">
<link rel="stylesheet" href="webincludes/css/style.css">
<link rel="stylesheet" href="webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="webincludes/css/rent1.css">

<link rel="icon" type="image/png" href="favicon.ico">
<script type='text/javascript'>
	function editPass(on) {
		if (on == 1) {
			document.getElementById("view-pass").style.display = 'none';
			document.getElementById("change-pass").style.display = 'block';
		} else {
			document.getElementById("view-pass").style.display = 'block';
			document.getElementById("change-pass").style.display = 'none';
			document.getElementById("edit-pass-new").value = '';
			document.getElementById("edit-pass-con").value = '';
		}
	}
</script>
</head>
<body>
	<%
		User user = null;
		user = (User) session.getAttribute("user");
		// Protected JSP - Leave now
		if (user == null) {
			request.getRequestDispatcher("denied.html").forward(request, response);
			return;
		}
	%>
	<header class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<%
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
			</div>
		</div>
	</header>
	<div id="profile" class="profile_box_inset"
		style="background-color: #EEEEEE">
		<form action="/save-profile" method="post">
			<div class="section-title_h">
				<h3 id="h3-name">
					<%=user.getNickName()%>'s Profile
				</h3>
			</div>
			<div class="section-title_h">
				<h4
					class="blocksubhead subsectionhead userprof_headers userprof_headers_border">Basic
					Information</h4>
			</div>
			<div class="control-group">
				<dl>
					<dt class="prof_h1_left">Email Address:</dt>
					<dd class="prof_input_right">
						<input id="signup-email" name="signup-email"
							class="input-large placeholder-input has-text" type="text"
							disabled="disabled" value="<%=user.getEmail()%>">
					</dd>
				</dl>
				<dl>
					<dt class="prof_h1_left">Nickname:</dt>
					<dd class="prof_input_right">
						<input id="prof-nickname" name="prof-nickname" class="input-large"
							type="text" value="<%=user.getNickName()%>">
					</dd>
				</dl>
				<%
					// Allow password edits only if not linked to Google	
					if (user.getGoogleId() == null) {
				%>
				<div id="view-pass" class="control" style="display: block;">
					<dl>
						<dt class="prof_h1_left">
							Password: <a onclick="editPass(1)" style="font-weight: normal">
								change </a>
						</dt>
						<dd class="prof_input_right">
							<input id="prof-pass" name="prof-pass"
								class="input-large placeholder-input has-text" type="password"
								disabled="disabled" value="********">
						</dd>
					</dl>
				</div>
				<div id="change-pass" class="control" style="display: none;">
					<dl>
						<dt class="prof_h1_left">
							Password: <a onclick="editPass(0)" style="font-weight: normal">
								cancel </a>
						</dt>
						<dd class="prof_input_right">
							<input id="edit-pass" name="edit-pass"
								class="input-large placeholder-input has-text" type="password"
								value="">
						</dd>
					</dl>
					<dl>
						<dt class="prof_h1_left">New</dt>
						<dd class="prof_input_right">
							<input id="edit-pass-new" name="edit-pass-new"
								class="input-large placeholder-input has-text" type="password"
								value="">
						</dd>
					</dl>
					<dl>
						<dt class="prof_h1_left">Confirm</dt>
						<dd class="prof_input_right">
							<input id="edit-pass-con" name="edit-pass-con"
								class="input-large placeholder-input has-text" type="password"
								value="">
						</dd>
					</dl>
				</div>
				<%
					}
				%><dl>
					<dt class="prof_h1_left">First Name:</dt>
					<dd class="prof_input_right">
						<input id="prof-first" name="prof-first"
							class="input-large placeholder-input has-text" type="text"
							value="<%=user.getFirstName()%>"></input>
					</dd>
				</dl>
				<dl>
					<dt class="prof_h1_left">Last Name:</dt>
					<dd class="prof_input_right">
						<input id="prof-last" name="prof-last"
							class="input-large placeholder-input has-text" type="text"
							value="<%=user.getLastName()%>"></input>
					</dd>
				</dl>
				<button id="saveBtn" class="btn btn-primary right"
					style="margin-left: 280px;" type="submit">Save Changes</button>
			</div>
		</form>
	</div>
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