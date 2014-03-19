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

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">

<link rel="icon" type="image/png" href="/favicon.ico">
<!-- javascript load bootstrap elements =============== -->
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ================================================== -->	
<script type='text/javascript'>
	function editPass(on) {
		if (on == 1) {
			document.getElementById("view-pass").style.display = 'none';
			document.getElementById("change-pass").style.display = 'block';
			document.getElementById("edit-pass").required = !this.checked;
			document.getElementById("edit-pass-new").required = !this.checked;
			document.getElementById("edit-pass-con").required = !this.checked;
		} else {
			document.getElementById("view-pass").style.display = 'block';
			document.getElementById("change-pass").style.display = 'none';
			document.getElementById("edit-pass-new").value = '';
			document.getElementById("edit-pass-con").value = '';
			document.getElementById("edit-pass").required = this.checked;
			document.getElementById("edit-pass-new").required = this.checked;
			document.getElementById("edit-pass-con").required = this.checked;
		}
	}
</script>
</head>
<body>
<%@include file='/WEB-INF/jsp/header.jsp' %>
	<%
		// Protected JSP - Leave now
		if (user == null) {
			request.getRequestDispatcher("denied.html").forward(request, response);
			return;
		}
	%>
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
							type="text" value="<%=user.getNickName()%>" required>
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
							*Password: <a onclick="editPass(0)" style="font-weight: normal">
								cancel </a>
						</dt>
						<dd class="prof_input_right">
							<input id="edit-pass" name="edit-pass"
								class="input-large placeholder-input has-text" type="password"
								value="">
						</dd>
					</dl>
					<dl>
						<dt class="prof_h1_left">*New:</dt>
						<dd class="prof_input_right">
							<input id="edit-pass-new" name="edit-pass-new"
								class="input-large placeholder-input has-text" type="password"
								value="">
						</dd>
					</dl>
					<dl>
						<dt class="prof_h1_left">*Confirm:</dt>
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
					style="margin-left: 180px;" type="submit">Save Changes</button>
			</div>
			<br>
		</form>
	</div>
<%@include file='/WEB-INF/jsp/footer.jsp' %>
</body>