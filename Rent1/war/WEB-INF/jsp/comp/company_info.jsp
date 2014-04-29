<%@page import="com.rent1.dao.OfficeDao"%>
<%@page import="com.rent1.entity.Company"%>
<%@page import="com.rent1.entity.User"%>
<%@page import="com.rent1.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="com.rent1.entity.Office"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>

<head>
<meta charset="utf-8">
<title>RENT1 - Company Profile</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">
<!-- START Tab Content -->
<link rel="stylesheet" href="/webincludes/css/tabcontent3.css">
<!-- END Tab Content -->
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
	<%
		// Protected JSP - Leave now
		if (user == null) {
			request.getRequestDispatcher("denied.html").forward(request,
					response);
			return;
		}
		Company comp = user.getCompany();
	%>
	<div class="content" style="background: #D8D8D8;">
		<div class="jumbotron home bg-img"></div>
		<div class="det_container box_outset">
			<div id="profile">
				<div class="section-title_h">
					<h3 class="title_green">
						<%=comp.getName()%>
					</h3>
				</div>
				<br>
				<%
					List<Office> offices = OfficeDao.INSTANCE.getOfficesByCompany(comp);
				%>
				<ul class="tabs" data-persist="true">
					<li><span class="tab_select">Company Information</span></li>
					<li><a href="/company/offices">Office Information</a></li>
					<%
						if (offices.size() != 0) {
					%>
					<li><a href="/company/equipment">Equipment</a></li>
					<li><a href="/company/equipment/add">Add Equipment</a></li>
					<%
						}
					%>
				</ul>
				<div class="control-group tabcontents">
					<div id="cTab1">
						<form action="/#" method="post">
							<dl>
								<dt class="prof_h1_left">Email Address:</dt>
								<dd class="prof_input_right">
									<input id="profcomp-email" name="profcomp-email"
										class="input-large placeholder-input has-text" type="text"
										value="<%=comp.getEmail()%>" required>
								</dd>
							</dl>
							<dl>
								<dt class="prof_h1_left">Phone Number:</dt>
								<dd class="prof_input_right">
									<input id="profcomp-phone" name="profcomp-phone"
										class="input-large" type="tel"
										value="<%=comp.getPhoneNumber()%>" required>
								</dd>
							</dl>
							<dl>
								<dt class="prof_h1_left">Fax Number:</dt>
								<dd class="prof_input_right">
									<input id="profcomp-fax" name="profcomp-fax"
										class="input-large placeholder-input has-text" type="tel"
										value="<%=comp.getFaxNumber()%>"></input>
								</dd>
							</dl>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>